*Notes par L.Bontinck, ces notes peuvent être (et sont sûrement) par endroits incorrectes ou erronées.*

# Statistiques -- TD1

## Exercice 1 -- Durée d'attente à un feu rouge

### 1.

$E(T_i) = \frac{\theta}{2}$

$Var(T_i) = \frac{\theta^2}{12}$

### 2.

$\overline{T} = \frac{1}{n} \sum_{i = 1}^{n}{T_i}$, biais ? Variance ?

$\hat{\theta_1} = 2\overline{T}$ est sans biais et convergente selon $\theta$.

$$
E(\overline{T}) = \frac{1}{n} \sum_{i = 1}^{n}{E(T_i)} = \frac{1}{n} \sum_{i = 1}^{n}{\frac{\theta}{2}} = \frac{\theta}{2}
$$

$$
Var(\overline{T}) = Var(\frac{1}{n} \sum_{i = 1}^{n}{T_i})
= \frac{1}{n^2} n Var(T_1) = \frac{\theta^2}{12n} = Var(\overline{T})
$$

$E(\hat{\theta_1}) = 2E(\overline{T}) = \theta$

$Var(\hat{\theta_1}) = 4Var(\overline{T}) = \frac{\theta^2}{3n} \xrightarrow[n \rightarrow \infty]{} 0$

### 3.

On cherche à montrer que le maximum de vraisemblance de $\theta$ est $Y_n = \underset{i}{sup} T_i$

<u>Première méthode :</u>

$$
\begin{split}
 &\mathscr{L}(t_1,...,t_n | \theta) = p(t_1,...,t_n | \theta) \\
 &P(T_1 = t_1 \cup ...\cup T_1 = t_n | |theta) \\
 &= \Pi_{i=1}^{n} P(T_i = t_i | \theta) \\
 &= \Pi_{i=1}^{n} \frac{1}{\theta} \\
 &= \frac{1}{\theta^n}
\end{split}
$$

Mais $\forall i \in [[1,n]]$, $\theta \geqslant i$ donc on prend bien $Y_n = \underset{i}{sup}(T_i)$

<u>Deuxième méthode :</u>

$$
\begin{split}
 P(T_1 < 1) &= \int_{- \infty}^{y} f_{T_1}(t) dt \\
 &= \int_{0}^{y} \frac{1}{\theta} dt \\
 &= \begin{cases}
    \frac{y}{\theta} \text{ si } y \in[0,\theta] \\
    1 \text{ si } y > \theta \\
    0 \text{ si } y < 0
\end{cases}
\end{split}
$$

donc $F_{Y_n}(y) = (\frac{y}{\theta})^n$

$P_{Y_n} (y) = n (\frac{y^n}{\theta^n})^1$

$$
E(Y_n) = \int_{0}^{y} y P_{Y_n}(y)dy
$$

$$
\begin{split}
 E(Y_n) &= \int_{0}^{\theta} n \frac{y^n}{\theta^n} dy \\
 &= \frac{n}{\theta^n} [\frac{y^{n+1}}{n+1}]_{0}^{\theta} \\
 &= \frac{n}{n+1} \theta
\end{split}
\\
\text{Le prof a effacé cette partie avant que je puisse la noter} \\
\text{Mes plus sincères excuses.}
$$

$E(\hat{\theta_2}) = \frac{n+1}{n} E(\frac{1}{n}) = 0$

$Var(\hat{\theta_2}) = (\frac{n+1}{n})^2 Var(Y_n) = \frac{\theta^2}{n(n+2)} \xrightarrow[n \rightarrow \infty]{} 0$

### 4. Quel estimateur choisir ?

$\hat{\theta_2}$ converge en $\frac{1}{n^2}$ et $\hat{\theta}$ converge en $\frac{1}{n}$

donc on choisit $\hat{\theta_2}$, qui sera un meilleur estimateur car il convergera plus vite.

## Exercice 2

### 1.

$U = X^\lambda \implies X = U^{\frac{1}{\lambda}} = g(u)$

C'est une bijection de $\R^+$ sur $\R^+$.

$\Pi(U) = f(g(u), \lambda,\theta) |\frac{dx}{dy}|$

$|\frac{dx}{dy}| = |\frac{1}{\lambda} u^{\frac{1}{\lambda-1}}| = \frac{1}{\lambda} u^{\frac{1-\lambda}{\lambda}}$

donc $\Pi(u) = \frac{\lambda}{\theta} (u^{\frac{1}{\lambda}})^{\text{(inintelligible)}} = \frac{\lambda}{\theta} e^{\frac{u}{\theta}}$

(inintelligible)

$E(u) = E(X^\lambda) = \theta$

$Var(u) = Var(X^\lambda) = \theta^2_1$

### 2.

$(X_1,...,X_n)$ même loi que $X$.

MV $\hat{\theta_n} =\ ?$ Biais ? Convergence ? Efficacité ? Erreur quadratique moyenne ?

$$
\begin{split}
    \mathscr{L}(X_1,...,X_n) &= P(\cap X_i | \theta) \\
    &= \Pi^n_{i=1} P(X_i | \theta) \\
    &= \Pi^n_{i=1} \frac{\lambda}{\theta} X_i^{\lambda-1} e^{- \frac{X_i^\lambda}{\theta}}\\
    &= \text{effacé, mes excuses, mais c'était trop long de toute façon} \\
    &= \frac{n}{\theta} \text{quelque chose}
\end{split}
$$

$E(\hat{\theta_n}) = \frac{1}{n} E(U) = \theta$

$Var(\hat{\theta_n}) = \frac{1}{\theta^2} n Var(U) = \frac{\theta^2}{n}$
