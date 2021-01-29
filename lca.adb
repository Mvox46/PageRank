with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body LCA is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LCA);



	procedure Initialiser(Sda: out T_LCA) is
	begin
		Sda := null;	-- Initialiser Sda
	end Initialiser;



	function Est_Vide (Sda : T_LCA) return Boolean is
	begin
		return Sda = null;	-- True si Sda = null et False si Sda /= null
	end;


	-- Calculer la taille d'une maniere recursive 
	function Taille (Sda : in T_LCA) return Integer is
	begin
		if Est_Vide(Sda) then
			return 0;  -- si Sda est vide alors on retourne 0
		else
			return 1 + Taille(Sda.all.Next); --sinon on retourne 1 + la taille Sda.all.Suivant 
		end if;
	end Taille;




	procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Donnee : in T_Donnee) is
		Sda_2 : T_LCA;
	begin
		if Est_Vide(Sda) then 
			-- Deux cas :
				-- Sda est vide
				-- Si on utlise la recursivite et on arrive a la fin de la liste chainee 
			Sda_2 := new T_Cellule;
			Sda_2.all.Cle := Cle;
			Sda_2.all.Donnee := Donnee;
			Sda_2.all.Next := Sda;
			Sda := Sda_2;
			
		elsif Sda.all.Cle = Cle then
			Sda.all.Donnee := Donnee;
		else
			Enregistrer(Sda.all.Next,Cle,Donnee);		
		end if;		
	end Enregistrer;





	function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
	begin
		if Est_Vide(Sda) then
			return False;	
		elsif Sda.all.Cle = Cle then
			return True;
		else
			return Cle_Presente(Sda.all.Next,Cle);
		end if;
	end Cle_Presente;


	

	function La_Donnee (Sda : in T_LCA ; Cle : in T_Cle) return T_Donnee is
	begin
		
		if Est_Vide(Sda) then
			-- Deux cas :
				-- Sda est vide
				-- Si on utlise la recursivite et on arrive a la fin de la liste chainee
			raise Cle_Absente_Exception;
		elsif Sda.all.Cle = Cle then
			return Sda.all.Donnee;
		else
			return La_Donnee(Sda.all.Next,Cle);
		end if;
	end La_Donnee;


	procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
	Cellule_temporaire : T_LCA; -- Pour stocker le pointeur de la cellule a supprimer car il faut faire une dellocation de la memoire apres.
	begin
		
		if Est_Vide(Sda) then
			-- Deux cas :
				-- Sda est vide
				-- Si on utlise la recursivite et on arrive a la fin de la liste chainee
			raise Cle_Absente_Exception;
		elsif Sda.all.Cle = Cle then
			Cellule_temporaire := Sda;	
			Sda := Sda.all.Next;
			Free(Cellule_temporaire);
		else	
			Supprimer(Sda.all.Next,Cle);
		end if;
	end Supprimer;


	procedure Vider (Sda : in out T_LCA) is
	begin
		if Est_Vide(Sda) then
			null;
		else
			Vider(Sda.all.Next);
			Free(Sda);
		end if;	
	end Vider;


	procedure Pour_Chaque (Sda : in T_LCA) is
	begin	
		if Est_Vide(Sda) then
			null;
		else
			begin
				Traiter(Sda.all.Cle,Sda.all.Donnee);
			exception 
				when others => pragma Assert (False);
			end;

			Pour_Chaque(Sda.all.Next);
		end if;
	end Pour_Chaque;


end LCA;
