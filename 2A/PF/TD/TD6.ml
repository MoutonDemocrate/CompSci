module type Iter = 
sig
  type 'a t 
  val vide : 'a t
  val cons : 'a -> 'a t -> 'a t
  val uncons : 'a t -> ('a * 'a t) option
  val apply : ('a -> 'b) t -> ('a t -> 'b t)
  val unfold : ('b -> ('a * 'b) option) -> ('b -> 'a t)
  val filter : ('a -> bool) -> 'a t -> 'a t
  val append : 'a t -> 'a t -> 'a t
end

module FFlux : Iter =
struct
  type 'a t = Tick of (unit -> ('a * 'a t) option)
  
  let vide = Tick (fun () -> None)

  let cons t q = Tick (fun () -> Some (t, q))

  let uncons (Tick fflux) = fflux ()

  let rec unfold f e =
    Tick (fun () ->
      match f e with
      | None -> None
      | Some (t, e') -> Some (t, unfold f e'))

  let rec apply f x =
    Tick (fun () ->
      match uncons f, uncons x with
      | None , _ -> None
      | _ , None -> None
      | Some (tf, qf), Some (tx, qx) -> Some (tf tx, apply qf qx))

      let rec filter p flux =
    Tick (fun () ->
      match uncons flux with
      | None -> None
      | Some (t, q) -> if p t then Some (t, filter p q)
      else uncons (filter p q))

  let rec append flux1 flux2 =
    Tick (fun () ->
      match uncons flux1 with
      | None -> uncons flux2
      | Some (t1, q1) -> Some (t1, append q1 flux2))
      
end

module LazyFlux : Iter =

struct
  type 'a t = Tick of ('a * 'a t) option Lazy.t

  let vide = Tick (lazy None)

  let cons t q = Tick (lazy (Some (t, q)))

  let uncons (Tick (lazy flux)) = flux
  
  let rec apply f x =
    Tick (lazy (
      match uncons f, uncons x with
      | None , _ -> None
      | _ , None -> None
      | Some (tf, qf), Some (tx, qx) -> Some (tf tx, apply qf qx)))
  
  let rec unfold f e =
    Tick (lazy (
      match f e with
      | None -> None
      | Some (t, e') -> Some (t, unfold f e')))
  
  let rec filter p flux =
    Tick (lazy (
      match uncons flux with
      | None -> None
      | Some (t, q) -> if p t then Some (t, filter p q)
      else uncons (filter p q)))
  
  let rec append flux1 flux2 =
    Tick (lazy (
      match uncons flux1 with
      | None -> uncons flux2
      | Some (t1, q1) -> Some (t1, append q1 flux2)))
end

module TD (Flux : Iter) =
struct
  let constant c = Flux.unfold (fun a -> Some(a,a)) c

  let map p f = Flux.apply (constant p) f

  let map2 p x y = Flux.apply (map p x) y

  let fibonacci =
    Flux.unfold 
      (fun (fn, fn1) -> Some(fn1, (fn1, fn1 + fn)))
      (0, 1)
end