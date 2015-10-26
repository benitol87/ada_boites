with fichier;	use fichier;
with Ada.text_io;	use Ada.text_io;

procedure test_fichier is
   F: File_Type;
begin
   -- Ouverture du fichier non existant
   Ouvrir_Fichier(F, "test.svg");

   -- Ecriture
   Ecrire_Fichier(F, " ");

   -- Fermeture
   Fermer_Fichier(F);

   Put_Line("  Fichier non existant : OK");

   -- Ouverture du fichier existant
   Ouvrir_Fichier(F, "test.svg");

   -- Ecriture
   Ecrire_Fichier(F, "<svg></svg>");

   -- Fermeture
   Fermer_Fichier(F);

   Put_Line("  Fichier existant : OK");
end;
