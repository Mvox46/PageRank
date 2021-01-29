with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;            use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Unchecked_Deallocation;
with LCA;

package body Google_naive is

	package LCA_Integer_Integer is
		new LCA (T_Cle => Integer, T_Donnee => Integer);
    use LCA_Integer_Integer;


    
    procedure Initialiser(matrice: out T_Google) is
	begin
		matrice := (1..Capacite=>(1..Capacite=> 0.0));
	end Initialiser;




   function Est_vide (matrice : in T_Google) return boolean
    is
       begin
        return matrice = (1..Capacite=>(1..Capacite=> 0.0));
    end Est_vide;











    procedure Lire(matrice: out T_Google; fichier : in String) is
        f : file_type;
        data : Integer;
        n : Integer;
        len : Integer := 1;
        Sda : T_LCA;
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
                       
                        matrice(n+1)(La_Donnee (Sda , i)+1) := 1.0/float(len);
                    end loop;
                    n := data;
                    Get(f, data);
                    len := 1;
                    vider(Sda);
                    Enregistrer (Sda,len,data);
                end if;
                
        end loop;

        for i in 1..len loop
                matrice(n+1)(La_Donnee (Sda , i)+1) := 1.0/float(len);
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


    procedure afficher (matrice: in T_Google) is
        begin
            for i in 1..Capacite loop
                for j in 1..Capacite loop
                    put(matrice(i)(j),1);
                    put(" ");
                end loop;
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


    function produit(matrice: in T_Google; X : in T_Vecteur_reel) return T_Vecteur_reel is
     Y : T_Vecteur_reel;
    begin
        for i in 1..Capacite loop
            Y(i) :=   0.0;  
            for j in 1..Capacite loop
                Y(i) := Y(i)+ X(j)*matrice(j)(i);
            end loop;
        end loop;
        return Y;
    end produit;


    -- Retourne Vrai si la ligne "indice" dans "matrice" est nulle, Faux sinon
    function Est_nulle(indice : in Integer; matrice: in T_Google) return boolean is
    begin
        return matrice(indice)(1..Capacite) = (1..Capacite=>0.0);
    end Est_nulle;


    procedure to_S(H: in out T_Google) is
    begin
        for i in 1..Capacite loop
            if Est_nulle(i,H) then
                H(i)(1..Capacite) := (1..Capacite=>1.0/float(Capacite));
            end if;
        end loop;

    end to_S;


    procedure to_G(S: in out T_Google; alpha : in float) is
    beta : float := (1.0 - alpha)/float(Capacite);
    begin
        for i in 1..Capacite loop
            for j in 1..Capacite loop
                S(i)(j) := alpha*S(i)(j) + beta;
            end loop;
        end loop;
    end to_G;


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



end Google_naive;
