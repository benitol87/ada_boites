with Ada.Strings.Unbounded;	use Ada.Strings.Unbounded;
with Ada.Text_IO;	use Ada.Text_IO;

package svg is
	EPAISSEUR : String := "0.1";
	COULEUR : String := "red";
	
	-- Contient des méthodes qui écrivent dans le fichier svg
	-- (écrire une balise ouvrante ou fermante, un polygone, ...)

	-- Procedure qui écrit la balise ouvrante svg dans un fichier déjà ouvert
	-- Requiert : Fic correspond à un fichier déjà ouvert
	-- 	      Hauteur,Largeur non nuls 
	procedure InitFichierSVG(Fic: File_Type; Hauteur,Largeur: Natural);

	-- Procedure qui écrit la balise fermante svg dans un fichier déjà ouvert
	-- Requiert : Fic correspond à un fichier déjà ouvert
	procedure FinirFichierSVG(Fic: File_Type);

	-- Type polygone pour stocker les points
	-- Pas besoin de savoir comment le type est implémenté depuis l'extérieur
	type Polygone is private;

	-- Ecrit une balise polygon dans un fichier
	-- Requiert : La procedure InitFichierSVG doit avoir ete appelee en ayant passe Fic
	--            La procedure FinirFichierSVG ne doit pas avoir ete appelee en ayant passe Fic
	--            P doit avoir ete initialise avec la procedure NouveauPolygone
	procedure DessinerPolygone(P: Polygone; Fic: File_Type);

	-- Crée un polygone sans points et le retourne
	function NouveauPolygone return Polygone;

	-- Ajoute un point à la liste de ceux du polygone passe en parametre
	-- Requiert : P doit avoir ete initialise avec la procedure NouveauPolygone
	-- Remarque : X et Y peuvent ne pas etre compris dans le rectangle du fichier
	-- (toutes les valeurs sont autorisees)
	procedure AjouterPointPolygone(Poly: in out Polygone; X,Y: Float);



	private
	-- définition d'un type polygone
	type Polygone is record
		-- On utilise une chaine non bornee pour placer nos poins
		-- Après tout, il n'y aura pas de calcul ou de traitement à faire avec
		-- donc autant les stocker directement de la maniere dont ils
		-- apparaissent dans le fichier svg
		points: Unbounded_String;
	end record;

end;
