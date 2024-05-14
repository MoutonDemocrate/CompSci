# TD n°5 -- Problèmes sans contraintes

## Exercice I

$f(z,z) = 3z^2+2z^2$, pas de min/max global

On étudie les extrema locaux

**_CN1_** : 
$$
\nabla f(x) = 0 \iff \begin{cases} 2x_1 + 3x_2^2 = 0 \\ 6x_1 x_2 + 2x_2 = 0 \end{cases}
$$

3 points critiques :

$M_1 \begin{pmatrix} 0 \\ 0 \end{pmatrix}, H_1 = \begin{bmatrix} 2 & 0 \\ 0 & 2\end{bmatrix} 
\quad 
M_2 \begin{pmatrix} -\frac{1}{3} \\ \frac{\sqrt{2}}{3} \end{pmatrix}, 
H_2 = \begin{bmatrix} 2 & 2\sqrt{2} \\ 2\sqrt{2} & 0\end{bmatrix} 
\quad 
M_3 \begin{pmatrix} -\frac{1}{3} \\ -\frac{\sqrt{2}}{3} \end{pmatrix}, 
H_3 = \begin{bmatrix} 2 & -2\sqrt{2} \\ -2\sqrt{2} & 0\end{bmatrix}$

$M_1$ est impossible, donc $M_3$ et $M_2$ sont des minimums locaux stricts.

$f$ est $\mathscr{C}^\infty$ car polynomiale, donc

$\nabla^2f(x) = \begin{bmatrix}
2 & 6x_2 \\
6x_2 & 6x_1+2
\end{bmatrix}$, pas de max global, on cherche un min global.

$i\ ain't\ writin\ allat$

## Exercice 2

$(x_1 + x_2)^2 = x_1^2 + x_2^2 + 2x_1x_2 \geqslant 0$ <br>
$(x_1 - x_2)^2 = x_1^2 + x_2^2 - 2x_1x_2 \geqslant 0$

$
\underbrace{f(x) \geqslant x_1^4 + x_2^4 - 2x_1^2 - 2x_2^2 }_{si\ on\ note 
\begin{array}{cc}
z_1 = x_1^2  \\
z_2 = x_1^2
\end{array}
} =  z_1^2 + z_2^2 - 2(z_1 + z_2)$

Forme quadratique en ($z_1$,$z_2$), dont la hessienne est $2I_2 > 0$ ce qui garanti (cf. TD4) sa croissance à l'infini :

> $f$ croit vers l'infini
> 
> $f$ continue
> 
> DONC $f$ admet un minimum global

Cherchons maintenant es min/max locaux...

**_CN1_** : 
$$
\nabla f(x) = 0
\iff
\begin{cases}
4x_1^3 - 2(x_1 + x_2) = 0 \\
4x_2^3 - 2(x_1 + x_2) = 0
\end{cases}
\iff
\begin{cases}
x_1^3 = x_2^3 \iff x_1 = x_2  \\
\ 4x_1^3 - 4x_1 = 0
\end{cases}
$$

On trouve 3 points stationnaires :

$M_1 \dbinom{0}{0},
H_1 = 
\begin{bmatrix}
-2 & -2 \\
-2 & -2
\end{bmatrix}
\quad
M_2 \dbinom{1}{1},
H_2 = 
\begin{bmatrix}
10 & -2 \\
-2 & 10
\end{bmatrix}
M_3 \dbinom{-1}{-1},
H_3 = 
\begin{bmatrix}
10 & -2 \\
-2 & 10
\end{bmatrix}
$

$f(0,0) = 0$ <br>
et $f(\epsilon,-\epsilon) = 2\epsilon^4 > 0$ pour $\epsilon \ne 0$<br>
et donc $M_1 \dbinom{0}{0}$ n'est pas un maximum local.

$M_1$ est impossible, donc $M_2$ et $M_3$ sont des minimums locaux stricts.

Pour les minimums globaux, $f(-1,1) = f(1,1) = -2$<br>
donc les 2 minimums locaux sont aussi des minimums globaux.

## Exercice 3

Le cas de la forme quadratique est particulier, car la hessienne est une constante par rapport à $x$, et alors les CN2 d'optimalité en point $\overline{x}$ donné (qui serait un point critique), induisent des propriétés globales sur $f$.

En effet, $\nabla^2f(x) = 
\begin{bmatrix}
1 & \alpha \\
\alpha & 1
\end{bmatrix}$ est **constante par rapport à $\bold{x}$ !**

Si on veut avoir un minimum local, il faut (CN2) que $\nabla^2f(x) \geqslant 0$, ce qui induit la convexité de $f$ et la CN1 devient une CN2 de minimum global.

Si on veut avoir un maximum local, il faut (CN2) que $\nabla^2f(x) \leqslant 0$, ce qui induit la concavité de $f$ et la CN1 devient une CN2 de maximum global.

Pour finir, si $\nabla^2f(x)$ est inféfinie, soit **si et seulement si $\bold{|\alpha| > 1}$**, la CN2 est invalidée par défautn et il n'y a pas de solutions.

**_CN1_** : 

$$
\begin{Bmatrix}\nabla f(x) = 0 \end{Bmatrix} \iff
\begin{Bmatrix}
\begin{pmatrix}
1 & \alpha \\ 
\alpha & 1
\end{pmatrix}
\begin{pmatrix}
x_1 \\ 
x_2
\end{pmatrix} - 
\begin{pmatrix}
\beta \\ 
1
\end{pmatrix} = 
\begin{pmatrix}
0 \\ 
0
\end{pmatrix}
\end{Bmatrix}
$$

- si $|\alpha| > 1$, la hessienne est inversible, et la CN1 admet une solution unique, et ce $\forall\beta$ <br>
  Minimum global unique : $\overline{x} = \frac{1}{1-\alpha^2} \begin{pmatrix}
  1 & -\alpha \\ 
  -\alpha & 1
  \end{pmatrix}
  \begin{pmatrix}
  \beta \\ 
  1
  \end{pmatrix}$

- si $\alpha = 1$, la CN1 devient $
  \begin{pmatrix}
  1 & 1 \\ 
  1 & 1
  \end{pmatrix}
  \begin{pmatrix}
  x_1 \\ 
  x_2
  \end{pmatrix} = 
  \begin{pmatrix}
  -\beta \\ 
  -1
  \end{pmatrix}$ et je sais pas ce que ça induit car le tableau estoit effacé.

- si $|\alpha| < 1$, tableau effacé, une tragédie.
