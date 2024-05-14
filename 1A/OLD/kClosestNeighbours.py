##
## Les bibliothèques utiles pour le TD
import numpy as np
import os #
from sqlite3 import *

def requete(chaine):
    """
    fonction pour interroger la base de données Iris.sqlite
    Argument : chaine, du type string, est la requête  en sql
    La fonction renvoie le résultat de la requête sous la forme d'une liste de tuples.
    exemples :
    >>> requete("SELECT COUNT(*) FROM iris;") # le nombre d'élèments dans la table iris
    [(150,)]
    >>> requete("SELECT * FROM iris WHERE Id=26;") # l'iris qui a pour clé primaire 26
    [(26, 5.0, 3.0, 1.6, 0.2, 'Iris-setos')]
    >>> requete("SELECT * FROM iris JOIN especes ON iris.idEspece=especes.Id WHERE SepalWidthCm=3.0 AND espece='Iris-setos' ;") # les iris qui sont identifiés comme Iris-setos et ont pour largeur de sépale 3.0
    [(26, 5.0, 3.0, 1.6, 0.2, 'Iris-setos'), (39, 4.4, 3.0, 1.3, 0.2, 'Iris-setos'), (46, 4.8, 3.0, 1.4, 0.3, 'Iris-setos')]
    """
    bddiris=connect("Iris.sqlite") #Connection a une base ou creation
    c=bddiris.cursor()
    resultatRequete='il y a une erreur dans votre requete'
    try :
        c.execute(chaine)
        resultatRequete = c.fetchall()
        bddiris.close()
    except :
        bddiris.close()
    return resultatRequete