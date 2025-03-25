# TD 1 - $\text{TLA}^+$

<div align="right">
    Laérian B. - 2SN-L
</div>

## Exercice - Factorielle

### Module $\text{fact1}$

$$
\begin{split}
&\text{MODULE fact0} \\
&\text{EXTENDS Naturals} \\
&\text{CONSTANT } N \\
&\text{ASSUME } N \in Nat \\
&\text{VARIABLE } res \\
&\text{Init } \triangleq \text{ }
    \begin{split}
    &TRUE \\
    \end{split}\\

&\text{Next } \triangleq \text{ }
    \begin{split}
    res' = N! \text{ } ( \text{ ou } \sum^N_{i=1}i ) \\
    \end{split}\\

&\text{Spec } \triangleq \text{ }
    \begin{split}
    &Init\land\square[Next]_{res}
    \end{split}
\end{split}
$$

---

### Module $\text{fact2}$

$$
\begin{split}
&\text{MODULE fact2} \\
&\text{CONSTANT } N \\
&\text{VARIABLE } res,\ i \\
&\text{Init } \triangleq \text{ }
    \begin{split}
        &\land i = 1 \\
        &\land res = 1 \\
    \end{split}\\

&\text{OneMult } \triangleq \text{ }
    \begin{split}
    &\land i \leqslant N \\
    &\land i' = i + 1 \\
    &\land res' = res \times i \\
    \end{split}\\

&\text{TwoMult } \triangleq \text{ }
    \begin{split}
    &\land i \leqslant N - 1 \\
    &\land i' = i + 2 \\
    &\land res' = res \times i \times (i+1) \\
    \end{split}\\

&\text{Next } \triangleq \text{ }
    \begin{split}
    & OneMult \lor TwoMult
    \end{split} \\

&\text{Spec } \triangleq \text{ }
    \begin{split}
    & Init \land \square[Next]_{res,i}
    \end{split}

\end{split}
$$

---

### Module $\text{fact3}$

$$
\begin{split}
&\text{MODULE fact3} \\
&\text{CONSTANT } N \\
&\text{VARIABLE } res,\ x \\ % x est un ensemble d'entiers
&\text{Init } \triangleq \text{ }
    \begin{split}
        &\land res = 1 \\
        &\land x = 1..N \\
    \end{split}\\

% x multiplications par p, si possible
&\text{OneMult(p) } \triangleq \text{ }
    \begin{split}
    &\land p \in x \\
    &\land res' = res \times p \\
    &\land x' = x \ \backslash \ \lbrace p \rbrace \\
    \end{split}\\

&\text{Next } \triangleq \text{ }
    \begin{split}
    & \forall a \in Nat : OneMult(a)
    \end{split} \\

&\text{Spec } \triangleq \text{ }
    \begin{split}
    & Init \land \square[Next]_{res,x}
    \end{split}

\end{split}
$$

#### Représentation graphique pour les cauchemars

```mermaid
flowchart TD
    A1(["x = {1,2,3,4}
    res = 1"]) --- B1 & B2 & B3 & B4

    B1(["x = {2,3,4}
    res = 1"]) ---- C1 & C2 & C3
    B2(["x = {1,3,4}
    res = 2"]) ---- C1 & C4 & C5
    B3(["x = {1,2,4}
    res = 3"]) ---- C2 & C4 & C6
    B4(["x = {1,2,3}
    res = 4"]) ---- C3 & C5 & C6

    C1(["x = {3,4}
    res = 2"]) ---- D3 & D4
    C2(["x = {2,4}
    res = 3"]) ---- D4 & D2
    C3(["x = {2,3}
    res = 4"]) ---- D3 & D2
    C4(["x = {1,2}
    res = 12"]) ---- D1 & D2
    C5(["x = {1,3}
    res = 8"]) ---- D1 & D3
    C6(["x = {1,4}
    res = 6"]) ---- D1 & D4

    D4(["x = {4}
    res = 6"]) --- RES
    D3(["x = {3}
    res = 8"]) --- RES
    D2(["x = {2}
    res = 12"]) --- RES
    D1(["x = {1}
    res = 24"]) --- RES
    RES(["x = {}
    res = 24"])
```

Plus jamais je fais ça

---