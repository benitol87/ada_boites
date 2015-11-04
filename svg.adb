with fichier;	use fichier;

package body svg is
   procedure InitFichierSVG(Fic: File_Type; Hauteur,Largeur: Natural) is
   begin
      Ecrire_Fichier(Fic, "<svg height='" & Natural'Image(Hauteur) & "' width='" & Natural'Image(Largeur) & "'>");
   end;

   procedure FinirFichierSVG(Fic: File_Type) is
   begin
      Ecrire_Fichier(Fic, "</svg>");
   end;

   -- Ecrit une balise polygon dans un fichier
   procedure DessinerPolygone(P: Polygone; Fic: File_Type) is
   begin
      Ecrire_Fichier(Fic, "<polygon points='");
      Ecrire_Fichier(Fic, To_String(P.points));
      Ecrire_Fichier(Fic, "' style='fill:none;stroke:red;stroke-width:0.1' />");
   end;

   -- Cr�e un polygone sans points et le retourne
   function NouveauPolygone return Polygone is
      P: Polygone;
   begin
      P.points := To_Unbounded_String("");
      return P;
   end;

   -- Ajoute un point � la liste de ceux du polygone passe
   -- en parametre
   procedure AjouterPointPolygone(Poly: in out Polygone; X,Y: Natural) is
   begin
      Poly.points := Poly.points & Natural'Image(X) & "," & Natural'Image(Y) & " ";
   end;
end;
