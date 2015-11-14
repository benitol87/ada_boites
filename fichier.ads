with Ada.Text_IO;	use Ada.Text_IO;

package fichier is
    -- Contient des methodes pour ouvrir/fermer un fichier ou pour
    -- ecrire dedans

    -- Procedure pour ouvrir un fichier. Si le fichier n'est pas trouvé, il sera créé
    -- Requiert : Nom_Fichier ne doit pas etre vide
    procedure Ouvrir_Fichier(Fic: out File_Type; Nom_Fichier: String);

    -- Procedure pour ecrire dans un fichier deja ouvert
    -- Requiert : Fic doit avoir ete modifie par la procedure Ouvrir_Fichier
    procedure Ecrire_Fichier(Fic: File_Type; Donnees: String);

    -- Procedure pour fermer un fichier ouvert
    -- Cette procedure doit imperativement etre appelee pour que les
    -- modifications soient prises en compte
    procedure Fermer_Fichier(Fic: in out File_Type);

end;
