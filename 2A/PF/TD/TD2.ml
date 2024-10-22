(*
  ajout : 'a -> 'a list -> 'a list list
  arguments :
    e : 'a, élément à ajouter
    l : 'a list, liste d'éléments
  description : ajoute un élément e à chaque élément d'un ensemble l*)
  let %test_ = List.length(ajout 0 [[1;2];[3;4]]) == 4
  let %test_ = List.mem [1;2] (ajout 0 [[1;2];[3;4]])
  let %test_ = List.mem [3;4] (ajout 0 [[1;2];[3;4]])
  let %test_ = List.mem [0;1;2] (ajout 0 [[1;2];[3;4]])
  let %test_ = List.mem [0;3;4] (ajout 0 [[1;2];[3;4]])
  let ajout e l =
    List.flatten (
      List.map (fun ens ->
        [ens ; e::ens]
        ) l
    )
  
(*
  parties 'a list -> 'a list list
  arguments :
    l : list, liste quelconque d'éléments
  description : renvoie l'ensemble des parties de l
  *)
