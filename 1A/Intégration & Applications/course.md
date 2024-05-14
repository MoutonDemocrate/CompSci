Bontinck L., written on Marker using $\KaTeX$, `mermaid`, *Charter*.

# Chapitre 1, Généralités

Intégrale de Lebesgue : $\int_{E,F} f\ d\mu$<br>
$\quad \quad \rightarrow$ généralise l'intégrale de Riemann

# Chapitre 2, Théorie de la mesure

TL;DR on parle de tribus et c'est pas particulièrement intéressant, 113/5 PT babyyyyy oooh yea 

### Proposition 2.1.9

> Si $A_2$ est une tribu sur $E_2$, alors
> $$f^{-1}(A_2) = 
> \{f^{-1}(B) \subset E_1 | B \in A_2\}$$
> 
> est une tribue sur $E_1$, appelée **tribu image réciproque** de $A_2$ par $f$.

$f : E_1 \rightarrow E_2$

Soit $B \subset E_2$<br>
$A = f^{-1}(B) = \{
x \in E_1
|
f(x) \in B\}$<br>
$E_1 \in f^{-1}(A_2)\ ?$

$A \subset E_1,\ f(A) \subset B$

soit $\exists B \in A_2$ tel que $E_1 = f^{-1}(B)$<br>
 soit $\exists B \in A_2$ tel que $f^1(E_1) \subset B$

 $f(E_1) \subset E_2,\ E_2 \in A_2$

 donc $E_1 \in f^{-1}(E_2)$, et comme $E_2 \in A_2$, 

$$
\boxed{E_1 \in f^{-1}(A_2)}
$$

Soit $\delta_0$ la mesure de Dirac en 0 définie sur $\mathscr{B}(\R)$ par

$$
\begin{split}
    \delta_0 : \mathscr{B}(\R) &\longrightarrow \overline{\R}_+ \\
    A &\longrightarrow \delta_0(A) = \begin{cases}
        1 \text{ si } 0 \in A \\
        0 \text{ sinon}
    \end{cases}
\end{split}
$$

On commence **toujours** par écrire

- $f = \sum \alpha_i \Bbb{I}A_i$

- $\int_E f d\mu = \sum \alpha_i \mu (A_i)$
