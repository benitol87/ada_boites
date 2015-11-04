package boites is
   -- Contient des m�thodes pour cr�er une boite

   type Boite is record
	epaisseur: Natural; -- t
	longueur: Natural; -- l
	largeur: Natural; -- w
	longueur_queue: Natural; -- q
	hauteur: Natural; -- h
	hauteur_interne: Natural; -- b (doit v�rifier b<h-2t)
	nomFichier: String(1..100); -- nom du fichier limit� � 100 caracteres
   end record;

   -- Cree un fichier SVG a partir des donn�es d'une boite
   procedure creerBoite(b: Boite);

end;
