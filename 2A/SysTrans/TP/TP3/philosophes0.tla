---------------- MODULE philosophes0 ----------------
(* Philosophes. Version en utilisant l'état des voisins. *)

EXTENDS Naturals

CONSTANT N

Philos == 0..N-1

gauche(i) == (i+1)%N       \* philosophe à gauche du philo n°i
droite(i) == (i+N-1)%N     \* philosophe à droite du philo n°i

Hungry == "H"
Thinking == "T"
Eating == "E"

VARIABLES
    etat         \* i -> Hungry,Thinking,Eating

TypeOK == [](etat \in [ Philos -> { Hungry, Thinking, Eating }])

(* TODO : autres propriétés de philosophes0 (exclusion, vivacité) *)  

ExclMutuelle == (\A i, j, k \in Philos : 
    (
        etat[i] = Eating
        /\ (etat[j] = Eating \/ etat[k = Eating])
        /\ j = gauche(i)
        /\ k = droite(i)
    ) => i = j)

VivaciteIndividuelle == (\A i \in Philos: etat[i] = Hungry ~> etat[i] = Eating)
VivaciteGlobale == (\E i \in Philos : etat[i] = Hungry) ~> (\E j \in Philos : etat[j] = Eating)

----------------------------------------------------------------

Init == 
    /\ etat = [i \in Philos |-> Thinking] (* Initalise state *)


demander(i) ==
    /\ etat[i] = Thinking
    /\ etat' = [ etat EXCEPT ![i] = Hungry ]

manger(i) ==
    /\ etat[i] = Hungry
    /\ etat[gauche(i)] # Eating
    /\ etat[droite(i)] # Eating
    /\ etat' = [ etat EXCEPT ![i] = Eating ]

penser(i) ==
    /\ etat[i] = Eating
    /\ etat' = [ etat EXCEPT ![i] = Thinking ]

Next ==
  \E i \in Philos : \/ demander(i)
                    \/ manger(i)
                    \/ penser(i)

Fairness ==  \A i \in Philos :
    /\ WF_<<etat>> (penser(i))
    /\ SF_<<etat>> (demander(i))
    /\ SF_<<etat>> (manger(i))

Spec ==
  /\ Init
  /\ [] [ Next ]_<<etat>>
  /\ Fairness

================================
