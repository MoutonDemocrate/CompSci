# Programmation Avancée - TP02
## Inversion de contrôle

### Exercice 1

- Résultat de `Analyseur.java`
	```
	{Position@400(2,1)=18.0, Position@3e1(1,1)=39.4, Position@3e2(1,2)=20.0}
	Nombres de positions : 3
	```
- Résultat de `analyseur.py`
	```
	Statistiques : 3 données [(x=1,y=1) : cumul=39.4], [(x=1,y=2) : cumul=20.0], [(x=2,y=1) : cumul=18.0]
	Cumuls : {(1, 1): 39.4, (1, 2): 20.0, (2, 1): 18.0}
	Nombre de positions : 3
	```

### Exercice 2

On modifie la méthode `charger` pour prendre un argument `String path` qui représente le nom du fichier à charger.

On lit ensuite les arguments pour charger les fichiers :
```java
public static void main(String[] args) {
	Analyseur a = new Analyseur();
	for (int i = 0; i < args.length ; i++) {
		a.charger(args[i]);
	}
	System.out.println(a.donnees());
	System.out.println("Nombres de positions : " + a.donnees().size());
}
```

### Exercice 3

On crée une nouvelle exception, `MalformedFileException` :
```java
public class MalformedFileException extends Exception {

	// Parameterless Constructor
	public MalformedFileException() {}

	// Constructor that accepts a message
	public MalformedFileException(String message)
	{
	super(message);
	}
}
```
On peut ensuite la soulever avec un message d'erreur approprié lorsque la valeur détectée est négative :
```java
...
double valeur = Double.parseDouble(mots[3]);
		if (valeur < 0) {
			throw new MalformedFileException("Le fichier contient une valeur négative !") ;
		}
		cumuls.put(p, valeur(p) + valeur);
		// p.setY(p.getY() + 1);	//  p.y += 1;
	}
} catch (IOException e) {
	throw new RuntimeException(e);
} catch (MalformedFileException e) {
	throw new RuntimeException(e);
}
```

### Exercice 4

On teste au début de la méthode `charger` si le fichier est de type `-f2.txt` :
```java
if (path.endsWith("-f2.txt")) {
	System.out.println("Format : txt2");
	String ligne = null;
	while ((ligne = in.readLine()) != null) {
		String[] mots = ligne.split("\\s+");
		assert mots.length == 6;	// 4 mots sur chaque ligne
		// System.out.println("Mots : " + String.join(",",mots));
		int x = Integer.parseInt(mots[1]);
		int y = Integer.parseInt(mots[2]);
		Position p = new Position(x, y);
		double valeur = Double.parseDouble(mots[4]);
		if (valeur < 0) {
			throw new MalformedFileException("Le fichier contient une valeur négative !") ;
		}
		cumuls.put(p, valeur(p) + valeur);
		// p.setY(p.getY() + 1);	//  p.y += 1;
	}
} else if (path.endsWith(".txt")) {
	System.out.println("Format : txt");
	String ligne = null;
	while ((ligne = in.readLine()) != null) {
		String[] mots = ligne.split("\\s+");
		assert mots.length == 4;	// 4 mots sur chaque ligne
		int x = Integer.parseInt(mots[0]);
		int y = Integer.parseInt(mots[1]);
		Position p = new Position(x, y);
		double valeur = Double.parseDouble(mots[3]);
		if (valeur < 0) {
			throw new MalformedFileException("Le fichier contient une valeur négative !") ;
		}
		cumuls.put(p, valeur(p) + valeur);
		// p.setY(p.getY() + 1);	//  p.y += 1;
	}
}
```