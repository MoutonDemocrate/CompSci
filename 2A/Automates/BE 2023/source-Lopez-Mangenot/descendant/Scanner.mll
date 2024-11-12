{

(* Partie recopiée dans le fichier CaML généré. *)
(* Ouverture de modules exploités dans les actions *)
(* Déclarations de types, de constantes, de fonctions, d'exceptions exploités dans les actions *)

  open Tokens 
  exception Printf

}

(* Déclaration d'expressions régulières exploitées par la suite *)
let chiffre = ['0' - '9']
let minuscule = ['a' - 'z']
let majuscule = ['A' - 'Z']
let alphabet = minuscule | majuscule
let alphanum = alphabet | chiffre | '_'
let commentaire =
  (* Commentaire fin de ligne *)
  "#" [^'\n']*

rule scanner = parse
  | ['\n' '\t' ' ']+					{ (scanner lexbuf) }
  | commentaire						{ (scanner lexbuf) }
  | "{"							{ UL_LEFT_BRACE::(scanner lexbuf) }
  | "}"							{ UL_RIGHT_BRACE::(scanner lexbuf) }
  | "("							{ UL_LEFT_PAR::(scanner lexbuf) }
  | ")"							{ UL_RIGHT_PAR::(scanner lexbuf) }          
  | "package"						{ UL_PACKAGE::(scanner lexbuf) }
  | "interface"						{ UL_INTERFACE::(scanner lexbuf) }
  | "extends"						{ UL_EXTENDS::(scanner lexbuf) }
  | "boolean"						{ BOOL::(scanner lexbuf) }
  | "int"						{ INT::(scanner lexbuf) }
  | "void"						{ VOID::(scanner lexbuf) }
  | ","						{ VIRG::(scanner lexbuf) }
  | "."						{ PT::(scanner lexbuf) }
  | ";"						{ PTVIRG::(scanner lexbuf) }
  | minuscule alphabet* as name                         { (UL_PACKAGE_IDENT name)::(scanner lexbuf) }
  | majuscule alphabet* as name                         { (UL_INTERFACE_IDENT name)::(scanner lexbuf) }
  | eof							{ [UL_FIN] }
  | _ as texte				 		{ (print_string "Erreur lexicale : ");(print_char texte);(print_newline ()); (UL_ERREUR::(scanner lexbuf)) }

{

}
