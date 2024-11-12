(* --------------------------- *)
(* Exercice 1 : Types fantômes *)
(* --------------------------- *)

module type FichierLecture1Car =
sig
  type debut
  type fin
  type _ fichier
  val open_ : string -> debut fichier
  val read : debut fichier -> char * fin fichier
  val close : fin fichier -> unit
end

module Impl : FichierLecture1Car =
struct
  type debut = unit
  type fin = unit
  type _ fichier = in_channel
  let open_ nom = open_in nom
  let read f = (input_char f, f)
  let close f = close_in f
end

let lire_char nom =
  let f = Impl.open_ nom in
  let (c, f) = Impl.read f in
  (Impl.close f; c);;

(* - Pour lire deux charactères *)

module type FichierLecture2Car =
sig
  type debut
  type milieu
  type fin
  type _ fichier
  val open_ : string -> debut fichier
  val read1 : debut fichier -> char * milieu fichier
  val read2 : debut fichier -> char * fin fichier
  val close : fin fichier -> unit
end

module type FichierLecture2CarSucc =
sig
  type zero
  type _ succ
  type _ fichier
  val open_ : string -> zero fichier
  val read : 'n fichier -> char * ('n succ) fichier
  val close : ((zero succ) succ) fichier -> unit
end

(* - Pour lire un nombre pair de charactères *)

module type FichierLecturePairCar =
sig
  type even
  type odd
  type _ fichier
  val open_ : string -> (even * odd) fichier
  val read : ('a * 'b) fichier -> char * ('b * 'a) fichier
    val close : (even * odd) fichier -> unit
end

(* -------------------------------- *)
(* Exercice 2 : Types non-uniformes *)
(* -------------------------------- *)

type 'a perfect_tree = | Empty | Node of 'a * ('a * 'a) perfect_tree

type ('a, _) ptree =
  | Empty : ('a, zero)
  | Node : 'a * ('a*'a,'p) -> ('a, 'p succ) ptree

let rec split : type a. (a * a) perfect_tree -> a perfect_tree * a perfect_tree =
  fun arb ->
    match arb with
    | Empty -> Empty, Empty
    | Node((t1,t2),q) -> let (q1,q2) = split q in
                          Node(t1,q1),Node(t2,q2) 

let rec merge : type a p. (a, p) perfect_tree -> (a, p) perfect_tree -> (a*a,p) perfect_tree =
