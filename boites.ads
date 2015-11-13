with Ada.Strings.Unbounded;	use Ada.Strings.Unbounded;

package boites is
    -- Contient des m�thodes pour cr�er une boite

    type Boite is record
        epaisseur: Natural; -- t
        longueur: Natural; -- l
        largeur: Natural; -- w
        longueur_queue: Natural; -- q
        hauteur: Natural; -- h
        hauteur_interne: Natural; -- b (doit v�rifier b<h-2t)
        nomFichier: Unbounded_String; -- nom du fichier
    end record;

    -- Cree un fichier SVG a partir des donn�es d'une boite
    -- Pr�-conditions :
    --    - Les donn�es dans la variable B doivent avoir �t� v�rifi�es
    procedure creerBoite(B: Boite);

end;
