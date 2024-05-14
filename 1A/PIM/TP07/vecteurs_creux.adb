with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Unchecked_Deallocation;

package body Vecteurs_Creux is


	procedure Free is
		new Ada.Unchecked_Deallocation (T_Cellule, T_Vecteur_Creux);


	procedure Initialiser (V : out T_Vecteur_Creux) is
	begin
		V := Null ;
	end Initialiser;


	procedure Detruire (V: in out T_Vecteur_Creux) is
	begin
		Free (V) ;
	end Detruire;


	function Est_Nul (V : in T_Vecteur_Creux) return Boolean is
	begin
		if V.All.Valeur /= 0.0 then
			return False ;
		elsif V.All.Suivant /= Null then
			return Est_Nul(V.All.Suivant) ;
		else
			return True ;
		end if;
	end Est_Nul;


	function Composante_Recursif (V : in T_Vecteur_Creux ; Indice : in Integer) return Float is
	begin
		if V.All.Indice = Indice then
			return V.All.Valeur ;
		elsif V.All.Suivant /= Null then
			return Composante_Recursif(V.All.Suivant, Indice) ;
		else
			return 0.0 ;
		end if;
	end Composante_Recursif;


	function Composante_Iteratif (V : in T_Vecteur_Creux ; Indice : in Integer) return Float is
		CurrV : T_Vecteur_Creux := V ;
	begin
		while (CurrV /= Null) loop
			if CurrV.All.Indice = Indice then
				return CurrV.All.Valeur ;
			else
				Currv := CurrV.All.Suivant ;
			end if;
		end loop;
		return 0.0;
	end Composante_Iteratif;


	procedure Modifier (V : in out T_Vecteur_Creux ;
				       Indice : in Integer ;
					   Valeur : in Float ) is
		NewV : T_Vecteur_Creux := Null ;
	begin
		if V.All.Indice = Indice then
			V.All.Valeur := Valeur ;
		elsif V.All.Indice > Indice then
			NewV.All.Indice := Indice ;
			NewV.All.Valeur := Valeur ;
			NewV.All.Suivant := V ;
			V := NewV ;
		elsif V.All.Suivant = Null then
			NewV.All.Indice := Indice ;
			NewV.All.Valeur := Valeur ;
			V.All.Suivant := NewV ;
		else
			Modifier(V.All.Suivant, Indice, Valeur) ;
		end if;
	end Modifier;


	function Sont_Egaux_Recursif (V1, V2 : in T_Vecteur_Creux) return Boolean is
	begin
		if V1 = V2 then
			return True ;
		elsif V1 = Null or V2 = Null then
			return False ;
		else
			if (V1.All.Indice = V2.All.Indice) and (V1.All.Valeur = V2.All.Valeur) and Sont_Egaux_Recursif(V1.All.Suivant, V2.All.Suivant) then
				return True ;
			end if;
		end if;
		return False ;
	end Sont_Egaux_Recursif;


	function Sont_Egaux_Iteratif (V1, V2 : in T_Vecteur_Creux) return Boolean is
		CurrInd : Integer := 1 ;
		CV1 : T_Vecteur_Creux := V1 ;
		CV2 : T_Vecteur_Creux := V2 ;
	begin
		while not (CV1 = Null and CV2 = Null) loop
			if V1 = V2 then
				return True ;
			elsif V1 = Null or V2 = Null then
				return False ;
			else
				CV1 := CV1.All.Suivant ;
				CV2 := CV2.All.Suivant ;
			end if;
		end loop;
		return True;
	end Sont_Egaux_Iteratif;


	procedure Additionner (V1 : in out T_Vecteur_Creux; V2 : in T_Vecteur_Creux) is
	begin
		if V1.All.Indice = V2.All.Indice then
			V1.All.Valeur := V1.All.Valeur + V2.All.Valeur ;
			Additionner (V1.All.Suivant, V2.All.Suivant) ;
		elsif V1.All.Indice < V2.All.Indice then
			Additionner (V1.All.Suivant, V2) ;
		else
			Modifier (V1, V2.All.Indice, V2.All.Valeur) ;
			Additionner (V1, V2.All.Suivant) ;
		end if;
	end Additionner;


	function Norme2 (V : in T_Vecteur_Creux) return Float is
		sum : Float := 0.0 ;
		CV : T_Vecteur_Creux := V ;
	begin
		while (CV /= Null) loop
			sum := sum + CV.All.Valeur*CV.All.Valeur ;
			CV := CV.All.Suivant ;
		end loop ;
		return Sqrt(sum) ;
	end Norme2;


	Function Produit_Scalaire (V1, V2: in T_Vecteur_Creux) return Float is
	begin
		-- NON.
	end Produit_Scalaire;


	procedure Afficher (V : T_Vecteur_Creux) is
	begin
		if V = Null then
			Put ("--E");
		else
			-- Afficher la composante V.all
			Put ("-->[ ");
			Put (V.all.Indice, 0);
			Put (" | ");
			Put (V.all.Valeur, Fore => 0, Aft => 1, Exp => 0);
			Put (" ]");

			-- Afficher les autres composantes
			Afficher (V.all.Suivant);
		end if;
	end Afficher;


	function Nombre_Composantes_Non_Nulles (V: in T_Vecteur_Creux) return Integer is
	begin
		if V = Null then
			return 0;
		else
			return 1 + Nombre_Composantes_Non_Nulles (V.all.Suivant);
		end if;
	end Nombre_Composantes_Non_Nulles;


end Vecteurs_Creux;
