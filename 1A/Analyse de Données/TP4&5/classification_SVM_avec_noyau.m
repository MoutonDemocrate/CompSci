% fonction classification_SVM_avec_noyau (pour l'exercice 2)

function Y_pred = classification_SVM_avec_noyau(X,sigma,X_VS,Y_VS,Alpha_VS,c)

    Y_pred = zeros(size(X,1),1) ;


    for i = 1:size(X,1)
        for j = 1:n
            Y_pred(i) = sign(alpha(j)*Y(j)*G(j,i) - c);
        end
    end

end