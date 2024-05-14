% fonction estim_param_SVM_noyau (pour l'exercice 2)

function [X_VS,Y_VS,Alpha_VS,c,code_retour] = estim_param_SVM_noyau(X,Y,sigma)
    
    n = size(Y,1) ;
    
    G = zeros(n,n) ;

    for i = 1:n
        for j = 1:n
            G(i,j) = exp( - sum((X(i,:) - X(j,:)).^2) / 2*sigma^2 ) ;
        end
    end

    H = diag(Y) * G * diag(Y) ;

    f = - ones(n,1);

    Aeq = Y';
    beq = 0;

    [alpha, ~, code_retour] = quadprog(H,f,[],[],Aeq, beq, zeros(n,1));
    
    ind = find(alpha>10e-6, 1) ;
    X_VS = X(ind);
    Y_VS = Y(ind);
    Alpha_VS = alpha(ind);
        
    c = 0 ;
    for i = 1:n
        for j = 1:n
            c = c + alpha(j)*Y(j)*G(j,i) - Y(i) ;
        end
    end

    
end
