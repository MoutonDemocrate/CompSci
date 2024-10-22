// Time-stamp: <11 oct 2024 08:19 Philippe Queinnec>

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: priorité aux lecteurs,
 * implantation: avec un moniteur. */
public class LectRed_PrioLecteur implements LectRed
{

    private ReentrantLock moniteur;
    private Condition AccesEcrr;
    private Condition AccesLecc;
    private int n_red;
    private int n_lec;
    private int n_lec_att;

    public LectRed_PrioLecteur() {
        moniteur = new java.util.concurrent.locks.ReentrantLock() ;
        AccesEcrr = moniteur.newCondition() ;
        AccesLecc = moniteur.newCondition() ;
        n_red = 0 ;
        n_lec = 0 ;
        n_lec_att = 0 ;
    }

    public void demanderEcriture() throws InterruptedException {
        moniteur.lock() ;
        while ( !((n_lec == 0) && (n_lec_att == 0) && (n_red == 0)) ) { // si not (n_lec = 0 and n_lec_att = 0) alors
            AccesEcrr.await() ;
        }
        // {n_lec = 0}
        n_red ++ ;
        // {n_lec = 0 and n_red > 0}
        AccesEcrr.signal() ;
        moniteur.unlock() ;
    }

    public void terminerEcriture() throws InterruptedException {
        moniteur.lock() ;
        // {n_red > 0 and n_lec = 0} # bon comportement + invariant
        n_red -- ; // n_red -= 1
        // {n_red >= 0 and n_lec = 0}
        if (n_red == 0) { // si (n_red = 0) alors
        //     {n_red = 0 and n_lec = 0}
            AccesLecc.signal() ; //     AccèsÉcr.signal
        } // finsi
        moniteur.unlock() ;
    }

    public void demanderLecture() throws InterruptedException {
        moniteur.lock() ;
        while ( !(n_red == 0) ) { // si not (n_red = 0 and n_lec = 0) alors
            n_lec_att ++ ; //     n_lec_att += 1
            AccesLecc.await() ; //     AccèsÉcr.wait
            n_lec_att -- ; //     n_lec_att -= 1
        } // finsi
        // {n_red = 0 and n_lec = 0}
        n_lec ++ ; // n_lec += 1
        // {n_red = 0 and n_lec = 1}
        moniteur.unlock() ;
        }

    public void terminerLecture() throws InterruptedException {
        moniteur.lock() ;
        // {n_red = 0 and n_lec = 1} # bon comportement + invariant
        n_lec -- ; // n_lec -= 1     
        // {n_red = 0 and n_lec = 0}
        if (n_lec_att > 0) { // si (n_lec_att > 0) alors
            AccesLecc.signal() ;//     AccèsÉcr.signal
        } else { // sinon
            AccesEcrr.signal() ; //     AccèsLec.signal
        } // finsi
        moniteur.unlock() ;
    }

    public String nomStrategie() {
        return "Stratégie: Priorité Lecteurs.";
    }
}
