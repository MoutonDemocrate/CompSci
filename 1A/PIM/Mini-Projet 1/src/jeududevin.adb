with Ada.Text_IO ; use Ada.Text_IO ;
with Ada.Integer_Text_IO ; use Ada.Integer_Text_IO ;


procedure JeuDuDevin is
    ordinateurCherche : Boolean := True ;
    utilisateurTriche : Boolean := False ;
    guess : Integer ;
    nbrPossibleHaut : Integer ;
    nbrPossibleBas : Integer ;
    choix : String := "" ;
    choixValide : Boolean ;
    nbrEssai : Integer ;
begin
    --Demander un nombre entre 1 et 999 à l'utilisateur
    choix := "" ;
    while not (choix = "o") loop
        Put("Avez-vous choisi un nombre entre 1 et 999 ? (o/n)") ;
        Get(choix) ;
    end loop;

    nbrPossibleHaut := 999 ;
    nbrPossibleBas := 1 ;
    nbrEssai := 0 ;
    while ordinateurCherche and not utilisateurTriche loop
        -- Ordinateur joue
        nbrEssai := nbrEssai + 1 ;
        guess := (nbrPossibleHaut-nbrPossibleBas)/2 + nbrPossibleBas ;
        Put("Proposition " & Integer'Image(nbrEssai) & " , votre nombre est-il : " & Integer'Image(guess)) ;

        -- Utilisateur répond
        choixValide := False ;
        choix := "" ;
        while choixValide = False loop
            Put("Trop (g)rand, trop (p)etit ou (t)rouvé ?") ;
            Get(choix) ;
            choixValide := True ;
            if choix = "g" then
                nbrPossibleHaut := guess -1 ;
            elsif choix = "p" then
                nbrPossibleBas := guess + 1 ;
            elsif choix = "t" then
                ordinateurCherche := False ;
            else
                Put("Je n'ai pas compris. Merci de réponse :");
                Put("    g si le nombre est trop grand");
                Put("    p si le nombre est trop petit");
                Put("    t si le nombre est correct");
                choixValide := False ;
            end if ;
        end loop ;

        -- Vérifier s'il y a victoire ou triche
        if nbrPossibleBas > nbrPossibleHaut then
            utilisateurTriche := True ;
        end if ;
    end loop ;

    -- afficher les résultats
    if utilisateurTriche then
        Put("Vous trichez. J'arrête de jouer.") ;
    else
        Put("J'ai trouvé " & Integer'Image(guess) & " en " & Integer'Image(nbrEssai) & " essai.") ;
    end if ;

end JeuDuDevin ;
