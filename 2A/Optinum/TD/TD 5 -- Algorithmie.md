# TD 5 -- Algorithmie

## Exercice 1 - Résolution par pénalisation

### 1.1

$f(x)$ est continue sur un compact, donc il existe une solution à $\mathscr{P}$

### 1.2

1. Si $||x||_2 \geq 2$, alors en sachant que $f(x) \geq \|x\|_2$
   
   $$
   \begin{split}
\|x\|_2^2 - 1 &\geq 3 \\
n(\|x\|_2^2 - 1)^2 &\geq 9n \\
f(x) + n(\|x\|_2^2 - 1)^2 &\geq \|x\|_2^2 + 9n \\
  &\geq 2 + 9n
\end{split}
   $$

2. $\forall n \in \N$
   
   $$
   \|x\|_2 = 1 \implies \Phi_n(x) = f(x) \geq 1
   $$
   
   Or cette contrainte est celle de


