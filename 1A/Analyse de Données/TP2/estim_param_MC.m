% fonction estim_param_MC (pour exercice_1.m)

function beta = estim_param_MC(d,x,y)

    beta = [] ;
    A = zeros(length(x),d) ;
    B = y - y(1) * vecteur_bernstein(x,d,0) ;

    for i = 1:d
        A(:,i) = vecteur_bernstein(x, d, i) ; 
    end
    
    beta = A\B;

end
