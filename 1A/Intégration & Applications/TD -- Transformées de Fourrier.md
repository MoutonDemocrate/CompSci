# Applications -- TD -- Transformées de Fourrier

## Exercice 2

Soit $x(t) = e^{-a t²}$ avec $(a > 0)$

Soit X la solution de l'équation différentielle

$$
\frac{dX}{df}(f) = - 2 \frac {\pi^2} a f X(f)
$$

On pose $X(f) = \hat x(f) = \int_\R e^{-at^2} e^{-2 j \pi f t} dt$

Sachant que si $x \in L'$ alors $t \mapsto t x(t) \in L'$,

$$
\begin{split}
\frac{dX}{df}(f) &= \widehat{(-2 j \pi t) x(t)}(f) \\
&= \int_\R -2j \pi te^{-at^2} e^{-2j \pi tf} dt \\
&= \frac{j\pi}a \int(e^{-at^2})' e^{-2\pi tf} dt \\
... & \text{ et on fait ici une IPP, c'est long à écrire} \\
&= - \frac{2\pi^2}a f \int_\R e^{-at^2} e^{-2 j \pi f t} dt \\
&= - 2 \frac{\pi^2}a f X(f)
\end{split}
$$

On cherche maintenant l'expression de $X$. Posons :

$$
\frac{X'(f)}{X(f)} = - \frac{2 \pi^2}{a}f
$$

On en déduit alors

$$
\begin{split}
\ln X(f) &= - \frac{\pi^2}{a}f^2 + c^{te} \\
X(f) &= K e^{- \frac{\pi^2}a f^2} \text{ avec } K = e^{ c^{te}}
\end{split}
$$

or on a

$$
\begin{split}
X(0) = K = \int_\R e^{-at^2} dt = \sqrt{\frac \pi a}
\end{split}
$$

Ainsi :

$$
X(f) = \sqrt{\frac \pi a} e^{- \frac{\pi^2}a f^2}
$$

## Exercice 4

Supposons $x$ fonction solution de

$$
\frac{d^2 x(t)}{dt^2} - 4 \pi^2 t = 4 \pi x(t)
$$

On a immédiatement les propriétés suivantes :

$$
\begin{cases}
x \in L',\ x \in C^2,\ x',x''\in L^1 \\
tx(t),t^2 x(t) \in L'
\end{cases}
$$

$$
\begin{split}
\widehat{\frac{d^2 x(t)}{dt^2}(f)} &= (2 j \pi f)^2 \hat x(t) \\
&= - 4 \pi^2 f^2 \hat x(t) \\
&= truc\ en\ \KaTeX
\end{split}
$$

Non.

## Exercice 9 - Physics Callback
