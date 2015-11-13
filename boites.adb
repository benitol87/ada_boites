with fichier;	use fichier;	-- nécessaire pour ouvrir/fermer un fichier svg
with svg;	use svg;	-- écriture dans les fichiers
with Ada.text_io;	use Ada.text_io;

package body boites is
    MARGE_SVG: constant Float := 5.0; -- Marge entre les différents polygones

    -- Point d'ancrage utilisé lors du dessin
    AncreX, AncreY : Float;

    type DemiBoite is record
        epaisseur: Natural; -- t
        longueur: Natural; -- l
        largeur: Natural; -- w
        longueur_queue: Natural; -- q
        hauteur: Natural; -- h
    end record;

    function LongueurDemiBoiteDansSVG(DB: DemiBoite) return Natural is
        resultat: Natural := 0;
    begin
        -- 5 polygones en tout par demi-boite
        -- Le fond de la boite (longueur*largeur)
        resultat := resultat + DB.longueur;

        -- Les deux faces longueur*hauteur
        resultat := resultat + 2*DB.longueur;

        -- Les deux faces largeur*hauteur
        resultat := resultat + 2*DB.largeur;

        -- Marge entre les polygones
        resultat := resultat + 4*Natural(MARGE_SVG);

        return resultat;
    end;

    function NbEncochesQueuesLongueur(DB: DemiBoite) return Natural is
        resultat: Natural;
    begin
        resultat := DB.longueur / DB.longueur_queue;

        while DB.longueur - resultat*DB.longueur_queue < 2*DB.epaisseur loop
            resultat := resultat - 1;
        end loop;

        if resultat mod 2 = 0 and then resultat>0 then
            resultat := resultat - 1;
        end if;

        return resultat;
    end;

    function NbEncochesQueuesLargeur(DB: DemiBoite) return Natural is
        resultat: Natural;
    begin
        resultat := DB.largeur / DB.longueur_queue - 1;

        while DB.largeur - resultat*DB.longueur_queue <= 2*DB.epaisseur loop
            resultat := resultat - 1;
        end loop;

        if resultat mod 2 = 0 and then resultat>0 then
            resultat := resultat - 1;
        end if;

        return resultat;
    end;

    function NbEncochesQueuesHauteur(DB: DemiBoite) return Natural is
        resultat: Natural;
    begin
        resultat := DB.hauteur / DB.longueur_queue;

        while DB.hauteur  - resultat*DB.longueur_queue < 2*DB.epaisseur loop
            resultat := resultat - 1;
        end loop;

        if resultat mod 2 = 0 then
            resultat := resultat - 1;
        end if;

        return resultat;
    end;

    -- Procedure pour dessiner la face longueur*largeur
    procedure DessinerGrandeFace(DB: DemiBoite; Fic: File_Type) is
        xCourant,yCourant : Float := 0.0;
        P: Polygone:=NouveauPolygone;
        K: Float := -1.0; -- Facteur alternant entre -1 et 1 pour faire les encoches

        -- Nombre de queues et d'encoches de longueur "longueurQueue"
        NbEncochesQueuesHorizontales, NbEncochesQueuesVerticales: Natural;
    begin
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        -- Calcul du nombre d'encoches et de queues horizontalement
        NbEncochesQueuesHorizontales := NbEncochesQueuesLongueur(DB);

        -- Calcul du nombre d'encoches et de queues verticalement
        NbEncochesQueuesVerticales := NbEncochesQueuesLargeur(DB);

        -- Coin haut-gauche vers coin haut-droite
        xCourant := Float(DB.longueur - DB.longueur_queue*NbEncochesQueuesHorizontales)/2.0;
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
        yCourant := yCourant + Float(DB.epaisseur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        for i in 1..NbEncochesQueuesHorizontales loop
            xCourant := xCourant + Float(DB.longueur_queue);
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            yCourant := yCourant + Float(DB.epaisseur) * K;
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            K := K * (-1.0);
        end loop;

        xCourant := Float(DB.longueur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        --Coin haut-droite vers coin bas-droite
        yCourant := Float(DB.largeur - DB.longueur_queue*NbEncochesQueuesVerticales)/2.0;
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
        xCourant := xCourant - Float(DB.epaisseur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        K := 1.0;
        for i in 1..NbEncochesQueuesVerticales loop
            yCourant := yCourant + Float(DB.longueur_queue);
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            xCourant := xCourant + Float(DB.epaisseur) * K;
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            K := K * (-1.0);
        end loop;

        yCourant := Float(DB.largeur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        --Coin bas-droite vers coin bas-gauche
        xCourant := xCourant - Float(DB.longueur - DB.longueur_queue*NbEncochesQueuesHorizontales)/2.0;
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
        yCourant := yCourant - Float(DB.epaisseur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        K := 1.0;
        for i in 1..NbEncochesQueuesHorizontales loop
            xCourant := xCourant - Float(DB.longueur_queue);
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            yCourant := yCourant + Float(DB.epaisseur) * K;
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            K := K * (-1.0);
        end loop;

        xCourant := 0.0;
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        --Coin bas-gauche vers coin haut-gauche
        yCourant := yCourant - Float(DB.largeur - DB.longueur_queue*NbEncochesQueuesVerticales)/2.0;
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
        xCourant := xCourant + Float(DB.epaisseur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        K := -1.0;
        for i in 1..NbEncochesQueuesVerticales loop
            yCourant := yCourant - Float(DB.longueur_queue);
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            xCourant := xCourant + Float(DB.epaisseur) * K;
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            K := K * (-1.0);
        end loop;

        -- Ecriture dans le fichier SVG
        DessinerPolygone(P, Fic);

        -- Bouger le point d'ancrage
        AncreX := AncreX + Float(DB.longueur) + MARGE_SVG;
    end;

    -- Procedure pour dessiner la face longueur*hauteur
    procedure DessinerFaceLongueur(DB: DemiBoite; Fic: File_Type) is
        xCourant,yCourant : Float:=0.0;
        P: Polygone:=NouveauPolygone;
        K: Float := -1.0; -- Facteur alternant entre -1 et 1 pour faire les encoches

        -- Nombre de queues et d'encoches de longueur "longueurQueue"
        NbEncochesQueuesHorizontales, NbEncochesQueuesVerticales: Natural;
    begin
        -- Calcul du nombre d'encoches et de queues horizontalement
        NbEncochesQueuesHorizontales := NbEncochesQueuesLongueur(DB);

        -- Calcul du nombre d'encoches et de queues verticalement
        NbEncochesQueuesVerticales := NbEncochesQueuesHauteur(DB);

        -- Coin haut-gauche vers coin haut-droite
        xCourant := Float(DB.epaisseur);
        yCourant := Float(DB.epaisseur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
        xCourant := Float(DB.longueur - DB.longueur_queue*NbEncochesQueuesHorizontales)/2.0;
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
        yCourant := yCourant - Float(DB.epaisseur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        K := 1.0;
        for i in 1..NbEncochesQueuesHorizontales loop
            xCourant := xCourant + Float(DB.longueur_queue);
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            yCourant := yCourant + Float(DB.epaisseur) * K;
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            K := K * (-1.0);
        end loop;

        xCourant := Float(DB.longueur - DB.epaisseur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        --Coin haut-droite vers coin bas-droite 
        K := 1.0;
        for i in 1..NbEncochesQueuesVerticales loop
            yCourant := yCourant + Float(DB.longueur_queue);
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            xCourant := xCourant + Float(DB.epaisseur) * K;
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            K := K * (-1.0);
        end loop;

        yCourant := Float(DB.hauteur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        --Coin bas-droite vers coin bas-gauche
        xCourant := 0.0;
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        --Coin bas-gauche vers coin haut-gauche
        yCourant := yCourant - Float(DB.hauteur - DB.longueur_queue*NbEncochesQueuesVerticales - DB.epaisseur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
        xCourant := xCourant + Float(DB.epaisseur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        K := -1.0;
        for i in 1..NbEncochesQueuesVerticales-1 loop
            yCourant := yCourant - Float(DB.longueur_queue);
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            xCourant := xCourant + Float(DB.epaisseur) * K;
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            K := K * (-1.0);
        end loop;

        -- Ecriture dans le fichier SVG
        DessinerPolygone(P, Fic);

        -- Bouger le point d'ancrage
        AncreX := AncreX + Float(DB.longueur) + MARGE_SVG;
    end;

    -- Procedure pour dessiner la face largeur*hauteur
    procedure DessinerFaceLargeur(DB: DemiBoite; Fic: File_Type) is
        xCourant,yCourant : Float:=0.0;
        P: Polygone:=NouveauPolygone;
        K: Float := -1.0; -- Facteur alternant entre -1 et 1 pour faire les encoches

        -- Nombre de queues et d'encoches de longueur "longueurQueue"
        NbEncochesQueuesHorizontales, NbEncochesQueuesVerticales: Natural;
    begin
        -- Calcul du nombre d'encoches et de queues horizontalement
        NbEncochesQueuesHorizontales := NbEncochesQueuesLargeur(DB);

        -- Calcul du nombre d'encoches et de queues verticalement
        NbEncochesQueuesVerticales := NbEncochesQueuesHauteur(DB); 

        -- Coin haut-gauche vers coin haut-droite 
        yCourant := Float(DB.epaisseur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
        xCourant := Float(DB.largeur - DB.longueur_queue*NbEncochesQueuesHorizontales)/2.0;
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
        yCourant := yCourant - Float(DB.epaisseur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        K := 1.0;
        for i in 1..NbEncochesQueuesHorizontales loop
            xCourant := xCourant + Float(DB.longueur_queue);
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            yCourant := yCourant + Float(DB.epaisseur) * K;
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            K := K * (-1.0);
        end loop;

        xCourant := Float(DB.largeur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        --Coin haut-droite vers coin bas-droite 
        K := -1.0;
        for i in 1..NbEncochesQueuesVerticales loop
            yCourant := yCourant + Float(DB.longueur_queue);
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            xCourant := xCourant + Float(DB.epaisseur) * K;
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            K := K * (-1.0);
        end loop;

        yCourant := Float(DB.hauteur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        --Coin bas-droite vers coin bas-gauche
        xCourant := Float(DB.epaisseur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        --Coin bas-gauche vers coin haut-gauche
        yCourant := yCourant - Float(DB.hauteur - DB.longueur_queue*NbEncochesQueuesVerticales - DB.epaisseur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
        xCourant := xCourant - Float(DB.epaisseur);
        AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);

        K := 1.0;
        for i in 1..NbEncochesQueuesVerticales-1 loop
            yCourant := yCourant - Float(DB.longueur_queue);
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            xCourant := xCourant + Float(DB.epaisseur) * K;
            AjouterPointPolygone(P, xCourant+AncreX, yCourant+AncreY);
            K := K * (-1.0);
        end loop;

        -- Ecriture dans le fichier SVG
        DessinerPolygone(P, Fic);

        -- Bouger le point d'ancrage
        AncreX := AncreX + Float(DB.largeur) + MARGE_SVG;
    end;

    procedure DessinerDemiBoite(DB: DemiBoite; Fic: File_Type) is
    begin
        -- Dessiner le fond de la boite (longueur*largeur)
        DessinerGrandeFace(DB, Fic);

        -- Les deux faces longueur*hauteur
        DessinerFaceLongueur(DB, Fic);
        DessinerFaceLongueur(DB, Fic);

        -- Les deux faces largeur*hauteur
        DessinerFaceLargeur(DB, Fic);
        DessinerFaceLargeur(DB, Fic);
    end;

    procedure creerBoite(B: Boite) is
        F: File_Type;
        Largeur, Hauteur: Natural;
        DemiBoiteExterne, DemiBoiteInterne: DemiBoite;
    begin
        -- Initialisations
        DemiBoiteInterne.epaisseur := B.epaisseur;
        DemiBoiteInterne.longueur_queue := B.longueur_queue;
        DemiBoiteInterne.longueur := B.longueur - 2*B.epaisseur;
        DemiBoiteInterne.largeur := B.largeur - 2*B.epaisseur;
        DemiBoiteInterne.hauteur := B.hauteur_interne;

        DemiBoiteExterne.epaisseur := B.epaisseur;
        DemiBoiteExterne.longueur_queue := B.longueur_queue;
        DemiBoiteExterne.longueur := B.longueur;
        DemiBoiteExterne.largeur := B.largeur;
        DemiBoiteExterne.hauteur := B.hauteur/2;

        AncreX := MARGE_SVG;
        Ancrey := MARGE_SVG;

        -- Création/ouverture du fichier svg
        Ouvrir_Fichier(F, To_String(B.nomFichier));

        -- Calcul de la hauteur de l'image
        Hauteur := B.hauteur;
        if B.largeur > Hauteur then Hauteur := B.largeur; end if;
        if B.hauteur_interne > Hauteur then Hauteur := B.hauteur_interne; end if;
        -- Prise en compte des marges
        Hauteur := Hauteur + 2*Natural(MARGE_SVG);

        -- Calcul de la largeur de l'image
        Largeur := 2*LongueurDemiBoiteDansSVG(DemiBoiteExterne)
        + LongueurDemiBoiteDansSVG(DemiBoiteInterne)
        + 4*Natural(MARGE_SVG);

        -- Ecriture de l'en-tete du fichier
        InitFichierSVG(F, Hauteur, Largeur);

        -- 1ère demi-boite externe
        DessinerDemiBoite(DemiBoiteExterne, F);

        -- 2ème demi-boite externe
        DessinerDemiBoite(DemiBoiteExterne, F);

        -- Demi-boite interne
        DessinerDemiBoite(DemiBoiteInterne, F);

        -- Fermer le fichier
        FinirFichierSVG(F);
        Fermer_Fichier(F);
    end;
end;
