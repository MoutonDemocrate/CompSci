
(* The type of tokens. *)

type token = 
  | UL_RIGHT_BRACE
  | UL_PACKAGE
  | UL_LEFT_BRACE
  | UL_IDENT_PACKAGE of (string)
  | UL_FIN

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val package: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (unit)
