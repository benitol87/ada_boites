with fichier;	use fichier;
with svg;	use svg;
with Ada.text_io;	use Ada.text_io;

procedure test_svg is
   F: File_Type;
   P: Polygone;
begin
   -- Création d'un fichier
   Ouvrir_Fichier(F, "etoile.svg");
   InitFichierSVG(F, Hauteur => 400,
                  Largeur => 200);

   -- Création d'un polygone
   P:=NouveauPolygone;

   -- Ajout de quelques points
   AjouterPointPolygone(Poly => P, X => 100.0, Y =>  10.0);
   AjouterPointPolygone(Poly => P, X =>  40.0, Y => 198.0);
   AjouterPointPolygone(Poly => P, X => 190.0, Y =>  78.0);
   AjouterPointPolygone(Poly => P, X =>  10.0, Y =>  78.0);
   AjouterPointPolygone(Poly => P, X => 160.0, Y => 198.0);

   -- Dessin du polygone
   DessinerPolygone(P, F);

   -- Fermeture
   FinirFichierSVG(F);
   Fermer_Fichier(F);
end;
