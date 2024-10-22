% fonction classification_SVM (pour l'exercice 1)

function Y_pred = classification_SVM(X,w,c)

    Y_pred = zeros(size(X,1),1) ;


    for i = 1:size(X,1)
        Y_pred(i) = sign(w'*X(i,:)' - c);
    end

end