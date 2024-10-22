# TP4 -- Laplacien anisotropique

## Partie I

### 1.

On a le système :

$$
\begin{cases}
- \gamma_1 \frac{\partial^2 u}{\partial x_1^2} 
- \gamma_2 \frac{\partial^2 u}{\partial x_2^2}
= C(x) \\
u(0,x_2) = u(l_1, x_2) = 0 \\
u(x_1,0) = u(x_1,l_2) = 0
\end{cases}
$$

On approxime le problème à $(N+1)^2$ points :

$\forall(i,j)\in [0 , N_1+1]\times[0,N_2+1]$,

$$
\begin{split}
\frac{\partial^2 u}{\partial x_1^2}(x_{ij})
= \frac{u_{i+1,j} - 2 u_{i,j} + u_{i-1,j}}{h_1^2} \\
\frac{\partial^2 u}{\partial x_2^2}(x_{ij})
= \frac{u_{i,j+1} - 2 u_{i,j} + u_{i,j-1}}{h_2^2}
\end{split}
$$



On écrit le shéma sous forme matricielle :

$$
\text{No, I'm not writing that here.}
$$


