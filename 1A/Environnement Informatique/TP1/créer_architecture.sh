for bat_n in 1 2 3
do
	mkdir Bat_$bat_n
	for etage_n in 1 2 3
	do 
		mkdir Bat_$bat_n/Etage_$etage_n
		for salle_n in 1 2 3 4 5 6
		do
			mkdir Bat_$bat_n/Etage_$etage_n/Salle_0$salle_n
		done
	done
done

