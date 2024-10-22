% fonction estim_param_vraisemblance (pour l'exercice 1)

function [mu,Sigma] = estim_param_vraisemblance(X)

    mu = mean(X);
    Xc = X - repmat(mu,size(X,1),1); 
    Sigma = Xc' * Xc / size(X,1);
end