(* Pour les tests *)
(* [eq_perm l l'] retourne true ssi [l] et [l']
   sont égales à à permutation près (pour (=)).
   [l'] ne doit pas contenir de doublon. *)
let eq_perm l l' =
  List.length l = List.length l' && List.for_all (fun x -> List.mem x l) l'


module type StructureDonnees =
sig

  (* Type permettant de stocker le dictionnaire *)
  type dico

  (* Dictionnaire vide *)
  val empty : dico

  (* Ajoute un mot et son encodage au dictionnaire *)
  (* premier parametre : l'encodage du mot *)
  (* deuxième paramètre : le mot *)
  (* troisième paramètre : le dictionnaire *)
  val ajouter : int list -> string -> dico -> dico

  (* Cherche tous les mots associés à un encodage dans un dictionnaire *)
  (* premier parametre : l'encodage du mot *)
  (* second paramètre : le dictionnaire *)
  val chercher : int list -> dico -> string list


  (* Calcule le nombre maximum de mots ayant le même encodage dans un
     dictionnaire *)
  (* paramètre : le dictionnaire *)
  val max_mots_code_identique : dico -> int

  (* Liste tous les mots d'un dictionnaire dont un prefixe de l'encodage est donné en paramètre *)
  (* premier paramètre : le prefixe de l'encodage *)
  (* second paramètre : le dictionnaire *)
  val prefixe : int list -> dico -> string list

end

module ListAssoc : StructureDonnees with type dico = (int list * string list) list =
struct
  
  type dico = (int list * string list) list

  (* Dictionnaire vide *)
  let empty : dico = []

  (* Ajoute un mot et son encodage au dictionnaire *)
  (* premier parametre : l'encodage du mot *)
  (* deuxième paramètre : le mot *)
  (* troisième paramètre : le dictionnaire *)
  let rec ajouter encodage mot d =
    match d with
    | [] -> [(encodage,[mot])]
    | (e,m)::qd -> 
      match e with
      (* Si l'encodage exist déjà, on ajoute alors le mot *)
      | encodage -> (encodage,mot::m)::qd
      (* Sinon, on contine à chercher l'encodage dans le dictionnaire *)
      | _ -> (e,m)::(ajouter encodage mot qd)


  (* Cherche tous les mots associés à un encodage dans un dictionnaire *)
  (* premier parametre : l'encodage du mot *)
  (* second paramètre : le dictionnaire *)
  let rec chercher encodage d =
    match d with
      | [] -> []
      | (e,m)::qd -> 
        match e with 
        | encodage -> m (* Si encodage correct, on renvoie la liste de mots associés*)
        | _ -> chercher encodage qd (* Sinon, on continue à chercher *)

  (* Calcule le nombre maximum de mots ayant le même encodage dans un
     dictionnaire *)
  (* paramètre : le dictionnaire *)
  let max_mots_code_identique d =
    (* On crée un accumulateur qui va récupérer le nombre, pour chaque encodage, de mots*)
    let rec aux acc d =
      match d with 
      | [] -> acc (* Si il n'y a plus rien, on renvoie l'accumulateur *)
      | (_,m)::qd ->
        let l = List.length m in aux (l::acc) qd (* Sinon on continue en ajoutant le nombre de mots à l'accumulateur *)
    in List.fold_left max 0 (aux [] d)


  (* Liste tous les mots d'un dictionnaire dont un prefixe de l'encodage est donné en paramètre *)
  (* premier paramètre : le prefixe de l'encodage *)
  (* second paramètre : le dictionnaire *)
  let prefixe prfx d =
    let rec aux_prefixe acc prfx d =

      (* On définit une fonction qui renvoie true si le préfixe match l'encodage, et renvoie false sinon *)
      let rec prfx_match p e =
        match p with
        | [] -> true (* Si le préfixe est vide, alors l'encodage matche *)
        | pt::pq ->
          match e with
          | [] -> false (* Si l'encodage est vide alors que le préfixe ne l'es pas, il est impossible de matcher *)
          | et::eq -> if pt = et then prfx_match pq eq (* Si l'élément du préfixe est égal à l'élément de l'encodage, on continue à l'index suivant *)
                      else false (* sinon, le préfixe et l'encodage ne matchent pas *)

      in

      match d with
      | [] -> acc (* Si il n'y a plus rien, on renvoie l'accumulateur *)
      | (e,m)::qd -> (* Si il y a des éléments*)
        if prfx_match e prfx then aux_prefixe (acc@m) prfx qd (* Si le préfixe matche, on ajoute les mots à l'accumulateur*)
        else aux_prefixe acc prfx qd (* Sinon, on continue sans ajouter les mots*)

    in aux_prefixe [] prfx d
end

module Arbre : StructureDonnees =
struct

  (* Type permettant de stocker le dictionnaire *)
  type dico = Noeud of ( string list * ( int * dico ) list )

  (* Dictionnaire vide *)
  let empty : dico = Noeud([],[])

  (* Ajoute un mot et son encodage au dictionnaire *)
  (* premier parametre : l'encodage du mot *)
  (* deuxième paramètre : le mot *)
  (* troisième paramètre : le dictionnaire *)
  let rec ajouter encodage mot (Noeud(mots,reste)) =
    match encodage with
    | [] -> Noeud(mot::mots,reste) (* Si l'encodage est vide, on ajoute le mot ici *)
    | et::eq -> (* Si l'encodage n'est pas vide... *)
      match reste with
      | [] -> (Noeud(mots,[(et,(ajouter eq mot empty))])) (* ...mais que le reste de l'arbre l'est, on crée un nouveau noeud *)
      | r -> (* ...et qu'il existe d'autre branches, *)
        if List.exists (fun (e,_) -> e = et) r then 
           (* Si l'int actuel de l'encodage est dans ces branches, on continue dedans *) 
          let f = (fun (a,b) -> if a = et then (a,ajouter eq mot b) else (a,b)) in (Noeud(mots,(List.map f r)))
        (* Sinon on ajoute un nouveau noeud et on continue *) 
        else (Noeud(mots,(et,(ajouter eq mot empty))::r)) 

  (* Cherche tous les mots associés à un encodage dans un dictionnaire *)
  (* premier parametre : l'encodage du mot *)
  (* second paramètre : le dictionnaire *)
  let rec chercher encodage (Noeud(mots,reste)) =
    match encodage with
    | [] -> mots (* Si l'encodage est vide, on renvoie les mots *)
    | et::eq -> (* Si l'encodage n'est pas vide... *)
      match reste with
      | [] -> [] (* ...mais que le reste de l'arbre l'est, on renvoie une liste vide *)
      | r -> (* ...et qu'il existe d'autre branches, *)
        if List.exists (fun (e,_) -> e = et) r then 
           (* Si l'int actuel de l'encodage est dans ces branches, on cherche dans la branche en question*) 
          let (_,b) =  (List.find (fun (e,_) -> e = et) r) in chercher eq b
        (* Sinon on renvoie une liste vide *) 
        else []


  (* Calcule le nombre maximum de mots ayant le même encodage dans un
     dictionnaire *)
  (* paramètre : le dictionnaire *)
  let max_mots_code_identique = failwith("TODO")

  (* Liste tous les mots d'un dictionnaire dont un prefixe de l'encodage est donné en paramètre *)
  (* premier paramètre : le prefixe de l'encodage *)
  (* second paramètre : le dictionnaire *)
  let rec prefixe prfx (Noeud(mots,reste)) =
    match prfx with
    | [] -> (* Préfixe vide : les mots du noeud tous les mots suivants doivent être renvoyés*)
      match reste with 
      | [] -> mots (* On renvoie les mots actuels*)
      | r -> failwith("TODO") (* mots@(List.fold_left (@) (List.map (fun (_,n) -> prefixe [] n) r )) *)
    | pt::pq -> (* Si le préfixe n'est pas vide... *)
      match reste with
      | [] -> [] (* ...mais que le reste de l'arbre l'est, on renvoie une liste vide *)
      | r -> failwith("TODO") (* FIN DU TEMPS IMPARTI*)

end