with Ada.Text_IO;	use Ada.Text_IO;

package body fichier is
   -- Fonction pour ouvrir un fichier. Si le fichier n'est pas trouvé, il sera créé
   -- Requiert : Nom_Fichier ne doit pas etre vide
   procedure Ouvrir_Fichier(Fic: out File_Type; Nom_Fichier: String) is
   begin
      begin
         Open(Fic, Mode=>Out_File, Name=>Nom_Fichier);
      exception
         when Name_Error => -- Fichier non trouve
            Create(Fic, Mode=>Out_File, Name=>Nom_Fichier);
      end;
   end;

   -- Procedure pour ecrire dans un fichier deja ouvert
   -- Requiert : Fic doit avoir ete retourne par la fonction Ouvrir_Fichier
   procedure Ecrire_Fichier(Fic: File_Type; Donnees: String) is
   begin
      Put(Fic, Donnees);
   end;

   -- Procedure pour fermer un fichier ouvert
   -- Cette procedure doit imperativement etre appelee pour que les
   -- modifications soient prises en compte
   procedure Fermer_Fichier(Fic: in out File_Type) is
   begin
      Close(Fic);
   end;
end;
