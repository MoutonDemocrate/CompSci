# Programmation impérative <BR> TD 3 -- Sous-programmes

## Exercice 1

1)

| Spécification | Valeur |
| ---- | ---- |
| Nom de la procédure | Puissance |
| Objectif | Calculer la puissance entière d'un réel |
| Paramètres | `nombre : in Réel` <br> `exposant : in Entier` <br> `puissance : out Entier` |
| Type de sous-programme | Fonction |
| Pré-conditions | `nombre != 0 OR exposant >= 0` |
| Post-conditions | `puissance = nombre ^ exposant` |
| Test / Exemples | `Puissance(5,5) -> 25` <br> `Puissance(1,9999) -> 1` <br> `Puissance(7,3) -> 294` <br> `Puissance(2.5,5) -> 97.65625` |
| Exceptions | Aucunes |


2)

| Spécification | Valeur |
| ---- | ---- |
| Nom de la procédure | EntrerEntier |
| Objectif | Permettre à l'utilisateur d'entrer un entier au clavier |
| Paramètres | `nombre : out Entier` |
| Type de sous-programme | Procédure |
| Pré-conditions | `None` |
| Post-conditions | `nombre = Get()` |
| Test / Exemples | `EntrerEntier() -> Get()` <br> `nombre is Int` <br> `nombre != ""` |
| Exceptions | Aucunes |

3)

| Spécification | Valeur |
| ---- | ---- |
| Nom de la procédure | EstBiss |
| Objectif | Trouver si une année (représentée par un entier) est bissextile ou non |
| Paramètres | `annee : in Entier` <br> `estBiss : out Bool` |
| Type de sous-programme | Fonction |
| Pré-conditions | `annee >= 0` |
| Post-conditions | `estBiss = True ssi annee` |
| Test / Exemples | `EstBiss(2016) -> True` <br> `EstBiss(2017) -> False` <br> `EstBiss(2024) -> True` <br> `EstBiss(175) -> False` |
| Exceptions | Aucunes |

4)

| Spécification | Valeur |
| ---- | ---- |
| Nom de la procédure | PGCD |
| Objectif | Calculer le PGCD de deux entiers strictement positifs |
| Paramètres | `a : in Entier` <br> `b : in Entier` <br> `pgcd : out Entier` |
| Type de sous-programme | Fonction |
| Pré-conditions | `a > 0 AND b > 0` |
| Post-conditions | `pgcd = PGCD(a,b)` |
| Test / Exemples | `oh c'est bon t'as compris` |
| Exceptions | Aucunes |

5)

| Spécification | Valeur |
| ---- | ---- |
| Nom de la procédure | DivAvecReste |
| Objectif | Obtenir le quotient et le reste d'une division euclidienne entière |
| Paramètres | `nombre : in Entier` <br> `diviseur : in Entier` <br> `quotient : out Entier` <br> `reste : out Entier` |
| Type de sous-programme | Procédure |
| Pré-conditions | `diviseur != 0` |
| Post-conditions | `nombre = quotient * diviseur + reste` |
| Test / Exemples | `t'as compris l'idée` |
| Exceptions | Aucunes |

6)

| Spécification | Valeur |
| ---- | ---- |
| Nom de la procédure |  |
| Objectif |  |
| Paramètres |  |
| Type de sous-programme |  |
| Pré-conditions |  |
| Post-conditions |  |
| Test / Exemples |  |
| Exceptions |  |

7)

| Spécification | Valeur |
| ---- | ---- |
| Nom de la procédure |  |
| Objectif |  |
| Paramètres |  |
| Type de sous-programme |  |
| Pré-conditions |  |
| Post-conditions |  |
| Test / Exemples |  |
| Exceptions |  |