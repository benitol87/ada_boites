package boite is
   -- Contient des m�thodes pour cr�er une boite

   type Boite is record
	t: Natural; -- epaisseur
	l: Natural; -- longueur
	w: Natural; -- largeur
	q: Natural; -- longueurQueue
	h: Natural; -- hauteur
	b: Natural; -- hauteur interne (doit v�rifier b<h-2t)
	nomFichier: String(1..100); -- nom du fichier limit� � 100 caracteres
   end record;

   -- Cree un fichier SVG a partir des donn�es d'une boite
   procedure creerBoite(b: Boite);

end;
