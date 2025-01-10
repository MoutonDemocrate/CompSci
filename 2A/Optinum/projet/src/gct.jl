using LinearAlgebra
"""
Approximation de la solution du problème 

    min qₖ(s) = s'gₖ + 1/2 s' Hₖ s, sous la contrainte ‖s‖ ≤ Δₖ

# Syntaxe

    s = gct(g, H, Δ; kwargs...)

# Entrées

    - g : (Vector{<:Real}) le vecteur gₖ
    - H : (Matrix{<:Real}) la matrice Hₖ
    - Δ : (Real) le scalaire Δₖ
    - kwargs  : les options sous formes d'arguments "keywords", c'est-à-dire des arguments nommés
        • max_iter : le nombre maximal d'iterations (optionnel, par défaut 100)
        • tol_abs  : la tolérence absolue (optionnel, par défaut 1e-10)
        • tol_rel  : la tolérence relative (optionnel, par défaut 1e-8)

# Sorties

    - s : (Vector{<:Real}) une approximation de la solution du problème

# Exemple d'appel

    g = [0; 0]
    H = [7 0 ; 0 2]
    Δ = 1
    s = gct(g, H, Δ)

"""
# ALGORITHM 3
function gct(g::Vector{<:Real}, H::Matrix{<:Real}, Δ::Real; # LIGNE 1
    max_iter::Integer = 100, 
    tol_abs::Real = 1e-10, 
    tol_rel::Real = 1e-8)

    n = length(g)

    j = 0 # LIGNE 2
    g0 = g # LIGNE 3
    s = zeros(length(g)) # LIGNE 4
    p = -g # LIGNE 5

    function solve(sj, pj)
        a = transpose(pj) * pj
        b = 2*transpose(sj) * pj
        c = transpose(sj) * sj - Δ^2
        sigma1 = (-b + sqrt(b^2 - 4*a*c)) / (2*a)
        sigma2 = (-b - sqrt(b^2 - 4*a*c)) / (2*a)

        return sigma1, sigma2
    end

    function q(s)
        return transpose(g) * s + 0.5 * transpose(s) * H * s
    end

    while j < 2*n && norm(g) > max(norm(g0)*tol_rel, tol_abs)  # LIGNE 6

        k = transpose(p) * H * p # LIGNE 7

        if k <= 0 # LIGNE 8

            sigma1, sigma2 = solve(s, p)  # LIGNE 9

            if q(s + sigma1 * p) < q(s + sigma2 * p)
                sigma = sigma1
            else
                sigma = sigma2
            end

            return s + sigma * p # LIGNE 10

        end # LIGNE 11

        alpha = transpose(g) * g / k # LIGNE 11

        if norm(s + alpha * p) >= Δ # LIGNE 12
            sigma1, sigma2 = solve(s, p) # LIGNE 13
            sigma = max(sigma1, sigma2)
            return s + sigma * p # LIGNE 14
        end # LIGNE 15

        s = s + alpha * p # LIGNE 16
        g_prev = g
        g = g + alpha * H * p # LIGNE 17
        beta = (transpose(g) * g) / (transpose(g_prev) * g_prev) # LIGNE 18
        p = -g + beta * p # LIGNE 19
        j += 1 # LIGNE 20

    end # LIGNE 21

    return s # LIGNE 22
end
