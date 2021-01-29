
with lca;
generic 
	Capacite : Integer;
	
	
    

	

package Google_creuse is
	
	type T_Vecteur_entier is array(1..Capacite) of Integer;
	type T_Vecteur_reel is array(1..Capacite) of float;



	package P_lca is    
        new lca (T_Cle=>integer,T_Donnee=>float);
    use P_lca;

	type T_matrice is array(1..Capacite) of T_LCA;


	


	

-- Initialiser une matrice 
--
-- Parametres :
-- 	  Matrice: out T_matrice	-- la matrice utilisée pour l'initialisation

-- NÃ©cessite :
--    Vrai

-- Assure : 
--    Est_vide(Matrice)

procedure Initialiser(matrice: out T_matrice ) with
	post => Est_vide(matrice);
	



-- Vérifier si une matrice est nulle 
--
-- Parametres :
-- 	  Matrice: in T_matrice	 

-- NÃ©cessite :
--    Vrai

-- Assure : 
--   Vrai si la matrice est nulle, faux sinon;

function Est_vide(matrice : in T_matrice) return boolean;


-- Lire un graph qui represente un réseau et le transformer en un tableau de hachage
--
-- Parametres :
--		Matrice: out T_matrice		-- le tableau qui va representer le graph
--		fichier : in String 		-- le fichier qui contient le graph  

-- NÃ©cessite :
--    par contrat le fichier de graph contient le nombre de pages dans la première ligne 
		--et le graph après. 

-- Assure : 
--   Matrice équivalent au graph.
procedure Lire(matrice: out T_matrice; fichier : in String) ;

-- Ecrire un vecteur réel dans un fichier
--
-- Parametres :
--		vecteur : in T_Vecteur_reel		-- le vecteur qu'on va mettre dans le fichier
--		fichier : in String 		-- le nom du fichier 
--		alpha :in float 		-- la valeur de alpha  
--		nb_iteration : in integer 		-- le nombre d'iteration 

-- NÃ©cessite :
--    Vrai 

-- Assure : 
--   dans la première ligne on écrit " capacité - alpha - nb_iteration "
-- et le vecteur dans les autres.
-- vecteur dans le fichier équivalent au vecteur donné
procedure Ecrire(vecteur : in T_Vecteur_reel; fichier : in String;alpha :in float;nb_iteration : in integer);


-- Ecrire un vecteur des entiers dans un fichier
--
-- Parametres :
--		vecteur : in T_Vecteur_entier		-- le vecteur qu'on va mettre dans le fichier
--		fichier : in String 		-- le nom du fichier 


-- NÃ©cessite :
--    Vrai 

-- Assure : 
-- vecteur dans le fichier équivalent au vecteur donné
procedure Ecrire(vecteur : in T_Vecteur_entier; fichier : in String);



-- Procédure pour afficher la matrice "matrice" pour vérifier
--
-- Parametres :
--		matrice: in T_matrice		-- une matrice



-- NÃ©cessite :
--    Vrai 

-- Assure : 
-- 	  Vrai
procedure afficher (matrice: in T_matrice);


-- Procédure pour afficher le vecteur poids pour vérifier
--
-- Parametres :
--		vecteur: in T_Vecteur_reel		-- le vecteur poids



-- NÃ©cessite :
--    Vrai 

-- Assure : 
-- 	  Vrai
procedure afficher(vecteur: in T_Vecteur_reel);


-- Effectuer un produit entre un vecteur et une matrice de type matrice_google
--
-- Parametres :
--		matrice: in T_matrice		-- la matrice S
--		 X : in T_Vecteur_reel 		-- le vecteur X
--		alpha : in float 			-- la valeur de alpha


-- NÃ©cessite :
--    Vrai 

-- Assure : 
-- 	  Vrai


function produit(matrice: in T_matrice; X : in T_Vecteur_reel;alpha : in float) return T_Vecteur_reel;


-- Transformer une matrice de type H à une matrice de Type S
--
-- Parametres :
--		H: in out T_matrice		-- la matrice H



-- NÃ©cessite :
--    Vrai 

-- Assure : 
-- 	  Vrai
procedure to_S(H: in out T_matrice);




-- Trier un vecteur des réels on donnant les indices triés aussi
--
-- Parametres :
--		vecteur : in out T_Vecteur_reel		-- la matrice H
--		V_indice : out T_Vecteur_entier      -- le vecteur des indices triés


-- NÃ©cessite :
--    Vrai 

-- Assure : 
-- 	  V_indice trié
procedure Trier(vecteur : in out T_Vecteur_reel ;V_indice : out T_Vecteur_entier);




-- Vider la matrice de type T_matrice
--
-- Parametres :
--		matrice: out T_matrice		-- la matrice 



-- NÃ©cessite :
--    Vrai 

-- Assure : 
-- 	  matrice vide
procedure Vider(matrice: out T_matrice) ;



	
    
   
    
    
	

end Google_creuse;
