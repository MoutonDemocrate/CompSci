open List

type token = 
  | UL_RIGHT_BRACE
  | UL_LEFT_BRACE
  | UL_LEFT_PAR
  | UL_RIGHT_PAR
  | UL_PACKAGE
  | UL_INTERFACE
  | UL_EXTENDS
  | BOOL
  | INT
  | VOID
  | VIRG
  | PT
  | PTVIRG
  | UL_PACKAGE_IDENT of (string)
  | UL_INTERFACE_IDENT of (string)
    | UL_FIN
    | UL_ERREUR;;

type inputStream = token list;;

(* string_of_token : token -> string *)
(* Converti un token en une chaîne de caractère*)
let string_of_token token =
     match token with
       | UL_LEFT_BRACE -> "{"
       | UL_RIGHT_BRACE -> "}"
       | UL_LEFT_PAR -> "("
       | UL_RIGHT_PAR -> ")"
       | UL_PACKAGE -> "package"
       | UL_INTERFACE -> "interface"
       | UL_EXTENDS -> "extends"
       | BOOL -> "boolean"
       | INT -> "int"
       | VOID -> "void"
       | VIRG -> ","
       | PT -> "."
       | PTVIRG -> ";"
       | UL_PACKAGE_IDENT n -> n
       | UL_INTERFACE_IDENT n -> n
       | UL_FIN -> "EOF"
       | UL_ERREUR -> "Erreur Lexicale";;

(* string_of_stream : inputStream -> string *)
(* Converti un inputStream (liste de token) en une chaîne de caractère *)
let string_of_stream stream =
  List.fold_right (fun t tq -> (string_of_token t) ^ " " ^ tq ) stream "";;


(* peekAtFirstToken : inputStream -> token *)
(* Renvoie le premier élément d'un inputStream *)
(* Erreur : si l'inputStream est vide *)
let peekAtFirstToken stream = 
  match stream with
  (* Normalement, ne doit jamais se produire sauf si la grammaire essaie de lire *)
  (* après la fin de l'inputStream. *)
  | [] -> failwith "Impossible d'acceder au premier element d'un inputStream vide"
   |t::_ -> t;;

(* advanceInStream : inputStream -> inputStream *)
(* Consomme le premier élément d'un inputStream *)
(* Erreur : si l'inputStream est vide *)
let advanceInStream stream =
  match stream with
  (* Normalement, ne doit jamais se produire sauf si la grammaire essaie de lire *)
  (* après la fin de l'inputStream. *)
  | [] -> failwith "Impossible de consommer le premier element d'un inputStream vide"
  | _::q -> q;;
