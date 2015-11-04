package boites is
   -- Contient des méthodes pour créer une boite

   type Boite is record
	epaisseur: Natural; -- t
	longueur: Natural; -- l
	largeur: Natural; -- w
	longueur_queue: Natural; -- q
	hauteur: Natural; -- h
	hauteur_interne: Natural; -- b (doit vérifier b<h-2t)
	nomFichier: String(1..100); -- nom du fichier limité à 100 caracteres
   end record;

   -- Cree un fichier SVG a partir des données d'une boite
   procedure creerBoite(b: Boite);

end;
