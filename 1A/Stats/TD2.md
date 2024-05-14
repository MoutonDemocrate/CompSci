# Statistiques -- TD2

## Exercice 1

### 1.

La densité de $(T_1,...T_n)$ est

$$
f(t_1,...t_n ; \theta) = \theta^n exp(-\theta \sum^n_{k=1}t_k)
$$

On cherche à maximiser la vraisemblance donc maximiser le logarithme de cette vraisemblance

$$
ln\ f(t_1,...t_n ; \theta) = n\ ln(\theta) - \theta \sum^n_{k=1}t_k
$$

$$
\begin{split}
\frac{\partial \  ln\ L}{\partial \ \theta} &= \frac{n}{\theta}
- \sum^n_{k=1}t_k \\
\text{or on a donc  } \frac{\partial \  ln\ L}{\partial \ \theta} &= 0 \iff \boxed{\hat{\theta}_{MV} = {n \over \sum^n_{i=1}T_i}}
\end{split}
$$

$$
a_{a_{a_a}} a \raisebox{0.25em}{$a$} a \raisebox{-0.25em}{$a$} a
$$


