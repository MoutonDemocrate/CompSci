# PIM -- TP5 -- Module et généricité

## Exercice I

**1)** C'est l'objectif de la spécification : on spécifie et commente les programmes là pour éviter de répéter ces commentaires trop souvent.

**2)** Les contrats sont formalisés dans la spécification aussi (`piles.ads`) sous forme de déclarations `Pre =>` et `Post =>`

**3)** On constate l'utilisation du keyword `generic`, qui symbolise la généricité du module. Ses paramètres sont `T_Element` et `Capacite`. <br>
Pour utiliser ce module, il faudra donc créer des instances typées :

```ada
procedure SomethType is new Someth (Type)
```

**4)** Il faudrait définir ce sous-programme dans `piles.adb`, et sa spécification dans `piles.ads`, dans la partie privée.

**5)** La surcharge consiste à donner à plusieurs fonctions ou procédures qui opèrent sur des types différents le même nom. Le programme choisira la fonction/procédure la plus adaptée dépendant du type des variables qu'on lui passe en arguments.

**6)** La procédure `Afficher_Element` est spécifiquement utilisée dans  la procédure `Afficher`. La seule partie générique de celle-ci étant `Afficher_Element`, on peut mettre cette dernière en paramètre de généricité de `Afficher`.

**7)** Il faut alors les différencier en utilisant des nouveaux packages... Dans l'exemple, on utilise `PPC1` et `PPC2` .



## Exercice II

 