with fichier;	use fichier;

package body svg is
   EPAISSEUR : String := "0.1";
   COULEUR : String := "red";
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
      Ecrire_Fichier(Fic, "' style='fill:none;stroke:" & COULEUR & ";stroke-width:" & EPAISSEUR & "' />");
   end;

   -- Crée un polygone sans points et le retourne
   function NouveauPolygone return Polygone is
      P: Polygone;
   begin
      P.points := To_Unbounded_String("");
      return P;
   end;

   -- Ajoute un point à la liste de ceux du polygone passe
   -- en parametre
   procedure AjouterPointPolygone(Poly: in out Polygone; X,Y: Float) is
   begin
      Poly.points := Poly.points & Float'Image(X) & "," & Float'Image(Y) & " ";
   end;
end;
