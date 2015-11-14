with Ada.Strings.Unbounded;	use Ada.Strings.Unbounded;
with Ada.Text_IO;	use Ada.Text_IO;

package svg is
	EPAISSEUR : String := "0.1";
	COULEUR : String := "red";
	
	-- Contient des m�thodes qui �crivent dans le fichier svg
	-- (�crire une balise ouvrante ou fermante, un polygone, ...)

	-- Procedure qui �crit la balise ouvrante svg dans un fichier d�j� ouvert
	-- Requiert : Fic correspond � un fichier d�j� ouvert
	-- 	      Hauteur,Largeur non nuls 
	procedure InitFichierSVG(Fic: File_Type; Hauteur,Largeur: Natural);

	-- Procedure qui �crit la balise fermante svg dans un fichier d�j� ouvert
	-- Requiert : Fic correspond � un fichier d�j� ouvert
	procedure FinirFichierSVG(Fic: File_Type);

	-- Type polygone pour stocker les points
	-- Pas besoin de savoir comment le type est impl�ment� depuis l'ext�rieur
	type Polygone is private;

	-- Ecrit une balise polygon dans un fichier
	-- Requiert : La procedure InitFichierSVG doit avoir ete appelee en ayant passe Fic
	--            La procedure FinirFichierSVG ne doit pas avoir ete appelee en ayant passe Fic
	--            P doit avoir ete initialise avec la procedure NouveauPolygone
	procedure DessinerPolygone(P: Polygone; Fic: File_Type);

	-- Cr�e un polygone sans points et le retourne
	function NouveauPolygone return Polygone;

	-- Ajoute un point � la liste de ceux du polygone passe en parametre
	-- Requiert : P doit avoir ete initialise avec la procedure NouveauPolygone
	-- Remarque : X et Y peuvent ne pas etre compris dans le rectangle du fichier
	-- (toutes les valeurs sont autorisees)
	procedure AjouterPointPolygone(Poly: in out Polygone; X,Y: Float);



	private
	-- d�finition d'un type polygone
	type Polygone is record
		-- On utilise une chaine non bornee pour placer nos poins
		-- Apr�s tout, il n'y aura pas de calcul ou de traitement � faire avec
		-- donc autant les stocker directement de la maniere dont ils
		-- apparaissent dans le fichier svg
		points: Unbounded_String;
	end record;

end;
