with boites;	use boites;
with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Strings.Unbounded;	use Ada.Strings.Unbounded;

-- Point d'entree du programme
procedure main is
    b0: Boite;
    Erreur_Parametres_Exception : exception;

    -- Fonction recuperant les arguments en ligne de commande et les placant dans 
    -- une variable de type boite
    -- Traite le cas ou les parametres n'ont pas le bon type (nombre negatif ou mot
    -- au lieu d'un entier naturel par exemple)
    -- Traite le cas d'options manquantes
    function RecupererArguments return Boite is
        b: Boite;
        longueur_entree: Boolean:= False;
        epaisseur_entree: Boolean:= False;
        largeur_entree: Boolean:= False;
        longueur_queue_entree: Boolean:= False;
        hauteur_interne_entree: Boolean:= False;
        hauteur_entree: Boolean:= False;
        nom_fichier_entree: Boolean:= False;
        lancer_exception: Boolean:=True;

        Arg: Natural:= 1; -- Compteur de boucle
    begin    
        while Arg < Argument_Count loop
            -- affectations des parametres de la boite
            if Argument(Arg) = "-t" then
                if epaisseur_entree then
                    Put_Line("! Plusieurs valeurs pour l'epaisseur ont ete saisies, seule la derniere sera gardee.");
                end if;

                epaisseur_entree := True;
                b.epaisseur := Natural'Value(Argument(Arg+1));
            elsif Argument(Arg) = "-l" then
                if longueur_entree then
                    Put_Line("! Plusieurs valeurs pour la longueur ont ete saisies, seule la derniere sera gardee.");
                end if;

                longueur_entree := True;
                b.longueur := Natural'Value(Argument(Arg+1));
            elsif Argument(Arg) = "-w" then
                if largeur_entree then
                    Put_Line("! Plusieurs valeurs pour la largeur ont ete saisies, seule la derniere sera gardee.");
                end if;
                
                largeur_entree := True;
                b.largeur := Natural'Value(Argument(Arg+1));
            elsif Argument(Arg) = "-q" then
                if longueur_queue_entree then
                    Put_Line("! Plusieurs valeurs pour la longueur des queues ont ete saisies, seule la derniere sera gardee.");
                end if;
                
                longueur_queue_entree := True;
                b.longueur_queue := Natural'Value(Argument(Arg+1));
            elsif Argument(Arg) = "-h" then
                if hauteur_entree then
                    Put_Line("! Plusieurs valeurs pour la hauteur ont ete saisies, seule la derniere sera gardee.");
                end if;
                
                hauteur_entree := True;
                b.hauteur := Natural'Value(Argument(Arg+1));
            elsif Argument(Arg) = "-b" then
                if hauteur_interne_entree then
                    Put_Line("! Plusieurs valeurs pour la hauteur interne ont ete saisies, seule la derniere sera gardee.");
                end if; 

                hauteur_interne_entree := True;
                b.hauteur_interne := Natural'Value(Argument(Arg+1));
            elsif Argument(Arg) = "-f" then
                if nom_fichier_entree then
                    Put_Line("! Plusieurs valeurs pour le nom du fichier ont ete saisies, seule la derniere sera gardee.");
                end if;

                nom_fichier_entree := True;
                b.nomFichier := To_Unbounded_String(Argument(Arg+1));
            else
                Put_Line("Option non reconnue : " & Argument(Arg));
                raise Erreur_Parametres_Exception;
            end if;
            Arg := Arg + 2;
        end loop;

        -- verification que la totalite des parametres de la boite soit remplie
        if longueur_entree = False then
            Put_Line("Erreur : longueur non specifiee (option -l <longueur>)");
        elsif epaisseur_entree = False then
            Put_Line("Erreur : epaisseur non specifiee (option -t <epaisseur>)");
        elsif largeur_entree = False then
            Put_Line("Erreur : largeur non specifiee (option -w <largeur>)");
        elsif longueur_queue_entree = False then
            Put_line("Erreur : longueur de queue non specifiee (option -q <longueurQueue>)");
        elsif hauteur_entree = False then
            Put_Line("Erreur : hauteur non specifiee (option -h <hauteur>)");
        elsif hauteur_interne_entree = False then
            Put_Line("Erreur : hauteur interne non specifiee (option -b <hauteurInterne>)");
        elsif nom_fichier_entree = False then
            Put_Line("Erreur : nom de fichier non specifie (option -f <nomFichier>)");
        else
            lancer_exception :=False;
        end if;
        if lancer_exception then
            raise Erreur_Parametres_Exception;
        end if;
        return b;
    end;

    -- Procedure qui compare les donnees d'une boite par rapport aux limites autorisees
    -- Requiert : Toutes les attributs de la boite ont ete initialises
    -- Si cette procedure ne lance pas d'exceptions, alors la variable Boite peut
    -- etre passee en parametre a la procedure creerBoite du package boites
    procedure VerifierDonnees(B: in out Boite) is
        problemeDetecte : Boolean := False;
        temp : Natural;
    begin
        -- Cas une des valeurs est nulle
        if B.longueur = 0 or B.largeur = 0 or B.hauteur = 0 or B.hauteur_interne = 0 or
            B.epaisseur = 0 or B.longueur_queue = 0 then
            Put_Line("Erreur : Une des options est nulle");
            problemeDetecte:=True;
        end if;

        -- Cas longueur < largeur
        if B.longueur < B.largeur then
            -- on échange les valeurs, pas besoin d'informer l'utilisateur vu que ca ne change rien pour lui
            temp := B.longueur;
            B.longueur := B.largeur;
            B.largeur := temp;
        end if;

        -- Cas b <= h/2 - t, ie la boite ne peut pas etre fermee correctement car la demi-boite interne n'est pas assez haute
        if B.hauteur_interne <= (B.hauteur/2 - B.epaisseur) then
            Put_Line("Erreur : La hauteur interne est trop petite par rapport a la hauteur et l'epaisseur de la boite");
            problemeDetecte:=True;
        end if;

        -- Cas b >= h -2t, ie les deux demi-boites externes ne se touchent pas quand on referme la boite
        if B.hauteur_interne >= (B.hauteur - 2*B.epaisseur) then
            Put_Line("Erreur : La hauteur interne est trop grande par rapport a la hauteur et l'epaisseur de la boite");
            problemeDetecte:=True;
        end if;

        -- Cas h<=3t, l<=4t, w<=4t
        if B.hauteur <= 3*B.epaisseur or B.longueur <= 4*B.epaisseur or B.largeur <= 4*B.epaisseur then
            Put_Line("Erreur : L'epaisseur de la boite est trop grande par rapport aux dimensions externes de la boite.");
            problemeDetecte:=True;
        end if;

        -- Cas q>=l-4t, q>=w-2(2t+MIN_MARGE), q>=h/2-t-MIN_MARGE, q>=b-t-MIN_MARGE
        if B.longueur_queue > B.longueur-4*B.epaisseur or
            B.longueur_queue > B.largeur-2*(2*B.epaisseur+Natural(MIN_MARGE)) or
            B.longueur_queue > B.hauteur/2-B.epaisseur-Natural(MIN_MARGE) or
            B.longueur_queue > B.hauteur_interne-B.epaisseur-Natural(MIN_MARGE)
        then
            Put_Line("Erreur : La longueur de queue est trop grande par rapport aux autres dimensions de la boite et ne permet pas de faire des encoches sur certaines aretes.");
            problemeDetecte:=True;
        end if;

        if problemeDetecte then 
            raise Erreur_Parametres_Exception;
        end if;
    end;
begin
    begin
	-- Point d'entree de l'application
        -- Analyse de la ligne de commande, récupération des données
        b0 := RecupererArguments;

        -- Verification de la coherence des donnees
        VerifierDonnees(b0);

        -- Création de la boite
        creerBoite(b0);

    exception
        -- Option manquante/valeur d'au moins un parametre non coherent avec les autres
        when Erreur_Parametres_Exception =>
            Put_Line("Echec lors de la creation du fichier svg");
            Set_Exit_Status(1);
	-- Type de parametre illegal
        when Constraint_Error =>
            Put_Line("Au moins un des arguments attendus aurait du etre un entier strictement positif");
            Put_Line("Echec lors de la creation du fichier svg");
            Set_Exit_Status(2);

    end;
end;


