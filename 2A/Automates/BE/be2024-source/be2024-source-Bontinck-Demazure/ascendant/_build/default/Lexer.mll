{

(* Partie recopiée dans le fichier CaML généré. *)
(* Ouverture de modules exploités dans les actions *)
(* Déclarations de types, de constantes, de fonctions, d'exceptions exploités dans les actions *)

  open Parser 
  exception LexicalError

}

(* Déclaration d'expressions régulières exploitées par la suite *)
let chiffre = ['0' - '9']
let un_a_neuf = ['1' - '9']
let minuscule = ['a' - 'z']
let majuscule = ['A' - 'Z']
let alphabet = minuscule | majuscule
let alphanum = alphabet | chiffre | '_'
let commentaire =
  (* Commentaire fin de ligne *)
  "#" [^'\n']*

rule lexer = parse
  | ['\n' '\t' ' ']+					{ (lexer lexbuf) }
  | commentaire						{ (lexer lexbuf) }
  | '('     { UL_PAR_OPEN }
  | ')'     { UL_PAR_CLOSE }
  | ('0'|(un_a_neuf chiffre*)) as texte  { UL_ENTIER texte }
  | '.'     { PT }
  | (majuscule alphabet*)+ as texte         { UL_IDENT texte }
  | eof							{ UL_FIN }
  | _ as texte				 		{ (print_string "Erreur lexicale : ");(print_char texte);(print_newline ()); raise LexicalError }

{

}

(* (* Déclaration d'expressions régulières exploitées par la suite *)
let chiffre = ['0' - '9']
let minuscule = ['a' - 'z']
let majuscule = ['A' - 'Z']
let alphabet = minuscule | majuscule
let alphanum = alphabet | chiffre | '_'
let commentaire =
  (* Commentaire fin de ligne *)
  "#" [^'\n']*

rule lexer = parse
  | ['\n' '\t' ' ']+					{ (lexer lexbuf) }
  | commentaire						{ (lexer lexbuf) }
  | "{"							{ UL_LEFT_BRACE }
  | "}"							{ UL_RIGHT_BRACE }
  | "("							{ UL_LEFT_PAR }
  | ")"							{ UL_RIGHT_PAR }
  | "package"						{ UL_PACKAGE }
  | "interface" { UL_INTERFACE }
  | "extends" { UL_EXTENDS }
  | "boolean" { BOOL }
  | "int" { INT }
  | "void" { VOID }
  | "," { VIRG }
  | "." { PT }
  | ";" { PTVIRG }
  | minuscule alphabet* as name  { UL_IDENT_PACKAGE name }
  | majuscule alphabet* as name  { UL_IDENT_INTERFACE name }
  | eof							{ UL_FIN }
  | _ as texte				 		{ (print_string "Erreur lexicale : ");(print_char texte);(print_newline ()); raise LexicalError }
 *)