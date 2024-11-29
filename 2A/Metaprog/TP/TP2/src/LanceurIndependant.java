import java.lang.reflect.*;
import java.util.*;
import java.util.stream.Stream;

/** L'objectif est de faire un lanceur simple sans utiliser toutes les clases
  * de notre architecture JUnit.   Il permet juste de valider la compr_hension
  * de l'introspection en Java.
  */
public class LanceurIndependant {
	private int nbTestsLances;
	private int nbErreurs;
	private int nbEchecs;
	private List<Throwable> erreurs = new ArrayList<>();

	public LanceurIndependant(String... nomsClasses) {
	    System.out.println();

		// Lancer les tests pour chaque classe
		for (String nom : nomsClasses) {
				System.out.print(nom + " :: TESTING NOW :: ");
				System.out.println();
			try {
				this.testerUneClasse(nom);
				System.out.println();
			} catch (ClassNotFoundException e) {
				System.out.println(" Classe inconnue !");
			} catch (InvocationTargetException e) {
				System.out.println(" Problème : " + e.getCause());
				e.getCause().printStackTrace();
				erreurs.add(e) ;
			}
			 catch (Exception e) {
				System.out.println(" Problème généralisé : " + e);
				e.printStackTrace();
				erreurs.add(e) ;
			}
		}

		// // Afficher les erreurs
		// for (Throwable e : erreurs) {
		// 	System.out.println();
		// 	e.printStackTrace();	
		// }

		// Afficher un bilan
		System.out.println();
		System.out.printf("%d tests lancés dont %d échecs et %d erreurs.\n",
				nbTestsLances, nbEchecs, nbErreurs);
	}


	public int getNbTests() {
		return this.nbTestsLances;
	}


	public int getNbErreurs() {
		return this.nbErreurs;
	}


	public int getNbEchecs() {
		return this.nbEchecs;
	}


	private void testerUneClasse(String nomClasse)
		throws ClassNotFoundException, InstantiationException,
						  IllegalAccessException,
						  NoSuchMethodException,
						  InvocationTargetException
	{
		// R_cup_rer la classe
		Class<?> classe = Class.forName(nomClasse);
		Method[] methodArray = classe.getMethods();

		// R_cup_rer les méthodes "preparer" et "nettoyer"
		Method preparer = null;
		Method nettoyer = null;
		if (Arrays.stream(methodArray)
				.map((meth) -> meth.getName())
				.anyMatch("preparer"::equals)) {
			preparer = classe.getMethod("preparer") ;
		}
		if (Arrays.stream(methodArray)
				.map((meth) -> meth.getName())
				.anyMatch("nettoyer"::equals)) {
			preparer = classe.getMethod("nettoyer") ;
		}

		// Instancier l'objet qui sera le r_cepteur des tests
		Object objet = classe.getConstructor().newInstance();

		// Ex_cuter les m_thods de test
		for (Method method : methodArray) {
			nbTestsLances++;

			try {
				if (method.getName() == "preparer") {
					System.out.println("Preparing tests...") ;
					if (preparer != null) {
						preparer.invoke(objet) ;
					}
				} else if (method.getName() == "nettoyer") {
					System.out.println("Cleaning...") ;
					if (nettoyer != null) {
						nettoyer.invoke(objet) ;
					}
				} else if (method.getName().startsWith("test")) {
					System.out.println("Testing method : " + method.getName() + "...") ;
					method.invoke(objet) ;
				} else {
					System.out.println("Skipping method : " + method.getName()) ;
				}
			} catch (InvocationTargetException e) {
				if (e.getCause().getClass().getName() == "Echec") {
					nbEchecs++;
					System.out.println(" --- Echec ");
				} else {

				}
			} catch (Exception e) {
				nbErreurs++;
				System.out.println(" --- Erreur ");
			}
		}
	}

	public static void main(String... args) {
		LanceurIndependant lanceur = new LanceurIndependant(args);
		System.out.println("yo") ;
	}

}
