import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.locks.Condition;

/* Squelette d'une solution avec un moniteur.
 * Il manque le moniteur (verrou + variables conditions).
 */
public class PhiloMon implements StrategiePhilo {

    // État d'un philosophe : pense, mange, demande ?
    private EtatPhilosophe[] etat;

    private ReentrantLock monitor ;
    private Condition AccesSpaghetti ;
    private int nb_philo ;

    /****************************************************************/

    public PhiloMon (int nbPhilosophes) {
        this.etat = new EtatPhilosophe[nbPhilosophes];
        for (int i = 0; i < nbPhilosophes; i++) {
            etat[i] = EtatPhilosophe.Pense;
        }
        monitor = new ReentrantLock() ;
        AccesSpaghetti = monitor.newCondition() ;
        nb_philo = nbPhilosophes ;
    }

    public void demanderFourchettes (int no) throws InterruptedException
    {
        monitor.lock() ;
        etat[no] = EtatPhilosophe.Demande;
        while ((etat[(no + 1) % nb_philo] == EtatPhilosophe.Mange) && (etat[(no - 1) % nb_philo] == EtatPhilosophe.Mange)) {
            AccesSpaghetti.await() ;
        }
        etat[no] = EtatPhilosophe.Mange;
        // j'ai les fourchette G et D
        IHMPhilo.poser (Main.FourchetteGauche(no), EtatFourchette.AssietteDroite);
        IHMPhilo.poser (Main.FourchetteDroite(no), EtatFourchette.AssietteGauche);
        monitor.unlock() ;
    }

    public void libererFourchettes (int no)
    {
        monitor.lock() ;
        IHMPhilo.poser (Main.FourchetteGauche(no), EtatFourchette.Table);
        IHMPhilo.poser (Main.FourchetteDroite(no), EtatFourchette.Table);
        etat[no] = EtatPhilosophe.Pense;
        AccesSpaghetti.signal() ;
        monitor.unlock() ;
    }

    public String nom() {
        return "Moniteur";
    }

}

