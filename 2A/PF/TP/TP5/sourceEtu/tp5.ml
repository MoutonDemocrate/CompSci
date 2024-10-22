type env = (string*int) list

(* Module abstrayant les expressions *)
module type ExprSimple =
sig
  type t
  val const : int -> t
  val plus : t -> t -> t
  val mult : t-> t -> t
end

module type ExprVar =
sig
  type t
  val def: (string*t) -> t -> t
  val var: string -> t
end

module type Expr =
sig
  include ExprSimple
  include (ExprVar with type t := t)
end


(* Module réalisant l'évaluation d'une expression *)
module EvalSimple : ExprSimple with type t = int =
struct
  type t = int
  let const c = c
  let plus e1 e2 = e1 + e2
  let mult e1 e2 = e1 * e2
end

module EvalSimpleEnv : ExprSimple with type t = env -> int =
struct
  type t = env -> int
  let const c = fun _ -> c
  let plus e1 e2 = fun env -> e1 env + e2 env
  let mult e1 e2 = fun env -> e1 env * e2 env
end

module EvalVar : ExprVar with type t = env -> int =
struct
  type t = env -> int
  let def (name,e1) e2 = fun env -> e2 ((name,e1 env)::env)
  let var name = fun env -> List.assoc name env
end

module Eval : Expr with type t = env -> int =
struct
  include EvalSimpleEnv
  include EvalVar
end

(* Module réalisant l'affichage et la conversion en chaînes de charactères *)
module PrintSimple : ExprSimple with type t = string =
struct
  type t = string
  let const e = string_of_int e
  let plus e1 e2 = "(" ^ e1 ^ "+" ^ e2 ^ ")"
  let mult e1 e2 = "(" ^ e1 ^ "*" ^ e2 ^ ")"
end

module PrintVar : ExprVar with type t = string =
struct
  type t = string
  let def (name,e1) e2 = "let " ^ name ^ " = " ^ e1 ^ " in " ^ e2
  let var name = name
end

module Print : Expr with type t = string =
struct
  include PrintSimple
  include (PrintVar : ExprVar with type t := t)
end

module CompteSimple : ExprSimple with type t = int =
struct
  type t = int
  let const _ = 0
  let plus e1 e2 = e1 + e2 + 1
  let mult e1 e2 = e1 + e2 + 1
end

(* Solution 1 pour tester *)
(* A l'aide de foncteur *)

(* Définition des expressions *)
module ExemplesSimples (E:ExprSimple) =
struct
  (* 1+(2*3) *)
  let exemple1  = E.(plus (const 1) (mult (const 2) (const 3)) )
  (* (5+2)*(2*3) *)
  let exemple2 =  E.(mult (plus (const 5) (const 2)) (mult (const 2) (const 3)) )
end

module Exemples (E:Expr) =
struct
  (* 1+(2*3) *)
  let exemple_b1  = E.(plus (const 1) (mult (const 2) (const 3)) )
  (* (5+2)*(2*3) *)
  let exemple_b2 =  E.(mult (plus (const 5) (const 2)) (mult (const 2) (const 3)) )
 (* let x = (7+9) in (x*3) *)
  let exemple1 = E.(def ("x",(plus (const 7) (const 9))) (mult (var "x") (const 3)))
  (* let x = 2 in let y = 13 in (x+y) *)
  let exemple2 = E.(def ("x",(const 2)) (def ("y",(const 13)) (plus (var "x") (var "y"))))
end

module ExemplesEnv (E:Expr) =
struct
  (* 1+(2*3) *)
  let exemple_b1  = E.(plus (const 1) (mult (const 2) (const 3)) )
  (* (5+2)*(2*3) *)
  let exemple_b2 =  E.(mult (plus (const 5) (const 2)) (mult (const 2) (const 3)) )
 (* let x = (7+9) in (x*3) *)
  let exemple1 = E.(def ("x",(plus (const 7) (const 9))) (mult (var "x") (const 3)))
  (* let x = 2 in let y = 13 in (x+y) *)
  let exemple2 = E.(def ("x",(const 2)) (def ("y",(const 13)) (plus (var "x") (var "y"))))
end

(* Module d'évaluation des exemples *)
module EvalSExmeples =  ExemplesSimples (EvalSimple)
module PrintSExemples = ExemplesSimples (PrintSimple)
module CompteSExemples = ExemplesSimples (CompteSimple)

let%test _ = (EvalSExmeples.exemple1 = 7)
let%test _ = (EvalSExmeples.exemple2 = 42)

let%test _ = (PrintSExemples.exemple1 = "(1+(2*3))")
let%test _ = (PrintSExemples.exemple1 = "((5+2)*(2*3))")

let%test _ = (CompteSExemples.exemple1 = 2)
let%test _ = (CompteSExemples.exemple1 = 3)


module PrintExemples = Exemples (Print)

let%test _ = (PrintExemples.exemple_b1 = "(1+(2*3))")
let%test _ = (PrintExemples.exemple_b1 = "((5+2)*(2*3))")
let%test _ = (PrintExemples.exemple1 = "let x = (7+9) in (x*3)")
let%test _ = (PrintExemples.exemple2 = "let x = 2 in let y = 13 in (x+y)")


module EvalEnvExmeples =  ExemplesEnv (Eval)

let%test _ = (EvalEnvExmeples.exemple_b1 [] = 7)
let%test _ = (EvalEnvExmeples.exemple_b1 [] = 42)
let%test _ = (EvalEnvExmeples.exemple1 [] = 48)
let%test _ = (EvalEnvExmeples.exemple2 [] = 15)