% fonction estim_param_MC_paire (pour exercice_2.m)

function alpha = estim_param_MC_paire(d,x,y_inf,y_sup)

    alpha = [] ;
    p = length(x) ;
    A_part = zeros(p,d) ;
    B_inf = y_inf - y_inf(1) * vecteur_bernstein(x,d,0) ;
    B_sup = y_sup - y_sup(1) * vecteur_bernstein(x,d,0) ;

    B = [B_inf ; B_sup] ;

    for i = 1:d

        A_part(:,i) = vecteur_bernstein(x, d, i) ;

    end

    A = [[A_part(:,1:(end-1)) , zeros(p,d-1) , A_part(:,end)] ; [zeros(p,d-1) , A_part]] ;

    alpha = A\B ;

end
