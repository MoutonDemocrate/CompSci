type zero = private Dummy1
type _ succ = private Dummy2
type nil = private Dummy3
type 'a list = Nil | Cons of 'a * 'a list

(* EXERCICE 1 *)

type ('a, 'n) nlist = 
  | Nil : ('a, zero)nlist
  | Cons : 'a * ('a, 'n) nlist -> ('a, 'n succ) nlist

let rec map : type n. ('a -> 'b) -> ('a, n) nlist -> ('b, n) nlist =
  fun f nl ->
    match nl with
    | Nil -> Nil
    | Cons(t, q) -> Cons (f t, map f q)

let%test _ = map (fun x -> x+2) (Cons(2, Cons(1,Nil))) = Cons(4, Cons(3,Nil))
let%test _ = map (fun x -> Int.to_string x) (Cons(2, Cons(1,Nil))) = Cons("2", Cons("1",Nil))

let rec snoc : type n. 'a -> ('a, n) nlist -> ('b, n succ) nlist =
  fun a nl ->
    match nl with
    | Nil -> Cons(a, Nil)
    | Cons(t, Nil) -> Cons(t, Cons(a, Nil))
    | Cons(t, q) -> Cons(t, snoc a q)

let%test _ = snoc 5 (Cons(2, Cons(1, Nil))) = Cons(2, Cons(1, Cons(5, Nil)))

let tail : type n. ('a, n succ) nlist -> ('b, n) nlist =
  fun  (Cons(_, q)) -> q

let%test _ = tail (Cons(4, Cons(3, Cons(5, Nil)))) = Cons(3, Cons(5, Nil))

let rec rev : type n. ('a, n) nlist -> ('b, n) nlist =
  fun nl ->
    match nl with
    | Nil -> Nil
    | Cons(t, q) -> snoc t (rev q)


let%test _ = rev (Cons(4, Cons(3, Cons(5, Nil)))) = (Cons(5, Cons(3, Cons(4, Nil))))

(* EXERCICE 2 *)

(* let rec insert x l =
  match l with
  | [] -> x::l
  | t::q -> if t < x then t::insert x q else x::l;;
let rec insertion_sort l =
  match l with
  | [] -> []
  | t::q -> insert t (insertion_sort q);; *)

  let rec insert : type n. 'a -> ('a, n) nlist -> ('b, n succ) nlist =
    fun x nl ->
    match nl with
    | Nil -> Cons(x, Nil)
    | Cons(t, q) -> if t < x then Cons(t,insert x q) else Cons(x, nl)

  let rec insertion_sort : type n. ('a, n) nlist -> ('b, n) nlist =
    fun nl ->
    match nl with
    | Nil -> Nil
    | Cons(t, q) -> insert t (insertion_sort q)