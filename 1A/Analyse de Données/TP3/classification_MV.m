% fonction classification_MV (pour l'exercice 2)

function Y_pred_MV = classification_MV(X,mu_1,Sigma_1,mu_2,Sigma_2)

    Y_pred_MV = zeros(size(X,1),1);
    s_inv_1 = inv(Sigma_1);
    s_inv_2 = inv(Sigma_2);

    for i = 1:size(X,1)
        xc1 = X(i,:) - mu_1;
        xc2 = X(i,:) - mu_2;
        p1 = 1/(2*pi*sqrt(det(Sigma_1))) * exp(- 0.5 * xc1 * s_inv_1 * xc1' ); %#ok<MINV>
        p2 = 1/(2*pi*sqrt(det(Sigma_2))) * exp(- 0.5 * xc2 * s_inv_2 * xc2' ); %#ok<MINV>
        if p1 > p2
            Y_pred_MV(i) = 1;
        else
            Y_pred_MV(i) = 2;
        end
    end

end
