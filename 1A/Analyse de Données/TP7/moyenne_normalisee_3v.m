% fonction moyenne_normalisee_3v (pour l'exercice 1bis)

function x = moyenne_normalisee_3v(I)

    % Cropping de I
    I_c = I(size(I,1)*(1/3):size(I,1)*(2/3) , size(I,2)*(1/3):size(I,2)*(2/3) , :) ;

    % Conversion en flottants :
    I_c = single(I_c);
    
    % Calcul des couleurs normalisees :
    somme_canaux = max(1,sum(I_c,3));
    r = I_c(:,:,1)./somme_canaux;
    v = I_c(:,:,2)./somme_canaux;
    b = I_c(:,:,3)./somme_canaux;

    % Calcul des couleurs moyennes :
    r_barre = mean(r(:));
    v_barre = mean(v(:));
    b_barre = mean(b(:));
    x = [r_barre v_barre b_barre];


end
