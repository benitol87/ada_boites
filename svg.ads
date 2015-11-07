with Ada.Strings.Unbounded;	use Ada.Strings.Unbounded;
with Ada.Text_IO;	use Ada.Text_IO;

package svg is
   -- Contient des méthodes qui écrivent dans le fichier svg
   -- (écrire une balise ouvrante ou fermante, un polygone, ...)

   procedure InitFichierSVG(Fic: File_Type; Hauteur,Largeur: Natural);
   procedure FinirFichierSVG(Fic: File_Type);

   -- Pas besoin de savoir comment le type est implémenté depuis l'extérieur
   type Polygone is private;

   -- Ecrit une balise polygon dans un fichier
   procedure DessinerPolygone(P: Polygone; Fic: File_Type);

   -- Crée un polygone sans points et le retourne
   function NouveauPolygone return Polygone;

   -- Ajoute un point à la liste de ceux du polygone passe en parametre
   procedure AjouterPointPolygone(Poly: in out Polygone; X,Y: Float);



private
   -- définition d'un type polygone
   type Polygone is record
      points: Unbounded_String;
   end record;

end;
