type 'a arbre =
  Noeud of bool* 'a branche list
and 'a branche =
  'a* 'a arbre
  let empty : 'a arbre = Noeud(false,[])

type 'a option =
  None | Some of 'a

let rec recherche x lb =
  match lb with
  | [] -> None
  | (c,sa)::q -> if c=x then Some(sa)
                        else if c>x then None
                        else recherche x q 