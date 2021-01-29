with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;            use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Command_Line;     use Ada.Command_Line;
with LCA;
with Google_naive;
with Google_creuse;
procedure pagerank is
   

    -- fonction qui retourne la capacite stocker dans le fichier
    function get_capacite(fichier: in String) return Integer is
        f : file_type;
        data : Integer;
    begin
        open(f,in_file,fichier);
        Get(f, data);
        close(f);
        return data;
    end get_capacite;

    -- Stocker la capacité dans la variable c
    c : Integer := get_capacite(Argument(Argument_Count));
    


    
    package matrice_naive is
		new Google_naive (Capacite => c);
    use matrice_naive;

     package matrice_creuse is
		new Google_creuse (Capacite => c);
    use matrice_creuse;
    

    matrice_N : matrice_naive.T_Google;
    matrice_C : matrice_creuse.T_matrice;
    fichier : file_type;
    poids_N : matrice_naive.T_Vecteur_reel := (1..c => (1.0/float(c))); 
    poids_C : matrice_creuse.T_Vecteur_reel := (1..c => (1.0/float(c))); 
    nb_iteration : Integer := 150;
    implementation_naive : boolean := false;

    V_indice_N : matrice_naive.T_Vecteur_entier;
    V_indice_C : matrice_creuse.T_Vecteur_entier;
    alpha : float := 0.85;

    
    alpha_non_valide  : Exception;
    nombre_itr_nonValide : Exception;
    option_P_nonValide : Exception;
    
    
    
    
begin
    

  begin

    if Argument_Count = 1 then
        implementation_naive := false;

    elsif Argument_Count = 2 then
        
          if Argument (1) /= "-P" then
          raise option_P_nonValide;
        else
          implementation_naive := (Argument (1) = "-P");
        end if;

    elsif Argument_Count = 3 and Argument (1) = "-A" then
       
       if float'Value(Argument (2)) < 0.0 or float'Value(Argument (2)) > 1.0 then
          raise alpha_non_valide;
        else
          alpha := Float'Value(Argument (2));
        end if;
        

    elsif Argument_Count = 3 and Argument (1) = "-I" then
        
        if Integer'Value(Argument (2)) <= 0 then
        
          raise nombre_itr_nonValide;
        else
          nb_iteration := Integer'Value(Argument (2));
        end if;
    
    elsif Argument_Count = 4 and Argument (2) = "-I" then
        
       
         if Integer'Value(Argument (3)) <= 0 then
          
          raise nombre_itr_nonValide;
          
        else
          
          nb_iteration := Integer'Value(Argument (3));
         
        end if;

         if Argument (1) /= "-P" then
          raise option_P_nonValide;
        else
           implementation_naive := (Argument (1) = "-P");
        end if;
    elsif Argument_Count = 4 and Argument (2) = "-A" then

       
       

       if float'Value(Argument (3)) < 0.0 or float'Value(Argument (3)) > 1.0   then
          raise alpha_non_valide;
        else
         alpha := Float'Value(Argument (3));
        end if;

         if Argument (1) /= "-P" then
          raise option_P_nonValide;
        else
           implementation_naive := (Argument (1) = "-P");
        end if;

    elsif Argument_Count = 5 and Argument (1) = "-A" and Argument(3) = "-I" then

       
       

       if float'Value(Argument (2)) < 0.0 or float'Value(Argument (2)) > 1.0   then
          raise alpha_non_valide;
        else
         alpha := Float'Value(Argument (2));
        end if;

           if Integer'Value(Argument (4)) <= 0 then
          raise nombre_itr_nonValide;
        else
          nb_iteration := Integer'Value(Argument (4));
        end if;

     elsif Argument_Count = 5 and Argument (3) = "-A" and Argument(1) = "-I" then

       
       

       if float'Value(Argument (4)) < 0.0 or float'Value(Argument (4)) > 1.0   then
          raise alpha_non_valide;
        else
         alpha := Float'Value(Argument (4));
        end if;

        if Integer'Value(Argument (2)) <= 0 then
          raise nombre_itr_nonValide;
        else
          nb_iteration := Integer'Value(Argument (2));
        end if;
       
    elsif Argument_Count = 6 and Argument (2) = "-I" and Argument (4) = "-A" then
        
        
       

        if float'Value(Argument (5)) < 0.0 or float'Value(Argument (5)) > 1.0   then
          raise alpha_non_valide;
        else
         alpha := Float'Value(Argument (5));
        end if;

        if Integer'Value(Argument (3)) <= 0 then
          raise nombre_itr_nonValide;
        else
          nb_iteration := Integer'Value(Argument (3));
        end if;

         if Argument (1) /= "-P" then
          raise option_P_nonValide;
        else
           implementation_naive := (Argument (1) = "-P");
        end if;
    elsif Argument_Count = 6 and Argument(4) = "-I" and Argument (2) = "-A" then
        
        
       

        if float'Value(Argument (3)) < 0.0 or float'Value(Argument (3)) > 1.0   then
          raise alpha_non_valide;
        else
         alpha := Float'Value(Argument (3));
        end if;

        if Integer'Value(Argument (5)) <= 0 then
          raise nombre_itr_nonValide;
        else
          nb_iteration := Integer'Value(Argument (5));
        end if;

         if Argument (1) /= "-P" then
          raise option_P_nonValide;
        else
           implementation_naive := (Argument (1) = "-P");
        end if;
    else
        raise CONSTRAINT_ERROR;
    end if;

