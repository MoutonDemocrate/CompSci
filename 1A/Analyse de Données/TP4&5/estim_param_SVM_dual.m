% fonction estim_param_SVM_dual (pour l'exercice 1)

function [X_VS,w,c,code_retour] = estim_param_SVM_dual(X,Y)

    n = size(Y,1) ;
    
    H = diag(Y) * (X * X') * diag(Y) ;

    f = - ones(n,1);

    Aeq = Y';
    beq = 0;

    [alpha, ~, code_retour] = quadprog(H,f,[],[],Aeq, beq, zeros(n,1));

    X_VS = [];
    for i = 1:n
        if alpha(i) > 10e-6
            X_VS = [X_VS ; X(i,:)];
        end
    end

    X_VS

    w = X' * diag(Y) * alpha
        
    %{ On pose k comme l'indice du premier vecteur de support dans les données X %}
    k = find(alpha > 10e-6, 1, "first");

    c = w'*X(k,:)' - Y(k)

end
