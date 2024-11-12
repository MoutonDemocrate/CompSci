%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

%token UL_PACKAGE UL_INTERFACE UL_EXTENDS
%token UL_LEFT_BRACE UL_RIGHT_BRACE
%token UL_LEFT_PAR UL_RIGHT_PAR
%token BOOL INT VOID
%token VIRG PT PTVIRG


/* Defini le type des donnees associees a l'unite lexicale */

%token <string> UL_IDENT_PACKAGE
%token <string> UL_IDENT_INTERFACE

/* Unite lexicale particuliere qui represente la fin du fichier */

%token UL_FIN

/* Type renvoye pour le nom terminal document */
%type <unit> package

/* Le non terminal document est l'axiome */
%start package

%% /* Regles de productions */""

package :   | internal_package UL_FIN        {(print_endline "package : internal_package UL_FIN")}
            internal_package :  | UL_PACKAGE UL_IDENT_PACKAGE UL_LEFT_BRACE internal_package membre UL_RIGHT_BRACE  {(print_endline "internal_package : UL_PACKAGE UL_IDENT_PACKAGE UL_LEFT_BRACE internal_package membre UL_RIGHT_BRACE")}
                                | UL_PACKAGE UL_IDENT_PACKAGE UL_LEFT_BRACE interface membre UL_RIGHT_BRACE         {(print_endline "internal_package : UL_PACKAGE UL_IDENT_PACKAGE UL_LEFT_BRACE interface membre UL_RIGHT_BRACE")}
            membre :    |                                      {(print_endline "membre : lambda")}
                        | interface membre                     {(print_endline "membre : interface membre")}
                        | internal_package membre              {(print_endline "membre : internal_package membre")}
            



interface :     | UL_INTERFACE UL_IDENT_INTERFACE UL_LEFT_BRACE methode_et UL_RIGHT_BRACE                               {(print_endline "interface : UL_INTERFACE UL_IDENT_INTERFACE UL_LEFT_BRACE methode_et UL_RIGHT_BRACE")}
                | UL_INTERFACE UL_IDENT_INTERFACE UL_EXTENDS nomsQualifies UL_LEFT_BRACE methode_et UL_RIGHT_BRACE      {(print_endline "interface : UL_INTERFACE UL_IDENT_INTERFACE UL_EXTENDS nomsQualifies UL_LEFT_BRACE methode_et UL_RIGHT_BRACE")}
                methode_et :    |                                                                                       {(print_endline "methode_et : lambda")}
                                | methode methode_et                                                                    {(print_endline "methode_et : methode methode_et")}
                nomsQualifies : | nomQualifie                                                                           {(print_endline "nomsQualifies : nomQualifie")}
                                | nomQualifie VIRG nomsQualifies                                                     {(print_endline "nomsQualifies : nomQualifie VIRG nomsQualifies")}

nomQualifie :   | pt_ident_et UL_IDENT_INTERFACE                                {(print_endline "nomQualifie : pt_ident_et UL_IDENT_INTERFACE")}
                pt_ident_et :   |                                               {(print_endline "pt_ident_et : lambda")}
                                | UL_IDENT_PACKAGE PT pt_ident_et               {(print_endline "pt_ident_et : UL_IDENT_PACKAGE PT pt_ident_et")}

methode :   | typeBase UL_IDENT_PACKAGE UL_LEFT_PAR UL_RIGHT_PAR PTVIRG           {(print_endline "methode : typeBase UL_IDENT_PACKAGE UL_LEFT_PAR UL_RIGHT_BRACE PTVIRG")}
            | typeBase UL_IDENT_PACKAGE UL_LEFT_PAR types UL_RIGHT_PAR PTVIRG     {(print_endline "methode : typeBase UL_IDENT_PACKAGE UL_LEFT_PAR types UL_RIGHT_BRACE PTVIRG")}
            types : | typeBase                                                      {(print_endline "types : typeBase")}
                    | typeBase VIRG types                                           {(print_endline "types : typeBase VIRG types")}

typeBase :  | BOOL              {(print_endline "typeBase : BOOL")}
            | INT               {(print_endline "typeBase : INT")}
            | VOID              {(print_endline "typeBase : VOID")}
            | nomQualifie       {(print_endline "typeBase : nomQualifie")}
                
 /*
package : internal_package UL_FIN { (print_endline "package : internal_package FIN") }

internal_package : UL_PACKAGE UL_IDENT_PACKAGE UL_LEFT_BRACE UL_RIGHT_BRACE { (print_endline "package : package IDENT_PACKAGE { }") }
*/
%%

