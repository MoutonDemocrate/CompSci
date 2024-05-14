% fonction calcul_bon_partitionnement (pour l'exercice 1)

function best_score = calcul_bon_partitionnement(Y_pred,Y)

k_perms = perms(1:max(Y_pred)) ;
best_score = 0 ;

for i = 1:size(k_perms,1)
    for ki = 1:max(Y_pred)
        Y_temp = changem(Y, k_perms(i,ki),ki) ;
    end
    bools = Y_temp == Y_pred ;
    best_score = max(best_score, sum(bools) / size(Y_pred,1) ) ;
end

best_score = best_score * 100 ;

end