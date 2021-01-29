with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;            use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Unchecked_Deallocation;
with LCA;

package body Google_creuse is

	package LCA_Integer_Integer is
		new LCA (T_Cle => Integer, T_Donnee => Integer);
    use LCA_Integer_Integer;


    
    procedure Initialiser(matrice: out T_matrice) is
	begin
		for i in matrice'Range loop
             P_lca.Initialiser(matrice(i));
        end loop;
	end Initialiser;


    function Est_vide(matrice : in T_matrice) return boolean is
       
        begin
            for i in matrice'Range loop
                if not  P_lca.Est_Vide(matrice(i)) then
                    return False;
                end if;
            end loop;
            return True;
        end Est_vide;






     procedure Lire(matrice: out T_matrice; fichier : in String) is
        f : file_type;
        data : Integer;
        n : Integer;
        len : Integer := 1;
        Sda : LCA_Integer_Integer.T_LCA;
       
    begin
        open(f,in_file,fichier);
            
        Get(f, data);

        Get(f, data);
        n := data;
        Get(f, data);
        Enregistrer (Sda,len,data);

        while not  End_Of_File(f) loop   
                
                
            Get(f, data);
            
                if data = n then
                    len := len +1;
                    Get(f, data);
                    Enregistrer (Sda,len,data);
            
                else 

                    for i in 1..len loop
                       P_lca.Enregistrer(matrice(La_Donnee (Sda , i)+1),n+1  , 1.0/float(len) );
                    end loop;

                    n := data;
                    Get(f, data);
                    len := 1;
                    vider(Sda);
                    Enregistrer (Sda,len,data);
                end if;
                
        end loop;

        for i in 1..len loop
                       P_lca.Enregistrer(matrice(La_Donnee (Sda , i)+1),n+1  , 1.0/float(len) );       
        end loop;


        vider(Sda);


        close(f);
    end Lire;



 procedure Ecrire(vecteur : in T_Vecteur_reel; fichier : in String; alpha : in float;nb_iteration : in integer) is
        f : FILE_TYPE;
        begin
            Create(f, Out_File, fichier);
            Put(f,Capacite,1);
            Put(f," ");
            Put(f,alpha, Fore=>1, Aft=>10);
            Put(f," ");
            Put(f,nb_iteration,1);
            new_line(f,1);
            for i in 1..Capacite loop
                Put(f,vecteur(i), Fore=>1, Aft=>10);
                new_line(f,1);
            end loop;
           
            close(f);
        end Ecrire;

    procedure Ecrire(vecteur : in T_Vecteur_entier; fichier : in String) is
        f : FILE_TYPE;
        begin
            Create(f, Out_File, fichier);

            for i in 1..Capacite loop
                Put(f,vecteur(i),1);
                new_line(f,1);
            end loop;
           
            close(f);
        end Ecrire;

    -- Afficher une cellule de LCA
    procedure Afficher_cellule (S : in Integer; N: in Float) is
	begin
		Put (S,1);
		Put (" : ");
		Put (N, 1);
		Put(" -- " );
	end Afficher_cellule;

	-- Afficher la Sda.
	procedure Afficher_LCA is
		new P_lca.Pour_Chaque (Afficher_cellule);


    procedure afficher (matrice: in T_matrice) is
        begin
        for i in matrice'Range loop
            Afficher_LCA(matrice(i));
            new_line;
        end loop;

    end afficher;

    procedure afficher(vecteur: in T_Vecteur_reel) is
        begin
            for i in 1..Capacite loop
            put(vecteur(i),1);
            new_line;
        end loop;
    end afficher;

function produit(matrice: in T_matrice; X : in T_Vecteur_reel;alpha : in float) return T_Vecteur_reel is
     Y : T_Vecteur_reel;
     beta : float := (1.0 - alpha)/float(Capacite);
    begin
        for i in 1..Capacite loop
            Y(i) :=   0.0;  
            for j in 1..Capacite loop
                if Cle_Presente(matrice(i),j) then 
                    Y(i) := Y(i) + X(j)*(alpha*La_Donnee(matrice(i),j)+beta);
                else
                    Y(i) := Y(i) + X(j)*beta;
                end if;
            end loop;
        end loop;
        
        return Y;
    end produit;

     -- Retourne Vrai si la ligne "indice" dans "matrice" est nulle, Faux sinon
    function Est_nulle(indice : in Integer; matrice: in T_matrice) return boolean is
    begin
      
        for i in 1..Capacite loop
            if Cle_Presente(matrice(i),indice) then 
                return False;
            end if;
        end loop;
        return True;
    end Est_nulle;




    
    procedure to_S(H: in out T_matrice) is
    begin
        for i in 1..Capacite loop
            if Est_nulle(i,H) then
               
               for j in 1..Capacite loop
                    P_lca.Enregistrer(H(j),i  , 1.0/float(Capacite) );
                end loop;
            end if;
        end loop;

    end to_S;
























 procedure Trier(vecteur : in out T_Vecteur_reel ;V_indice : out T_Vecteur_entier) is
        indice_max : integer ;
        valeur_tmp1 : float;
        valeur_tmp2 : integer;
    begin
    for i in 1..Capacite loop
        V_indice(i) := i-1;
    end loop;
        
    for i in 1..(Capacite-1) loop
        indice_max := i;
        for j in i+1..Capacite loop
            if vecteur(j) > vecteur(indice_max) then
                indice_max := j;
            end if;
        end loop;
        valeur_tmp1 := vecteur(i) ;
        valeur_tmp2 := V_indice(i) ;
        vecteur(i) := vecteur(indice_max);
        V_indice(i) := V_indice(indice_max);
        vecteur(indice_max) := valeur_tmp1;
        V_indice(indice_max) := valeur_tmp2;
        
    end loop;



    end Trier;




    procedure Vider(matrice: out T_matrice) is
        begin

            for i in 1..Capacite loop
                P_lca.vider(matrice(i));
            end loop;
        end Vider;


    





end Google_creuse;
