
(* The type of tokens. *)

type token = 
  | UL_PAR_OPEN
  | UL_PAR_CLOSE
  | UL_IDENT of (string)
  | UL_FIN
  | UL_ENTIER of (string)
  | PT

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val scheme: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (unit)
