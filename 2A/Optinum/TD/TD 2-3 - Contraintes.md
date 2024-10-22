# TD 2-3 - Contraintes

## Exercice 5

$$
\begin{cases}
    \min f(x)=\frac{1}{2}||x-a||^2 \\
    x \in \R^n \\
    \sum^n_{i=1} x_i = 1 \\
    x \geq 0
\end{cases}
$$

avec $a = (1,...,1)$

On cherche dans un premier temps à prouver l'existence, puis l'unicité des solutions.

Le domaine des réponses $\mathscr{C}$ est fermé et borné dans $\R^n$

- effectivement, $0 \leq x_i \leq 1$, $\forall i$

$\mathscr{C} \ne \empty$ est compact dans $\R^n$, et $f$ est continue ($C^\infin$) sur $\mathscr{C}$ et donc admet un minimum global (et un maximum global aussi)

Pour l'unicité, le domaine $\mathscr{C}$ $\bigcap$ du 1er quadrant positif et d'un hyperplan ??? est convexe dans $\R^n$

et $\forall x \in \mathscr{C}$, $\nabla^2 f(x) = I_n$ (def. pos), d'où $f$ strictement convexe sur le convexe $\mathscr{C}$ et ainsi le minimum global est unique.

Toutes les contraintes sont affines, donc HQC automatiquement validé.

> 


