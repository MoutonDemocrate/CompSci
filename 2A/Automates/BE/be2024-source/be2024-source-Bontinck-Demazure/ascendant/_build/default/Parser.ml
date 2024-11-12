
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | UL_PAR_OPEN
    | UL_PAR_CLOSE
    | UL_IDENT of (
# 16 "Parser.mly"
       (string)
# 17 "Parser.ml"
  )
    | UL_FIN
    | UL_ENTIER of (
# 17 "Parser.mly"
       (string)
# 23 "Parser.ml"
  )
    | PT
  
end

include MenhirBasics

# 1 "Parser.mly"
  

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)


# 39 "Parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_scheme) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: scheme. *)

  | MenhirState01 : (('s, _menhir_box_scheme) _menhir_cell1_UL_PAR_OPEN, _menhir_box_scheme) _menhir_state
    (** State 01.
        Stack shape : UL_PAR_OPEN.
        Start symbol: scheme. *)

  | MenhirState08 : ((('s, _menhir_box_scheme) _menhir_cell1_UL_PAR_OPEN, _menhir_box_scheme) _menhir_cell1_expression, _menhir_box_scheme) _menhir_state
    (** State 08.
        Stack shape : UL_PAR_OPEN expression.
        Start symbol: scheme. *)

  | MenhirState09 : (((('s, _menhir_box_scheme) _menhir_cell1_UL_PAR_OPEN, _menhir_box_scheme) _menhir_cell1_expression, _menhir_box_scheme) _menhir_cell1_PT, _menhir_box_scheme) _menhir_state
    (** State 09.
        Stack shape : UL_PAR_OPEN expression PT.
        Start symbol: scheme. *)

  | MenhirState13 : ((('s, _menhir_box_scheme) _menhir_cell1_expression, _menhir_box_scheme) _menhir_cell1_expression, _menhir_box_scheme) _menhir_state
    (** State 13.
        Stack shape : expression expression.
        Start symbol: scheme. *)


and ('s, 'r) _menhir_cell1_expression = 
  | MenhirCell1_expression of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_PT = 
  | MenhirCell1_PT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_UL_PAR_OPEN = 
  | MenhirCell1_UL_PAR_OPEN of 's * ('s, 'r) _menhir_state

and _menhir_box_scheme = 
  | MenhirBox_scheme of (unit) [@@unboxed]

let _menhir_action_01 =
  fun () ->
    (
# 33 "Parser.mly"
                              ( (print_endline "expression : expression_par") )
# 85 "Parser.ml"
     : (unit))

let _menhir_action_02 =
  fun () ->
    (
# 34 "Parser.mly"
                ( (print_endline "expression : entier") )
# 93 "Parser.ml"
     : (unit))

let _menhir_action_03 =
  fun () ->
    (
# 35 "Parser.mly"
               ( (print_endline "expression : ident") )
# 101 "Parser.ml"
     : (unit))

let _menhir_action_04 =
  fun () ->
    (
# 37 "Parser.mly"
                             ( (print_endline "expression_et : expression ") )
# 109 "Parser.ml"
     : (unit))

let _menhir_action_05 =
  fun () ->
    (
# 38 "Parser.mly"
                               ( ( print_endline "expression_et : expression expression_et ") )
# 117 "Parser.ml"
     : (unit))

let _menhir_action_06 =
  fun () ->
    (
# 40 "Parser.mly"
                                                          ( (print_endline "expression_par : UL_PAR_OPEN expression_et UL_PAR_CLOSE ") )
# 125 "Parser.ml"
     : (unit))

let _menhir_action_07 =
  fun () ->
    (
# 41 "Parser.mly"
                                ( (print_endline "expression_par : UL_PAR_OPEN UL_PAR_CLOSE ") )
# 133 "Parser.ml"
     : (unit))

let _menhir_action_08 =
  fun () ->
    (
# 42 "Parser.mly"
                                                         ( (print_endline "expression_par : UL_PAR_OPEN expression PT expression UL_PAR_CLOSE ") )
# 141 "Parser.ml"
     : (unit))

let _menhir_action_09 =
  fun () ->
    (
# 31 "Parser.mly"
                           ( (print_endline "scheme : expression UL_FIN ") )
# 149 "Parser.ml"
     : (unit))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | PT ->
        "PT"
    | UL_ENTIER _ ->
        "UL_ENTIER"
    | UL_FIN ->
        "UL_FIN"
    | UL_IDENT _ ->
        "UL_IDENT"
    | UL_PAR_CLOSE ->
        "UL_PAR_CLOSE"
    | UL_PAR_OPEN ->
        "UL_PAR_OPEN"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_15 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_scheme =
    fun _menhir_stack _tok ->
      match (_tok : MenhirBasics.token) with
      | UL_FIN ->
          let _v = _menhir_action_09 () in
          MenhirBox_scheme _v
      | _ ->
          _eRR ()
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_scheme) _menhir_state -> _menhir_box_scheme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_PAR_OPEN ->
          let _menhir_stack = MenhirCell1_UL_PAR_OPEN (_menhir_stack, _menhir_s) in
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState01
      | UL_PAR_CLOSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _ = _menhir_action_07 () in
          _menhir_goto_expression_par _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | UL_IDENT _ ->
          let _menhir_stack = MenhirCell1_UL_PAR_OPEN (_menhir_stack, _menhir_s) in
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState01
      | UL_ENTIER _ ->
          let _menhir_stack = MenhirCell1_UL_PAR_OPEN (_menhir_stack, _menhir_s) in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState01
      | _ ->
          _eRR ()
  
  and _menhir_goto_expression_par : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_scheme) _menhir_state -> _ -> _menhir_box_scheme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      let _v = _menhir_action_01 () in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expression : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_scheme) _menhir_state -> _ -> _menhir_box_scheme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_15 _menhir_stack _tok
      | MenhirState13 ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState08 ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState09 ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState01 ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_13 : type  ttv_stack. ((ttv_stack, _menhir_box_scheme) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_scheme) _menhir_state -> _ -> _menhir_box_scheme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | UL_PAR_OPEN ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState13
      | UL_IDENT _ ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState13
      | UL_ENTIER _ ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState13
      | UL_PAR_CLOSE ->
          let _ = _menhir_action_04 () in
          _menhir_goto_expression_et _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_03 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_scheme) _menhir_state -> _menhir_box_scheme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_03 () in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_scheme) _menhir_state -> _menhir_box_scheme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_02 () in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expression_et : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_scheme) _menhir_state -> _menhir_box_scheme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState13 ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState08 ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState01 ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_12 : type  ttv_stack. (ttv_stack, _menhir_box_scheme) _menhir_cell1_expression -> _ -> _ -> _menhir_box_scheme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_expression (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_05 () in
      _menhir_goto_expression_et _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_run_06 : type  ttv_stack. (ttv_stack, _menhir_box_scheme) _menhir_cell1_UL_PAR_OPEN -> _ -> _ -> _menhir_box_scheme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_UL_PAR_OPEN (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_06 () in
      _menhir_goto_expression_par _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
  
  and _menhir_run_10 : type  ttv_stack. (((ttv_stack, _menhir_box_scheme) _menhir_cell1_UL_PAR_OPEN, _menhir_box_scheme) _menhir_cell1_expression, _menhir_box_scheme) _menhir_cell1_PT -> _ -> _ -> _ -> _menhir_box_scheme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      match (_tok : MenhirBasics.token) with
      | UL_PAR_CLOSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_PT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expression (_menhir_stack, _, _) = _menhir_stack in
          let MenhirCell1_UL_PAR_OPEN (_menhir_stack, _menhir_s) = _menhir_stack in
          let _ = _menhir_action_08 () in
          _menhir_goto_expression_par _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_08 : type  ttv_stack. ((ttv_stack, _menhir_box_scheme) _menhir_cell1_UL_PAR_OPEN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_scheme) _menhir_state -> _ -> _menhir_box_scheme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | UL_PAR_OPEN ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | UL_IDENT _ ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | UL_ENTIER _ ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | PT ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_PT (_menhir_stack, MenhirState08) in
          let _menhir_s = MenhirState09 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_PAR_OPEN ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UL_IDENT _ ->
              _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | UL_ENTIER _ ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | UL_PAR_CLOSE ->
          let _ = _menhir_action_04 () in
          _menhir_goto_expression_et _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  let _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_scheme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState00 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_PAR_OPEN ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | UL_IDENT _ ->
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | UL_ENTIER _ ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
end

let scheme =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_scheme v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v

# 44 "Parser.mly"
  

# 350 "Parser.ml"
