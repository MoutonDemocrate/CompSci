open Tokens

(* Type du résultat d'une analyse syntaxique *)
type parseResult =
  | Success of inputStream
  | Failure
;;

(* accept : token -> inputStream -> parseResult *)
(* Vérifie que le premier token du flux d'entrée est bien le token attendu *)
(* et avance dans l'analyse si c'est le cas *)
let accept expected stream =
  match (peekAtFirstToken stream) with
    | token when (token = expected) ->
      (Success (advanceInStream stream))
    | _ -> Failure
;;

(* Définition de la monade  qui est composée de : *)
(* - le type de donnée monadique : parseResult  *)
(* - la fonction : inject qui construit ce type à partir d'une liste de terminaux *)
(* - la fonction : bind (opérateur >>=) qui combine les fonctions d'analyse. *)

(* inject inputStream -> parseResult *)
(* Construit le type de la monade à partir d'une liste de terminaux *)
let inject s = Success s;;

(* bind : 'a m -> ('a -> 'b m) -> 'b m *)
(* bind (opérateur >>=) qui combine les fonctions d'analyse. *)
(* ici on utilise une version spécialisée de bind :
   'b  ->  inputStream
   'a  ->  inputStream
    m  ->  parseResult
*)
(* >>= : parseResult -> (inputStream -> parseResult) -> parseResult *)
let (>>=) result f =
  match result with
    | Success next -> f next
    | Failure -> Failure
;;


(* parseS : inputStream -> parseResult *)
(* Analyse du non terminal Programme *)
let rec parseS stream =
  (print_string "S -> ");
  (match (peekAtFirstToken stream) with
    | UL_ENTIER n ->
      (print_endline ("Entier " ^ n));
      (
        (inject stream) >>=
        (accept (UL_ENTIER n))
      )
    | UL_IDENT txt -> 
      (print_endline ("Ident " ^ txt));
      (
        (inject stream) >>=
        (accept (UL_IDENT txt))
      )
      | UL_PAR_OPEN ->
      (print_endline "( X )");
      (
        (inject stream) >>=
        (accept UL_PAR_OPEN) >>=
        parseX (*  >>=
        (accept UL_PAR_CLOSE) *)
      )
    | _ -> Failure)


(* parseX : inputStream -> parseResult *)
(* Analyse du non terminal X *)
and parseX stream =
  (print_string "X -> ");
  (match (peekAtFirstToken stream) with
    | UL_PAR_CLOSE ->
      (print_endline ("LAMBDA"));
      (
        (inject stream) >>=
        (accept UL_PAR_CLOSE)
      )
    | UL_PAR_OPEN ->
      (print_endline ("SY"));
      (
        (inject stream) >>=
        (accept (UL_PAR_OPEN)) >>=
        parseS >>=
        parseY
      )
    | UL_IDENT txt  ->
      (print_endline ("SY"));
      (
        (inject stream) >>=
        (accept (UL_IDENT txt)) >>=
        parseS >>=
        parseY
      )

    | UL_ENTIER n ->
      (print_endline ("SY"));
      (
        (inject stream) >>=
        (accept (UL_ENTIER n)) >>=
        parseS >>=
        parseY
      )

    | _ -> Failure)


(* parseY : inputStream -> parseResult *)
(* Analyse du non terminal Programme *)
and parseY stream =
  (print_string "Y -> ");
  (match (peekAtFirstToken stream) with
    | PT ->
      (print_endline (". S"));
      (
        (inject stream) >>=
        (accept (PT)) >>=
        parseS
      )
    | UL_PAR_OPEN ->
      (print_endline ("L"));
      (
        (inject stream) >>=
        (accept (UL_PAR_OPEN)) >>=
        parseL
      )
    | UL_PAR_CLOSE ->
      (print_endline ("L"));
      (
        (inject stream) >>=
        (accept (UL_PAR_CLOSE)) >>=
        parseL
      )
    | UL_IDENT txt ->
      (print_endline ("L"));
      (
        (inject stream) >>=
        (accept (UL_IDENT txt)) >>=
        parseL
      )
    | UL_ENTIER n ->
      (print_endline ("L"));
      (
        (inject stream) >>=
        (accept (UL_ENTIER n)) >>=
        parseL
      )
    | _ -> Failure)


(* parseL : inputStream -> parseResult *)
(* Analyse du non terminal Programme *)
and parseL stream =
  (print_string "L -> ");
  (match (peekAtFirstToken stream) with
    | UL_PAR_CLOSE ->
      (print_endline ("LAMBDA"));
      (
        (inject stream) >>=
        (accept (UL_PAR_CLOSE))
      )
      | UL_PAR_OPEN ->
        (print_endline ("S L"));
        (
          (inject stream) >>=
          (accept (UL_PAR_OPEN)) >>=
          parseS >>=
          parseL
        )
      | UL_IDENT txt ->
        (print_endline ("S L"));
        (
          (inject stream) >>=
          (accept (UL_IDENT txt)) >>=
          parseS >>=
          parseL
        )
      | UL_ENTIER n ->
        (print_endline ("S L"));
        (
          (inject stream) >>=
          (accept (UL_ENTIER n)) >>=
          parseS >>=
          parseL
        )
    | _ -> Failure)

;;