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

(* accept : token -> inputStream -> parseResult *)
(* Vérifie que le premier token du flux d'entrée est bien le token attendu *)
(* et avance dans l'analyse si c'est le cas *)
let acceptPackageIdent stream =
  match (peekAtFirstToken stream) with
    | UL_PACKAGE_IDENT _ ->
      (Success (advanceInStream stream))
    | _ -> Failure
;;

(* accept : token -> inputStream -> parseResult *)
(* Vérifie que le premier token du flux d'entrée est bien le token attendu *)
(* et avance dans l'analyse si c'est le cas *)
let acceptInterfaceIdent stream =
  match (peekAtFirstToken stream) with
    | UL_INTERFACE_IDENT _ ->
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


(* parseMachine : inputStream -> parseResult *)
(* Analyse du non terminal Programme *)
let rec parsePackage stream =
  (print_string "Package -> ");
  (match (peekAtFirstToken stream) with
   | UL_PACKAGE ->
      (print_endline "package UL_IDENT_PACKAGE { E SE }");
      (
      (inject stream) >>=
      (accept UL_PACKAGE) >>=
      acceptPackageIdent >>=
      (accept UL_LEFT_BRACE) >>=
      parseE >>=
      parseSE >>=
      (accept UL_RIGHT_BRACE)
      )
   | _ -> Failure)

and parseSE stream =
  (print_string "SE -> ");
  (match (peekAtFirstToken stream) with
   | UL_RIGHT_BRACE ->
    (print_endline "lambda");
    (
    (inject stream)
    )
   | UL_PACKAGE | UL_INTERFACE ->
    (print_endline "E SE");
    (
    (inject stream) >>=
    parseE >>=
    parseSE
    )
   | _ -> Failure)

and parseE stream =
  (print_string "E -> ");
  (match (peekAtFirstToken stream) with
    | UL_PACKAGE ->
    (print_endline "Package");
    (
    (inject stream) >>=
    parsePackage
    )
    | UL_INTERFACE ->
    (print_endline "I");
    (
    (inject stream) >>=
    parseI
    )
    | _ -> Failure)

and parseI stream =
  (print_string "I -> ");
  (match (peekAtFirstToken stream) with
    | UL_INTERFACE ->
    (print_endline "interface Ident X { SM }");
    (
    (inject stream) >>=
    (accept UL_INTERFACE) >>=
    acceptInterfaceIdent >>=
    parseX >>=
    (accept UL_LEFT_BRACE) >>=
    parseSM >>=
    (accept UL_RIGHT_BRACE)
    )
    | _ -> Failure)

and parseX stream =
  (print_string "X -> ");
  (match (peekAtFirstToken stream) with
    | UL_LEFT_BRACE ->
    (print_endline "lambda");
    (
    (inject stream)
    )
    | UL_EXTENDS ->
      (print_endline "extends Q Ident SQ");
      (
      (inject stream) >>=
      (accept UL_EXTENDS) >>=
      parseQ >>=
      acceptInterfaceIdent >>=
      parseSQ
      )
    | _ -> Failure)


and parseQ stream =
  (print_string "Q -> ");
  (match (peekAtFirstToken stream) with
    | UL_INTERFACE_IDENT _ ->
    (print_endline "lambda");
    (
    (inject stream)
    )
    | UL_PACKAGE_IDENT _ ->
      (print_endline "ident . Q");
      (
      (inject stream) >>=
      acceptPackageIdent >>=
      (accept PT) >>=
      parseQ
      )
    | _ -> Failure)

and parseSQ stream =
  (print_string "SQ -> ");
  (match (peekAtFirstToken stream) with
    | UL_LEFT_BRACE ->
    (print_endline "lambda");
    (
    (inject stream)
    )
    | VIRG ->
      (print_endline ", Q Ident SQ");
      (
      (inject stream) >>=
      (accept VIRG) >>=
      parseQ >>=
      acceptInterfaceIdent >>=
      parseSQ
      )
    | _ -> Failure)

and parseSM stream =
  (print_string "SM -> ");
  (match (peekAtFirstToken stream) with
    | UL_RIGHT_BRACE ->
    (print_endline "lambda");
    (
    (inject stream)
    )
    | BOOL | INT | VOID | UL_PACKAGE_IDENT _ | UL_INTERFACE_IDENT _ ->
      (print_endline "M SM");
      (
      (inject stream) >>=
      parseM >>=
      parseSM
      )
    | _ -> Failure)

and parseM stream =
  (print_string "M -> ");
  (match (peekAtFirstToken stream) with
    | BOOL | INT | VOID | UL_PACKAGE_IDENT _ | UL_INTERFACE_IDENT _ ->
      (print_endline "T ident ( O ) ;");
      (
      (inject stream) >>=
      parseT >>=
      acceptPackageIdent >>=
      (accept UL_LEFT_PAR) >>=
      parseO >>=
      (accept UL_RIGHT_PAR) >>=
      (accept PTVIRG)
      )
    | _ -> Failure)

and parseO stream =
  (print_string "O -> ");
  (match (peekAtFirstToken stream) with
    | UL_RIGHT_PAR ->
      (print_endline "lambda");
      (
      (inject stream)
      )
    | BOOL | INT | VOID | UL_PACKAGE_IDENT _ | UL_INTERFACE_IDENT _ ->
      (print_endline "T ST");
      (
      (inject stream) >>=
      parseT >>=
      parseST
      )
    | _ -> Failure)

and parseST stream =
  (print_string "ST -> ");
  (match (peekAtFirstToken stream) with
    | UL_RIGHT_PAR ->
      (print_endline "lambda");
      (
      (inject stream)
      )
    | VIRG ->
      (print_endline ", T ST");
      (
      (inject stream) >>=
      (accept VIRG) >>=
      parseT >>=
      parseST
      )
    | _ -> Failure)

and parseT stream =
  (print_string "T -> ");
  (match (peekAtFirstToken stream) with
    | BOOL ->
      (print_endline "boolean");
      (
      (inject stream) >>=
      (accept BOOL)
      )
    | INT ->
      (print_endline "int");
      (
      (inject stream) >>=
      (accept INT)
      )
    | VOID ->
      (print_endline "void");
      (
      (inject stream) >>=
      (accept VOID)
      )
    | UL_PACKAGE_IDENT _ | UL_INTERFACE_IDENT _ ->
      (print_endline "Q Ident");
      (
      (inject stream) >>=
      parseQ >>=
      acceptInterfaceIdent
      )
    | _ -> Failure)
;;
