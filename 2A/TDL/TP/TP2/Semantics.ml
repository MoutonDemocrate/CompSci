(* Analyseur sémantique *)
open Ast

(* ===============================================*)
(* Définition du type des erreurs *)
type errorType =
  | UnknownIdentError of string
  | UnknownReferenceError of string
  | TypeMismatchError
  | RuntimeError
  | UndefinedExpressionError
;;

(* ===============================================*)
(* Définition du type des valeurs renvoyées par l'interprète *)
type valueType =
  | FrozenValue of (ast * environment)
  | IntegerValue of int
  | BooleanValue of bool
  | ReferenceValue of string
  | NullValue
  | ErrorValue of errorType
and
  environment = (string * valueType) list
and
  memory = (string * valueType) list
;;

(* ===============================================*)
(* string_of_names : string list -> string *)
(* Converti une liste de chaînes de caractères en une seule chaîne de caractères *)
let string_of_names names =
	List.fold_right (fun t tq -> t ^ " " ^ tq ) names "";;


(* string_of_env : environment -> string *)
(* Convertit un environnement en une chaine de caractères en vue de son affichage *)
let rec string_of_env env =
  match env with
  | [] -> ""
  | (key,value)::q -> (key ^ "," ^ (string_of_value value)) ^ ";" ^ (string_of_env q)
(* string_of_mem : memory -> string *)
(* Convertit une mémoire en une chaine de caractères en vue de son affichage *)
and string_of_mem mem =
  match mem with
  | [] -> ""
  | (key,value)::q -> (key ^ "," ^ (string_of_value value)) ^ ";" ^ (string_of_mem q)
(* string_of_value : valueType -> string *)
(* Convertit une valueType en une chaine de caractères en vue de son affichage *)
and string_of_value value =
  match value with
    | (FrozenValue (expr,env)) -> ((string_of_ast expr) ^ (string_of_env env))
    | (IntegerValue value) -> (string_of_int value)
    | (BooleanValue value) -> (if (value) then "true" else "false")
    | ReferenceValue value -> ("ref " ^ value)
    | NullValue -> "()"
    | (ErrorValue error) -> (string_of_error error)
(* string_of_value_and_mem : (valueType * memory) -> string *)
(* Convertit une valueType en une chaine de caractères en vue de son affichage *)
and string_of_value_and_mem vm =
    ( "Valeur = " ^ (string_of_value (fst vm))
      ^ "\nMemoire = " ^ string_of_mem (snd vm) )
(* string_of_error : errorType -> string *)
(* Convertit une erreur en une chaine de caractères en vue de son affichage *)
and string_of_error error =
  match error with
    | (UnknownIdentError name) -> "Unknown ident : " ^ name
    | (UnknownReferenceError name) -> "Unknown ident : " ^ name
    | RuntimeError -> "Runtime error"
    | TypeMismatchError -> "Type mismatch"
    | UndefinedExpressionError -> "Undefined Expression"

;;

(* ===============================================*)
type 'a searchResult =
  | NotFound
  | Found of 'a;;

(* lookfor : string -> environment -> valueType searchResult *)
(* Cherche un identifiant dans un environnement et renvoie la valeur associée à cet identifiant ou une erreur le cas échéant *)
let rec lookforEnv name env =
  match env with
    | [] -> NotFound
    | (key,value) :: others ->
      (if (key = name) then (Found value) else (lookforEnv name others));;

(* lookfor : string -> memory -> valueType searchResult *)
(* Cherche une adresse dans une mémoire et renvoie la valeur associée à cette adresse ou une erreur le cas échéant *)
let rec lookforMem name env =
  match env with
    | [] -> NotFound
    | (key,value) :: others ->
      (if (key = name) then (Found value) else (lookforMem name others));;

(* ........................................................................*)
(*   newReference : string                                                 *)
(*     alloue une adresse dans la memoire de la forme "ref@i"              *)
(* ........................................................................*)
let referenceCounter = ref 0;;

let newReference () =
  (referenceCounter := (! referenceCounter) + 1);
  ("ref@" ^ (string_of_int (! referenceCounter)));;

(* .............................................................................*)
(*   value_of_expr : (Ast.ast * memory) -> environment                          *)
(*       -> (ValueType * memory)                                                *)
(* Calcule la valeur d'une expression dans un environnement et une memoire      *)
(* donnés. Le nouvel etat de la memoire est fourni en sortie avec la valeur.    *)
(* Chaque expression est evaluée par une fonction ruleXXX differente codant     *)
(* la ou les regles d'inference assoiciées                                      *)
(* .............................................................................*)

let rec value_of_expr (expr,mem) env =
  match expr with
    | (FunctionNode (_,_)) -> ruleFunction env expr mem
    | (CallNode (fexpr,pexpr)) -> ruleCallByValue env fexpr pexpr mem
(*
    | (CallNode (fexpr,pexpr)) -> ruleCallByName env fexpr pexpr mem
    *)
    | (IfthenelseNode (cond,bthen,belse)) -> ruleIf env cond bthen belse mem
    | (LetNode (ident,bvalue,bin)) -> ruleLet env ident bvalue bin mem
    | (LetrecNode (ident,bvalue,bin)) -> ruleLetrec env ident bvalue bin mem
    | (AccessNode ident) -> ruleAccess env ident mem
    | (IntegerNode value) -> ruleInteger value mem
    | (TrueNode) ->  ruleTrue mem
    | (FalseNode) ->  ruleFalse mem
    | (UnitNode) ->  ruleUnit mem
    | (BinaryNode (op,left,right)) -> ruleBinary env op left right mem
    | (UnaryNode (op,expr)) -> ruleUnary env op expr mem
    | (ReadNode expr) -> ruleRead env expr mem
    | (WriteNode (refexpr,valexpr)) -> ruleWrite env refexpr valexpr mem
    | (SequenceNode (left, right)) -> ruleSequence env left right mem
    | (WhileNode (cond, body)) -> ruleWhile env cond body mem
    | (RefNode expr) -> ruleReference env expr mem

and
(* .............................................................................*)
(*   ruleAccess : String -> memory -> environment                               *)
(*      -> (ValueType * memory)                                                 *)
(* .............................................................................*)

ruleAccess env ident mem =
  (match (lookforEnv ident env) with
  | NotFound -> ((ErrorValue (UnknownIdentError ident)),mem)
  | (Found (FrozenValue (fexpr,fenv))) -> (value_of_expr (fexpr,mem) fenv)
  | (Found value) -> (value,mem))

and
(* .............................................................................*)
(*  ruleLet : String -> Ast.ast -> Ast.ast -> memory -> environment             *)
(*      -> (ValueType * memory)                                                 *)
(* .............................................................................*)

ruleLet env ident bvalue bin mem =
  (let (vval,vmem) =
     (value_of_expr (bvalue,mem) env)
   in
     (match vval with
     | (ErrorValue _) as result -> (result,vmem)
     | _ -> (value_of_expr (bin,vmem) ((ident,vval)::env))))

and
(* .............................................................................*)
(*   ruleBinary : binary -> Ast.ast -> Ast.Ast -> memory -> environment         *)
(*      -> (ValueType * memory)                                                 *)
(* .............................................................................*)

ruleBinary env op left right mem =
  let (rightvalue, rightmem) =
    (value_of_expr (right,mem) env)
  in
    (match rightvalue with
    | (ErrorValue _) as result -> (result, rightmem)
    | _ ->
      (let (leftvalue, leftmem) = (value_of_expr (left,rightmem) env) in
         (match leftvalue with
         | (ErrorValue _) as result -> (result, leftmem)
         | _ ->
           (match (leftvalue,rightvalue) with
           | ((IntegerValue leftvalue), (IntegerValue rightvalue)) ->
             (match op with
             | Equal -> ((BooleanValue (leftvalue = rightvalue)), leftmem)
             | Different -> ((BooleanValue (leftvalue <> rightvalue)), leftmem)
             | Lesser -> ((BooleanValue (leftvalue < rightvalue)), leftmem)
             | LesserEqual -> ((BooleanValue (leftvalue <= rightvalue)), leftmem)
             | Greater -> ((BooleanValue (leftvalue > rightvalue)), leftmem)
             | GreaterEqual -> ((BooleanValue (leftvalue >= rightvalue)), leftmem)
             | Add -> ((IntegerValue (leftvalue + rightvalue)), leftmem)
             | Substract -> ((IntegerValue (leftvalue - rightvalue)), leftmem)
             | Multiply -> ((IntegerValue (leftvalue * rightvalue)), leftmem)
             | Divide ->
               (if (rightvalue = 0) then
                  ((ErrorValue RuntimeError),leftmem)
                else
                  ((IntegerValue (leftvalue / rightvalue)), leftmem))
             | _ -> ((ErrorValue TypeMismatchError), leftmem))
           | ((BooleanValue leftvalue), (BooleanValue rightvalue)) ->
             (match op with
             | Or -> ((BooleanValue (leftvalue || rightvalue)),leftmem)
             | And -> ((BooleanValue (leftvalue && rightvalue)) ,leftmem)
             | _ -> ((ErrorValue TypeMismatchError), leftmem))
          | _ -> ((ErrorValue TypeMismatchError), leftmem)))))

and
(* .............................................................................*)
(*   ruleUnary : unary -> Ast.ast -> memory -> environment                      *)
(*      -> (ValueType * memory)                                                 *)
(* .............................................................................*)

ruleUnary env op expr mem =
  let (rvalue,rmem) =
    (value_of_expr (expr,mem) env)
  in
    (match rvalue with
    | (ErrorValue _) as result -> (result,rmem)
    | (IntegerValue value) ->
      (match op with
      | Opposite ->
         ((IntegerValue (- value)),rmem)
      | _ ->   ((ErrorValue TypeMismatchError),rmem))
    | (BooleanValue value) ->
      (match op with
      | Negation ->
         ((BooleanValue (not value)),rmem)
      | _ ->   ((ErrorValue TypeMismatchError),rmem))
      (*| _ -> ((ErrorValue TypeMismatchError),rmem) *)
    | _ -> ((ErrorValue TypeMismatchError),rmem))

and
(* .............................................................................*)
(*   ruleIf : Ast.ast -> Ast.ast -> Ast.ast -> memory -> environment            *)
(*      -> (ValueType * memory)                                                 *)
(* .............................................................................*)

ruleIf env cond bthen belse mem =
  (let (cval,cmem) =
     (value_of_expr (cond,mem) env)
   in
     (match cval with
     | (BooleanValue rcond) ->
       (if (rcond) then
          (value_of_expr (bthen,cmem) env)
       else
          (value_of_expr (belse,cmem) env))
     | (ErrorValue _) as result -> (result,cmem)
     | _ -> ((ErrorValue TypeMismatchError),cmem)))

and
(* .............................................................................*)
(*   ruleFunction : Ast.ast -> memory -> environment                            *)
(*      -> (ValueType * memory)                                                 *)
(* .............................................................................*)

ruleFunction env expr mem =
  ( (FrozenValue (expr,env)), mem)

and
(* .............................................................................*)
(*   ruleCallByName : Ast.ast -> Ast.ast -> memory -> environment               *)
(*      -> (ValueType * memory)                                                 *)
(* .............................................................................*)

ruleCallByName env fexpr pexpr mem =
  match (value_of_expr fexpr env) with
  | ErrorValue as error -> error
  | (FrozenValue (FunctionNode(id, body),penv), pmem) -> 
    let nenv = (id, FrozenValue((value_of_expr (pexpr,mem) env), env))::penv
    (value_of_expr (body,pmem) penv)
  
and
(* .............................................................................*)
(*  ruleCallByValue : Ast.ast -> Ast.ast -> memory -> environment               *)
(*      -> (ValueType * memory)                                                 *)
(* .............................................................................*)

(* Appel par valeur *)
ruleCallByValue env fexpr pexpr mem =
  let (pval,pmem) =
     value_of_expr (pexpr,mem) env
   in
     match pval with
     | (ErrorValue _) as result -> (result,pmem)
     | _ ->
	let (fval,fmem) =
          value_of_expr (fexpr,pmem) env
        in
         (match fval with
         | (FrozenValue ((FunctionNode (fpar,fbody)),fenv)) ->
             (value_of_expr (fbody,fmem) ((fpar,pval)::fenv))
         | (ErrorValue _) as result -> (result,fmem)
         | _ -> ((ErrorValue TypeMismatchError),fmem)
         )

and
(* .............................................................................*)
(*  ruleLetrec : String -> Ast.ast -> Ast.ast -> memory -> environment          *)
(*      -> (ValueType * memory)                                                 *)
(* .............................................................................*)

ruleLetrec env ident bvalue bin mem =
  (value_of_expr (bin,mem)
      ((ident,(FrozenValue ((LetrecNode (ident,bvalue,bvalue)),env)))::env))

and
(* .............................................................................*)
(*   ruleTrue  : memory -> (ValueType * memory)                                 *)
(* .............................................................................*)

ruleTrue mem = ((BooleanValue true), mem)

and
(* .............................................................................*)
(*   ruleFalse : memory -> (ValueType * memory)                                 *)
(* .............................................................................*)

ruleFalse mem = ((BooleanValue false), mem)

and
(* .............................................................................*)
(*   ruleUnit :  memory -> (ValueType * memory)                               ..*)
(* .............................................................................*)

ruleUnit mem = (NullValue , mem)

and
(* .............................................................................*)
(*   ruleAccess : String -> memory -> environment  -> (ValueType * memory) ..*)
(* .............................................................................*)

ruleInteger value mem = ((IntegerValue value), mem)

and
(* .............................................................................*)
(*   ruleRead : Ast.ast -> memory -> environment                                *)
(*      -> (ValueType * memory)                                                 *)
(* .............................................................................*)

(* ...............A COMPLETER .......................................*)
ruleRead _env _expr mem = ((ErrorValue UndefinedExpressionError), mem)

and
(* .............................................................................*)
(*   ruleWrite : Ast.ast -> Ast.ast -> memory -> environment                    *)
(*      -> (ValueType * memory)                                                 *)
(* .............................................................................*)

ruleWrite env refexpr valexpr mem = ((ErrorValue UndefinedExpressionError),mem)
  

and
(* .............................................................................*)
(*   ruleSequence : Ast.ast -> Ast.ast -> memory -> environment                 *)
(*      -> (ValueType * memory)                                                 *)
(* .............................................................................*)

ruleSequence env left right mem =
  match (value_of_expr (left,mem) env) with
  | (ErrorValue(_),_) as (error,nmem) -> (error,nmem)
  | (NullValue,nmem) -> (value_of_expr (right,env),nmem)
  | (_,nmem) -> (ErrorValue(TypeMismatchError),nmem)


and
(* .............................................................................*)
(*   ruleWhile : Ast.ast -> Ast.ast -> memory -> environment                 *)
(*      -> (ValueType * memory)                                                 *)
(* .............................................................................*)

ruleWhile _env _cond _body mem = ((ErrorValue UndefinedExpressionError),mem)
(* ...............A COMPLETER .......................................*)

and
(* .............................................................................*)
(*   ruleReference : Ast.ast -> memory -> environment                           *)
(*       -> (ValueType * memory)                                                *)
(* .............................................................................*)

ruleReference env expr mem = 
  match (value_of_expr (expr,mem) env) with
  | (ErrorValue(_),_) as (error,nmem) -> (error,nmem)
  | (value,nmem) -> let nref = ReferenceValue (newReference ()) in (nref, (nref,value)::nmem)
;;
