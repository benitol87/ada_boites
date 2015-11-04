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
   AjouterPointPolygone(Poly => P, X => 100, Y =>  10);
   AjouterPointPolygone(Poly => P, X =>  40, Y => 198);
   AjouterPointPolygone(Poly => P, X => 190, Y =>  78);
   AjouterPointPolygone(Poly => P, X =>  10, Y =>  78);
   AjouterPointPolygone(Poly => P, X => 160, Y => 198);

   -- Dessin du polygone
   DessinerPolygone(P, F);

   -- Fermeture
   FinirFichierSVG(F);
   Fermer_Fichier(F);
end;
