import java.lang.annotation.Annotation;
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
				System.out.print(nom + " ·:·:· TESTING NOW ·:·:· ");
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

		// Instancier l'objet qui sera le r_cepteur des tests
		Object objet = classe.getConstructor().newInstance();

		// Ex_cuter les méthodes de préparation
		System.out.println("··· PREPARING ···") ;
		Arrays.stream(methodArray)
			.filter((Method e) -> e.isAnnotationPresent(Avant.class))
			.forEach((Method m) -> {
				System.out.println("- Invoking method : " + m.getName() + "...") ;
				try {
					m.invoke(objet) ;
				} catch (Exception e) {
					throw new RuntimeException(e);
				}
			}) ;
	



		Arrays.stream(methodArray)
			.filter((Method e) -> !e.isAnnotationPresent(Avant.class))
			.filter((Method e) -> !e.isAnnotationPresent(Apres.class))
			.filter((Method e) -> e.isAnnotationPresent(UnTest.class))
			.forEach((Method m) -> {
				try {
					if (m.getAnnotation(UnTest.class).enabled()) {
						System.out.println("- Testing method : " + m.getName() + "...") ;
						m.invoke(objet) ;
					} else {
						System.out.println("- Skipping method : " + m.getName() + "...") ;
					}
				} catch (Exception e) {
					if (m.getAnnotation(UnTest.class).expected().equals("Non")) {
						nbEchecs++;
						System.out.println(" --- Echec ---");
					} else if (m.getAnnotation(UnTest.class).expected().equals(e.getClass().getName())) {

					}

					if (e.getCause().getClass().getName() == "Echec") {
					} else {
	
					}
					nbErreurs++;
					System.out.println(" --- Erreur ---");
				}
			}) ;
		

		// Ex_cuter les méthodes de préparation
		System.out.println("··· CLEANING ···") ;
		Arrays.stream(methodArray)
			.filter((Method e) -> e.isAnnotationPresent(Apres.class))
			.forEach((Method m) -> {
				System.out.println("- Invoking method : " + m.getName() + "...") ;
				try {
					m.invoke(objet) ;
				} catch (Exception e) {
					throw new RuntimeException(e);
				}
			}) ;
	}

	public static void main(String... args) {
		LanceurIndependant lanceur = new LanceurIndependant(args);
		System.out.println("yo") ;
	}

}
