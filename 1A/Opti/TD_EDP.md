# TD : EDP -- Optimisation

## 1.1

On se donne une discrétisation, ici régulière.

$x_0 = 0 \quad\quad x_i = i*h$ pour $i = 0, 1,...\ ,N+1 \quad\quad x_{N+1} = 1 \quad\quad h = \frac{1}{N+1}$ 

et on va noter les inconnues comme $u_i, \ i = 0\ ...\ N+1$ où $u_i \eqsim u(x_i)$

avec $
\begin{cases}
u_0 = \alpha = u(0) \\
u_{N+1} = \beta = u(1)
\end{cases}
$ sont connues.

On notera donc $U_n \in \Re^n$, $U_n = 
\begin{pmatrix}
u_0 \\
\ | \\
u_n
\end{pmatrix}
$
le vecteur des seules inconnues.

$$
u''(x_i) = \frac{u_{i+1} - 2u_i + u_{i-1}}{h^2} = \frac{h^2}{24}(u^{(4)}_{\xi_i^+} + u^{(4)}_{\xi_i^-}) \quad (\mathscr{1})
$$

On remplace dans l'équation au point $x_i$ :

$u''(x_i)$ par $\frac{u_{i+1} - 2u_i + u_{i-1}}{h^2}$ en négligeant les $\mathscr{O}(h^2)$

ce qui donne : pour $i = 1,2,...,N$, $\frac{u_{i+1} - 2u_i + u_{i-1}}{h^2} + o_i u_i = f_i$ en notant $
\begin{array}{cc}
c_i = c(x_i) \\
f_i = f(x_i)
\end{array}$

et on obtient un système linéaire à $N$ inconnues ($u_1,...,u_N$) sous forme matricielle, que l'on peut mettre sous la forme : $A_hU_h=b_h$ avec :

- $U_h \in \Re^N \quad\quad U_h=\begin{pmatrix}
  u_0 \\
  \ | \\
  u_n
  \end{pmatrix}$

- $A_h = 
  \begin{bmatrix}
  (\frac{2}{h^2} + c_1) & - \frac{1}{h^2} & 0 & ... & ... & 0 \\
  -\frac{1}{h^2} & \searrow & \searrow & 0 & ... & 0\\
  0 & \searrow & \searrow & \searrow & 0 & 0 \\
  0 & 0 & \searrow & \searrow & \searrow & 0 \\
  0 & 0 & 0 & \searrow & \searrow & - \frac{1}{h^2} \\
  0 & ... & ... & 0 & - \frac{1}{h^2} & (\frac{2}{h^2} + c_N)
  \end{bmatrix}$

- $b_h = 
  \begin{pmatrix}
  f_1 + \frac{\alpha}{h^2} \\
  f_2 \\
  \ | \\
  f_{N-1}\\
  f_N + \frac{\beta}{h^2} 
  \end{pmatrix}$

$A_h$ a ses éléments diagonaux strictement positifs, donc la diagonale est dominante large.

$$
\frac{2}{h^2} + \underbrace{c_1}_{\geqslant 0} \geqslant |-\frac{1}{h^2}| + |-\frac{1}{h^2}| \quad\quad \forall i
$$

et la dominance est stricte sur au moins une ligne (la 1ère et la dernière).
_--> condition suffisante de définie positivité !_

On pose $\Pi_h(u) = 
\begin{pmatrix}
u(x_1) \\
\ | \\
u(x_n)
\end{pmatrix} \ne U_h$

et on note $\xi_h(u) = A_h \Pi_h(u) - b_h = A_h(\Pi_h)(u) -U_h$ l'erreur de consistance du schéma numérique.

$$
(1) \implies A_h \Pi_h(u) = - 
\begin{pmatrix}
u''(x_1) \\
\ | \\
u''(x_n)
\end{pmatrix}
+
\frac{h^2}{24}
\begin{pmatrix}
u^{(4)}_{\xi_1^+} + u^{(4)}_{\xi_1^-} \\
\ | \\
u^{(4)}_{\xi_N^+} + u^{(4)}_{\xi_N^-}
\end{pmatrix} + 
\begin{pmatrix}
\frac{\alpha}{h^2} \\
0 \\
| \\
0\\
\frac{\beta}{h^2} 
\end{pmatrix}
$$

mais $U(x)$ est solution de $
\begin{cases}
-u''(x) + c(x)u(x) = \underbrace{f(x)}_{x \in ]0,1[} \\
u(0) = \alpha,\ u(1) = \beta
\end{cases}
$

donc $\forall i$, $-u''(x_i) + c(x_i)u(x_i) = f(x_i) = f_i$

$$
A_h \Pi_h(u) = 
\begin{pmatrix}
f_1 \\
| \\
f_N 
\end{pmatrix}
+
\begin{pmatrix}
\frac{\alpha}{h^2} \\
0 \\
| \\
0\\
\frac{\beta}{h^2} 
\end{pmatrix} +
\frac{h^2}{24}\begin{pmatrix}
\end{pmatrix} =
b_h + \xi_h(u)
$$

et $||\xi_h(u)||_\infty \leqslant \frac{2h^2}{24} \underbrace{sup|u^{(4)}_{(y)}|}_{y \in [0,1]}$

L'ordre de consistance du shéma est d'ordre 2.

Pour finir, l'erreur sur la solution est donnée par $(\Pi_h(u) - U_h)$ <br>
mais on a $\xi_h(u) = A_h(\Pi_h(u) - U_h)$ <br>
d'où $\Pi_h(u) - U_h = A_h^{-1} \xi_h(u)$

et en norme $||\Pi_h(u) - U_h||_\infty \leqslant ||A_h^{-1}||_\infty \  ||\xi_h(u)||_\infty \leqslant \frac{h^2}{12*8} \underbrace{sup|u^{(4)}_{(y)}|}_{y\in[0,1]}$