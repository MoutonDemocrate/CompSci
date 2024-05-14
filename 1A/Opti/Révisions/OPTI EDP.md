# Optimisation : équations aux dérivées partielles

## Étapes d'un raisonnement classique

- Modélisation
  
  - mise en équations

- Analyse
  
  - Existence, unicité de la solution

- Discrétisation du problème
  
  - Passage en dimension finie (et étude de la perte d'infortmations)

- Résolution
  
  - Numériquement, analyse du comportement de la solution

Membrane vibrante, file élastique, pot de confiture, diffusion de la chaleur, etc vous avez compris.

Équation d'advection linéaire (en une dimension nonobstant)

## Classification des EDP d'ordre 2

Soit $A(z) \in M_d(\R)$ la matrice des coefficients devant termes d'ordre 2. Considérons les valeurs propres de $A(z)$, l'EDP est dite :

- **Elliptique** si elles sont toutes de même signe et non nulles.
  
  - Ex : $\begin{cases}-\Delta u = f\ \text{dans}\ \Omega \\ \text{+ conditions aux limites} \end{cases}$

- **Hyperbolique** si elles sont $d-1$ non nulles de même signe, et une non nulle de signe opposée.
  
  - Ex : $\begin{cases} \frac{\partial^2u}{\partial t^2} -\Delta u = f\ \text{dans}\ \Omega \times \R^+_* \\ \text{+ conditions aux limites + conditions initiales} \end{cases}$

- **Parabolique** si elles sont $d-1$ non nulles de même signe, et une nulle.
  
  - Ex : $\begin{cases} \frac{\partial u}{\partial t} -\Delta u = f\ \text{dans}\ \Omega \times \R^+_* \\ \text{+ conditions aux limites + conditions initiales} \end{cases}$

**IMPORTANT** : faire un dessin de CM1 pour mieux comprendre le maillage (?) (j'ai pas compris cette partie) (pas intéressant)

**POST-SCRIPTUM** : c'était intéressant en fait. On utilise un maillage pour approximer des trucs, et on en sort des matrices, c'est dur à expliquer mais cf. TD EDP.



## Définition 1.4.5 -- Norme matricielle subordonnée

Soit $|| ||$ une norme sur $\R^N$. On pose

$$
\begin{align}
||||:\ M_N(\R) &\rightarrow \R \\
A &\rightarrow \underbrace{sup}_{x \ne 0} \frac{||Ax||}{||x||}
\end{align}
$$

On appelle cette norme sur $M_n(\R)$ **norme matricielle subordonnée**.

## Définition -- Rayon spectral d'une matrice

On appelle le **rayon spectral $\rho$ d'une matrice $A$** : $\rho = max(\lambda) \quad \forall \lambda \in S_p(A)$



cf. schéma à 5 points du Laplacien