Exception 
    when
    option_P_nonValide => 
        put("Premiere option non valide,Veuillez entrez -P (pour une implementation naive) ou non (pour une implementation creuse).");
  when
  alpha_non_valide => 
        put("Alpha non vlaide, Veuillez entrez une valeur de alpha entre 0 et 1.");
  when 
  nombre_itr_nonValide =>
        put("Nombre d'iteration non valide, Veuillez entrez un nombre strictement positif.");
  when
  constraint_error => 
        put("Veuillez entrez une commande de type : ./pagerank (-P)? ((-A {reel entre 0 et 1})(-I {Naturel}))? ((-I {Naturel})|(-A {reel entre 0 et 1}))? (Nom du fichier graphe).");
   
   
end;
    
    

    if implementation_naive then
    -- L'implémentation naive
        -- Initialiser la matrice " matrice_N"
        matrice_naive.Initialiser(matrice_N);
        -- Lire le fichier du graphe et le stocker dans la matrice "matrice_N"
        matrice_naive.Lire(matrice_N,Argument(Argument_Count));
        -- afficher la matrice pour tester
        --matrice_naive.afficher(matrice_N);
        -- Transformer la matrice "matrice_N" de type H à une matrice de Type S
        matrice_naive.to_S(matrice_N);
        -- Transformer la matrice "matrice_N" de type S à une matrice de Type G
        matrice_naive.to_G(matrice_N,alpha);

        -- Calculer le poids des pages par la méthode iterative "pi_(k+1) = pi_(k)*G"
        for i in 1..nb_iteration loop
           poids_N := matrice_naive.produit(matrice_N,poids_N);
        end loop;


        
        -- Trier le vecteur poids et Générer le vecteur des indices triés.
        matrice_naive.Trier(poids_N,V_indice_N);
        -- afficher le poids pour tester
        --matrice_naive.afficher(poids_N);
        
        -- Ecrire le vecteur poids dans le fichier "poids.p"
       matrice_naive.Ecrire(poids_N, "poids.p",alpha,nb_iteration);
        -- Ecrire le vecteur des indices dans le fichier "noeuds.ord"
        matrice_naive.Ecrire(V_indice_N, "noeuds.ord");
   
    else
    -- L'implémentation Creuse
        -- Initialiser la matrice " matrice_C"
        matrice_creuse.Initialiser(matrice_C);
        -- Lire le fichier du graphe et le stocker dans un tableau de hachage "matrice_C"
        matrice_creuse.Lire(matrice_C,Argument(Argument_Count));
        -- afficher la matrice pour tester
        --matrice_creuse.afficher(matrice_C);
        -- Transformer la matrice "matrice_N" de type H à une matrice de Type S
        matrice_creuse.to_S(matrice_C);

        

       
        
        -- Calculer le poids des pages par la méthode iterative "pi_(k+1) = pi_(k)*G"
        for i in 1..nb_iteration loop
           poids_C := matrice_creuse.produit(matrice_C,poids_C,alpha);
        end loop;


       

        -- Trier le vecteur poids et Générer le vecteur des indices triés.
        matrice_creuse.Trier(poids_C,V_indice_C);
        -- afficher le poids pour tester
        --matrice_creuse.afficher(poids_C);

        -- Ecrire le vecteur poids dans le fichier "poids.p"
        matrice_creuse.Ecrire(poids_C, "poids.p",alpha,nb_iteration);
        -- Ecrire le vecteur des indices dans le fichier "noeuds.ord"
        matrice_creuse.Ecrire(V_indice_C, "noeuds.ord");

        -- Vider la tableau de hachage "matrice_C"
        matrice_creuse.Vider(matrice_C);
    
    end if;
   
    


    
end pagerank;
