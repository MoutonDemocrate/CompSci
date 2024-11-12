
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | UL_RIGHT_BRACE
    | UL_PACKAGE
    | UL_LEFT_BRACE
    | UL_IDENT_PACKAGE of (
# 16 "Parser.mly"
       (string)
# 18 "Parser.ml"
  )
    | UL_FIN
  
end

include MenhirBasics

# 1 "Parser.mly"
  

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)


# 34 "Parser.ml"

type ('s, 'r) _menhir_state

and _menhir_box_package = 
  | MenhirBox_package of (unit) [@@unboxed]

let _menhir_action_1 =
  fun () ->
    (
# 32 "Parser.mly"
                                                                            ( (print_endline "package : package IDENT_PACKAGE { }") )
# 46 "Parser.ml"
     : (unit))

let _menhir_action_2 =
  fun () ->
    (
# 30 "Parser.mly"
                                  ( (print_endline "package : internal_package FIN") )
# 54 "Parser.ml"
     : (unit))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | UL_FIN ->
        "UL_FIN"
    | UL_IDENT_PACKAGE _ ->
        "UL_IDENT_PACKAGE"
    | UL_LEFT_BRACE ->
        "UL_LEFT_BRACE"
    | UL_PACKAGE ->
        "UL_PACKAGE"
    | UL_RIGHT_BRACE ->
        "UL_RIGHT_BRACE"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_0 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_package =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_PACKAGE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_IDENT_PACKAGE _ ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | UL_LEFT_BRACE ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | UL_RIGHT_BRACE ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      let _ = _menhir_action_1 () in
                      (match (_tok : MenhirBasics.token) with
                      | UL_FIN ->
                          let _v = _menhir_action_2 () in
                          MenhirBox_package _v
                      | _ ->
                          _eRR ())
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
end

let package =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_package v = _menhir_run_0 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v

# 34 "Parser.mly"
  


# 123 "Parser.ml"
