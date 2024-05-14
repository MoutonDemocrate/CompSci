% Fonction ensemble_E_recursif (exercice_1.m)

function [E,contour,G_somme] = ensemble_E_recursif(E,contour,G_somme,i,j,...
                                                   voisins,G_x,G_y,card_max,cos_alpha)
contour(i,j) = 0 ;
for k = 1 : size(voisins, 1)
    pi = i + voisins(k, 1) ;
    pj = j + voisins(k, 2) ;
    if contour(pi, pj)==1
        Gp_ij = [G_x(pi,pj), G_y(pi,pj)] ;
        if Gp_ij/norm(Gp_ij)*G_somme'/norm(G_somme) >= cos_alpha
            E = [E;[pi,pj]] ;
            G_somme = G_somme + Gp_ij ;
            [E,contour,G_somme] = ensemble_E_recursif(E,contour,G_somme,pi,pj,voisins,G_x,G_y,card_max,cos_alpha);
        end
    end
    
end