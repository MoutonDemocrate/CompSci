# Intégration -- TD1-- Fonction mesurables, mesures et tribus

### Exercice 1

### a)

On a $(f_1 - f_2)(x) = 0$, soit

$$
\begin{split}
    H &= \{ x \in E {\ |\ } f_1(x)-f_2(x) = 0 \}\\
    &= h^{-1} (\{0\}) \text{ avec } h = f_1 - f_2
\end{split}
$$

$f : (E,A) \rightarrow (\R,\mathscr{B}(\R)$

$\forall X \in \mathscr{B}, f^{-1}(x) \in A \iff$ f est mesurable (définition)

or $h$ est mesurable (combinaison linéaire de deux fonctions)

$$
\begin{split}
    \{0\} &= [0,0] \\
    &= (]-\infty, 0[ \cup ]0, +\infty[)^C
\end{split}
$$

donc $\{0\}$ est le complémentaire d'une tribu borélienne, donc appartient à la tribu.

donc $\{0\} \in \mathscr{B}$ ce qui par définition veut dire que $H = h^{-1}(\{0\}) \in A$

### b)

$H_1 = h^{-1}(]-\infty,0[)$ et $H_2 = h^{-1}(]0,+\infty[)$

$]-\infty,0[$ et $]0,+\infty[$ sont des éléments de tribus de Borel (intervalles de $\R$)

### c)

Trivial à déduire des deux autres questions : on passe.

## Exercice 2

- Soit $B \in A_2$,  $\mu_f(B) = \mu(f^{-1}(B)) \underbrace{=}_{f \ mesurable} \mu(B'\in A_1) \in \overline{\R}_+$
  donc $\mu_f$ est bien définie et à valeurs positives.

- $\mu_f(\empty) = \mu(f^{-1}(\empty)) = \mu(\empty) \underbrace{=}_{\mu \ mesure} 0$

- $\mu_f(\bigcup_{n \in \N} B_n) = \sum_{n \in \N} \mu_f (B_n)$
  $\mu_f(\bigcup_{n \in \N} B_n) \underbrace{=}_{B_n\text{ 2 à 2 disjoints}}
  \mu(f^{-1}(\bigcup_{n \in \N} B_n)) \underbrace{=}_{f^{-1}(B_n)\text{ 2 à 2 disjoints}}
   \mu(\bigcup_{n \in \N}f^{-1}( B_n)) =
  \bigcup_{n \in \N} \mu(f^{-1}( B_n))$
  Par $\sigma$-additivité, $\mu_f(\bigcup_{n \in \N} B_n) = \sum_{n \in \N} \mu(f^{-1}(B_n)= \sum_{n \in \N} \mu_f(B_n)$

$\mu_f$ est bien définie, et vérifie $\mu_f(\empty) = 0$ et la $\sigma$-additivité, **c'est donc bien une mesure** !

## Exercice 3

$p$ est une mesure dite "de probabilité", soit $p(\R) = 1$

### 1)

Soit $t_1 < t_2$, $F(t_1) = p(]-\infty,t_1]) \leqslant p(]-\infty,t_2]) = F(t_2)$ car $p \nearrow$

Soit $t \in \R$ et une suite $(t_n)_{n \in \N}$ telle que $t_n \longrightarrow t^+$

$$
\begin{split}
    lim \ F(t_n) &= lim\ p(]-\infty,t_n]) \\
    &= p( lim\ ]-\infty,t_n]) \\
    &= p(]-\infty,t]) \\
    &= F(t)
\end{split}
$$

donc $F$ est continue à droite.

### 2)

$$
\lim\limits_{t \rightarrow -\infty} F(t) = \lim\limits_{t \rightarrow -\infty} p(]-\infin,t]) = p(\empty) = 0
\\
\lim\limits_{t \rightarrow +\infty} F(t) = \lim\limits_{t \rightarrow +\infty} p(]-\infin,t]) = p(\R) = 1
$$

## Exercice 4

### 1)

$$
\lambda \ \sigma \text{-finie} \iff
\exists (E_n) \in (\mathscr{B}(\R))^{n \in \N} \text{ tel quel}
\begin{cases}
    \bigcup_{n\in\N} E_n = \R \\
    \forall n \in \N,\ \lambda (E_n) < +\infin
\end{cases}
$$

On peut prendre $(E_n) = ([n,n+1]\cup[-n-1,-n])_{n\in\N}$, car

- $\bigcup_{n\in\N} En = \R$

- $\forall n \in \N,\ \lambda(E_n) = 2$

Ainsi, **$\lambda$ est $\sigma$-finie.**

### 2)

Soit $K \subset \R$ compact, ce qui veut dire que pour toute suite $(u_n)$ d'éléments de $K$, on peut extraire une sous-suite convergente vers un élément de $K$.

Il existe $n_0 \in \R$ tel que $K \subset [-n_0,n_0]$, or $\lambda([-n_0,n_0]) = 2n_0 < +\infin$

### 3)

On peut trouver un contre-exemple :

$\bigcup_{n\in\N} ]n,n+\frac{1}{n^2}[$
