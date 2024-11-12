%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

%token PT
%token UL_PAR_OPEN UL_PAR_CLOSE

/* Defini le type des donnees associees a l'unite lexicale */

%token <string> UL_IDENT
%token <string> UL_ENTIER

/* Unite lexicale particuliere qui represente la fin du fichier */

%token UL_FIN

/* Type renvoye pour le nom terminal document */
%type <unit> scheme

/* Le non terminal document est l'axiome */
%start scheme

%% /* Regles de productions */

scheme : expression UL_FIN { (print_endline "scheme : expression UL_FIN ") }

expression : | expression_par { (print_endline "expression : expression_par") }
				| UL_ENTIER { (print_endline "expression : entier") }
				| UL_IDENT { (print_endline "expression : ident") }

expression_et : | expression { (print_endline "expression_et : expression ") }
				| expression expression_et { ( print_endline "expression_et : expression expression_et ") }

expression_par : | UL_PAR_OPEN expression_et UL_PAR_CLOSE { (print_endline "expression_par : UL_PAR_OPEN expression_et UL_PAR_CLOSE ") }
				 | UL_PAR_OPEN UL_PAR_CLOSE { (print_endline "expression_par : UL_PAR_OPEN UL_PAR_CLOSE ") }
				 | UL_PAR_OPEN expression PT expression UL_PAR_CLOSE { (print_endline "expression_par : UL_PAR_OPEN expression PT expression UL_PAR_CLOSE ") }

%%
