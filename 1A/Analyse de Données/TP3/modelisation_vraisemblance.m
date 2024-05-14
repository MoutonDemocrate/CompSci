% fonction modelisation_vraisemblance (pour l'exercice 1)

function modele_V = modelisation_vraisemblance(X,mu,Sigma)

    modele_V_temp = zeros(size(X,1),1);
    sigma_inv = inv(Sigma);

    for i = 1:size(X,1)
        xc = X(i,:) - mu;
        p = exp(- 0.5 * xc * sigma_inv * xc' ); %#ok<MINV>
        modele_V_temp(i) = p;
    end

    modele_V = 1/(2*pi*sqrt(det(Sigma))) * modele_V_temp;

end