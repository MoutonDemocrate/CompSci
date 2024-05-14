# Intégration -- TD02 -- Intégrales de fonctions mesurables positives

### BONTINCK Laérian

Attention, la notation $\Bbb{A}_i$ est incorrecte. Je ne l'utilise que pour noter l'habituel $1_i$ que je ne peux pas double-tracer.

## Exercice 1

$$
\forall a > 0, x \in \R : 
f(x) \geqslant
\Bbb{A}_{\{f>a\}}
$$

   Ainsi,

$$
\frac{1}{a} \int_E f d\mu \geqslant
\frac{1}{a} \int_E a\ \Bbb{A}_{\{f>a\}} =
\int_E \Bbb{A}_{\{f>a\}} = \mu (\{f>a\})
$$

## Exercice 2

### 1.

On cherche à montrer que

- $\mu_f$ est définie

- $\mu_f(\empty) = 0$

- pour $(A_i)$ 2-à-2 dénombrables, on a  $\mu_f(\bigcup A_i) = \sum \mu_f(A_i)$ ($\sigma$-additivité)

Premièrement, $\mu_f$ est définie car $f \Bbb{A}_A$ est mesurable $\forall A \in \mathscr{A}$.

Deuxièmement,

$$
\mu_f(\empty) = \int_E f \Bbb{A}_\empty d\mu = 0
$$

Enfin, prenons $(A_i)_{i \in \N}$ 2-à-2 disjoints,

$$
\begin{split}
    \mu_f(\bigcup_{i \in \N}A_i) &= \int_E f \Bbb{A}_{\bigcup_{i \in \N}A_i} d\mu =
    \int_E \sum_{i\in\N} f \Bbb{A}_{A_i} d\mu \\
    &\underbrace{=}_{3.2.5} \sum_{i\in\N} \int_E  f \Bbb{A}_{A_i} d\mu =
    \sum_{i\in\N} \mu_f(A_i)
\end{split}
$$

C'est la définition de la $\sigma$-additivité.

**$\mu$ est donc bien une mesure!**

### 2.

Soit $A = \bigcup_{n\in\N} A_n$

$$
\int_A fd\mu = \int_{\bigcup A_n} fd\mu = 
\int_E f \Bbb{A}_{\bigcup A_n} d\mu =
\sum_{n\in\N} \int_E f \Bbb{A}_{A_n} d\mu =
\sum_{n\in\N} \int_{A_n} f d\mu
$$

## Exercice 3 (cf. exercice 3.1.3)

Soit $g = \sum_{i∈I} α_i \Bbb{A}_{A_i}$ une fonction étagée positive.

$$
\int_\R g d\delta_0 =
\int_\R \sum_{iI} α_i \Bbb{A}_{A_i}\ d\delta_0 =
\sum_{i∈I} α_i \delta_0(A_i) \\


$$

Or,

$$
\delta_0(A_i) = \begin{cases} 1 \text{ si } 0 \in A_i
\\ 0 \text{ sinon} \end{cases} = \Bbb{A}_{A_i}(0) \\
$$

Ainsi,

$$
\int_\R g d\delta_0 =\sum_{i∈I} α_i \Bbb{A}_{A_i}(0) = g(0)
$$

Soit $(f_n)_{n\in\N}$ une suite de fonction étagées positives telles que $f_n \xrightarrow[CVS]{} f \nearrow$,

$$
\int_E f d\delta_0 = \lim_{n\rightarrow+\infty} \int_E f_n d\delta_0
= \lim_{n\rightarrow+\infty} f_n(0) \underbrace{=}_{CVS} f(0)
$$

## Exercice 4

Soit $(A_n)_{n\in\N} \in \mathscr{A}^\infty$ 2-à-2 d'intersection de mesure nulle, soir $A = \bigcup A_n$,

$$
\int_A fd\mu = \int_E f \Bbb{A}_{A} d\mu =
\int_E f \overbrace{\Bbb{A}_{\bigcup A_n}}^{\lim_{n\rightarrow+\infty} f_n} d\mu =
\lim_{n\rightarrow+\infty} \int_E f_n d\mu
$$

or, on a 

$$
\int_E f_n d\mu = \int_E f \Bbb{A}_{\bigcup_{i=0}^{n} A_i} d\mu
= \int_{\bigcup_{i=0}^{n} A_i} f d\mu
$$

On écrit la <u>relation de Chasles</u> (ce qu'on peut faire car $(A_n)_{n\in\N} \in \mathscr{A}^\infty$ 2-à-2 d'intersection de mesure nulle):

$$
\int_E f_n d\mu = \sum_{i=0}^{n} \int_{A_i} f d\mu
$$

On a alors

$$
\begin{split}
\int_A f d\mu &= \lim_{n\rightarrow+\infty}
\sum_{i=0}^{n} \int_{A_i} f d\mu \\
&= \sum_{n=0}^{+\infty} \int_{A_n} f d\mu
\end{split}
$$



## Exercice 5

### 1.

On peut trouver une fonction contre-exemple $f$ telle que $\forall x, f(x)=1<+\infty$

$$
\int_\R fd\mu = 1 \times \mu(\R) = +\infty
$$

Donc $f$ est non-intégrable. **FAUX.**

### 2.

Si $\mu(A) > 0$ avec $A = f^{-1}(\{+\infty\})$

$$
\int_A f d\mu = \int_E f(A)d\mu = +\infty \mu(A) = +\infty
$$

donc

$$
\int_E f d\mu \geqslant \int_A f d\mu = + \infty
$$

donc $f$ est non-intégrable. **VRAI.**


