---------------- MODULE philosophes_fork ----------------
(* Philosophes. Version en utilisant l'état des voisins. *)

EXTENDS Naturals

CONSTANT N

Philos == 0..N-1
Forks == 0..N-1

gauche(i) == (i+1)%N       \* philosophe à gauche du philo n°i
droite(i) == (i+N-1)%N     \* philosophe à droite du philo n°i

forkGauche(i) == (i)%(N-1)
forkDroite(i) == (i+1)%(N-1)

Hungry == "H"
Thinking == "T"
Eating == "E"

Up == "U"
Down == "D"

VARIABLES
    etat,                \* i -> Hungry,Thinking,Eating
    forkState,           \* i -> Up, Down
    hasLeftFork,         \* i -> TRUE, FALSE
    hasRightFork        \* i -> TRUE, FALSE

TypeOK == 
    /\ [](etat \in [ Philos -> { Hungry, Thinking, Eating }])
    /\ [](forkState \in [ Forks -> { Up, Down }])
    /\ [](hasLeftFork \in [ Philos -> { TRUE, FALSE }])
    /\ [](hasRightFork \in [ Philos -> { TRUE, FALSE }])
    

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

Init == (* Initalise state *)
    /\ etat = [i \in Philos |-> Thinking] 
    /\ forkState = [i \in Forks |-> Down] 
    /\ hasLeftFork = [i \in Philos |-> FALSE] 
    /\ hasRightFork = [i \in Philos |-> FALSE] 


demander(i) ==
    /\ etat[i] = Thinking
    /\ UNCHANGED forkState
    /\ UNCHANGED hasLeftFork
    /\ UNCHANGED hasRightFork
    /\ etat' = [ etat EXCEPT ![i] = Hungry ]

prendre_fork_g(i) ==
    /\ (!hasRightFork(i) \/ )
    /\ etat[i] = Hungry
    /\ UNCHANGED etat
    /\ UNCHANGED hasRightFork
    /\ (~hasLeftFork[i])
    /\ forkState[forkGauche(i)] = Down
    /\ forkState' = [forkState EXCEPT ![forkGauche(i)] = Up]
    /\ hasLeftFork' = [hasLeftFork EXCEPT ![i] = TRUE]

prendre_fork_d(i) ==
    /\ etat[i] = Hungry
    /\ UNCHANGED etat
    /\ UNCHANGED hasLeftFork
    /\ (~hasRightFork[i])
    /\ forkState[forkDroite(i)] = Down
    /\ forkState' = [forkState EXCEPT ![forkDroite(i)] = Up]
    /\ hasRightFork' = [hasRightFork EXCEPT ![i] = TRUE]

manger(i) ==
    /\ etat[i] = Hungry
    /\ hasLeftFork[i]
    /\ UNCHANGED hasLeftFork
    /\ hasRightFork[i]
    /\ UNCHANGED hasRightFork
    /\ etat' = [ etat EXCEPT ![i] = Eating ]
    /\ UNCHANGED forkState

penser(i) ==
    /\ etat[i] = Eating
    /\ forkState' = [[forkState EXCEPT ![forkGauche(i)] = Down] EXCEPT ![forkDroite(i)] = Down ]
    /\ hasRightFork' = [hasRightFork EXCEPT ![i] = FALSE]
    /\ hasLeftFork' = [hasLeftFork EXCEPT ![i] = FALSE]
    /\ etat' = [ etat EXCEPT ![i] = Thinking ]

Next ==
  \E i \in Philos : \/ demander(i)
                    \/ prendre_fork_g(i)
                    \/ prendre_fork_d(i)
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
