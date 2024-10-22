// Time-stamp: <11 oct 2024 08:19 Philippe Queinnec>

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: équitable,
 * implantation: avec un moniteur. */
public class LectRed_Equitable implements LectRed
{

    private ReentrantLock moniteur;
    private Condition AccesEcrr;
    private Condition AccesLecc;
    private int n_red;
    private int n_red_att;
    private int n_lec;
    private int n_lec_att;
    private boolean turn_red ;

    public LectRed_Equitable() {
        moniteur = new java.util.concurrent.locks.ReentrantLock() ;
        AccesEcrr = moniteur.newCondition() ;
        AccesLecc = moniteur.newCondition() ;
        n_red = 0 ;
        n_red_att = 0 ;
        n_lec = 0 ;
        n_lec_att = 0 ;
    }

    public void demanderEcriture() throws InterruptedException {
        moniteur.lock() ;
        while ( !(turn_red && (n_red == 0) && (n_lec == 0)) ) { 
            n_red_att ++ ;
            AccesEcrr.await() ;
            n_red_att -- ;
        }
        n_red ++ ;
        AccesEcrr.signal() ;
        moniteur.unlock() ;
    }

    public void terminerEcriture() throws InterruptedException {
        moniteur.lock() ;
        n_red -- ;
        turn_red = false ;
        AccesLecc.signal() ;
        moniteur.unlock() ;
    }

    public void demanderLecture() throws InterruptedException {
        moniteur.lock() ;
        while ( !((!turn_red) && (n_red == 0)) ) { 
            n_lec_att ++ ; 
            AccesLecc.await() ; 
            n_lec_att -- ; 
        }
        n_lec ++ ;
        moniteur.unlock() ;
        }

    public void terminerLecture() throws InterruptedException {
        moniteur.lock() ;
        n_lec -- ;
        if (n_red_att > 0) {
            turn_red = true ;
            AccesEcrr.signal() ;
        } else {
            AccesLecc.signal() ;
        }
        moniteur.unlock() ;
    }

    public String nomStrategie() {
        return "Stratégie: Équitable.";
    }
}
