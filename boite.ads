package boite is
   -- Contient des méthodes pour créer une boite

   type Boite is record
	t: Natural; -- epaisseur
	l: Natural; -- longueur
	w: Natural; -- largeur
	q: Natural; -- longueurQueue
	h: Natural; -- hauteur
	b: Natural; -- hauteur interne (doit vérifier b<h-2t)
	nomFichier: String(1..100); -- nom du fichier limité à 100 caracteres
   end record;

   -- Cree un fichier SVG a partir des données d'une boite
   procedure creerBoite(b: Boite);

end;
