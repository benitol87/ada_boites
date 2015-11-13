with Ada.Strings.Unbounded;	use Ada.Strings.Unbounded;

package boites is
    -- Contient des méthodes pour créer une boite

    type Boite is record
        epaisseur: Natural; -- t
        longueur: Natural; -- l
        largeur: Natural; -- w
        longueur_queue: Natural; -- q
        hauteur: Natural; -- h
        hauteur_interne: Natural; -- b (doit vérifier b<h-2t)
        nomFichier: Unbounded_String; -- nom du fichier
    end record;

    -- Cree un fichier SVG a partir des données d'une boite
    -- Pré-conditions :
    --    - Les données dans la variable B doivent avoir été vérifiées
    procedure creerBoite(B: Boite);

end;
