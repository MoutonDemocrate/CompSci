# Bases de données - Examen 2016 - Corrigé

## $I$ :: Normalisation Relationnelle

### Liste des attributs

- **Clients**
  
  - `p_pseudo`, `p_password`, `p_name`, `p_surname`, `p_nation`, `p_adress`, `p_score`, `p_VIPpaiddate`, `p_VIPexpdate`

- **Badges**
  
  - `b_name`, `b_value`, `b_desc`, `b_game`, `b_getdate`

- **Comments**
  
  - `c_author`, `c_content`, `c_postdate`, `c_game`, `c_note`

- **Game**
  
  - `g_name`, `g_registerdate`, `g_note`

### Liste des Dépendances Fonctionnelles et DMVs (?)

>  J'ai fait une table pour `truc` $\rightarrow$ `deps` sinon c'est très vite illisible
> 
> On rappelle que les dépendances, c'est des associations (genre association de truc à ces choses) (genre il existe une fonction qui prend truc en argument et qui renvoie ces choses ou rien)

| ID           | Truc                                  | Dépendances                                                                                  |
| ------------ | ------------------------------------- | -------------------------------------------------------------------------------------------- |
| $(1)$ [^(1)] | `p_pseudo`                            | `p_password`, `p_name`, `p_surname`, `p_address`, `p_VIPpaiddate`, `p_VIPexpdate`, `p_score` |
| $(2)$        | `p_pseudo`,`g_name`, `g_registerdate` | `g_note`                                                                                     |
| $(3)$        | `b_name`                              | `b_value`, `b_desc`, `g_name`, `g_registername`                                              |
| $(4)$        | `b_name`, `p_pseudo`                  | `b_getdate`                                                                                  |
| $(5)$        | `c_postdate`, `p_pseudo`              | `c_content`, `c_note`, `g_name`, `g_registerdate`                                            |
| $(6)$        | `p_pseudo`                            | `b_name`, `c_postdate`                                                                       |

### Décomposition en FNBC

$(1)$ + Théorème de Décomposition $\implies$ la base se décompose sans perte d'information (SPI) en Joueur (<u>`p_pseudo`</u>, `p_password`, `p_name`, `p_surname`, `p_address`, `p_VIPpaiddate`, `p_VIPexpdate`, `p_score`) + un *reste* 

$(2) \implies$ Note (<u>`Joueur`</u>, <u>`g_name`</u>, <u>`g_registername`</u>, `g_note`) + un *reste*

$(3) \implies$ Badge (<u>`b_name`</u>, `b_value`, `b_desc`, `g_name`, `g_registerdate`) + un *reste*

$(4) \implies$ Obtention (<u>`Badge`</u>, <u>`Joueur`</u>, `b_getdate`) + un *reste*

$(5) \implies$ Comm (<u>`Joueur`</u>, <u>`c_postdate`</u>, `c_content`, `c_note`, `g_name`, `g_registerdate`) + un *reste*

$(6) \implies$ Le reste se décompose SPI en (<u>`p_pseudo`</u>, <u>`b_name`</u>) et (<u>`p_pseudo`</u>, <u>`c_postdate`</u>) + un *reste*, mais ces deux-là sont redondantes

---

Tout ce qu'il y a au dessus DOIT figurer dans une copie pour avoir une bonne note, genre, 16 ou quoi.

---


