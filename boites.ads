with Ada.Strings.Unbounded;	use Ada.Strings.Unbounded;

package boites is
	MIN_MARGE: constant Float := 1.0; -- Longueur minimale d'une encoche/queue
	MARGE_SVG: constant Float := 5.0; -- Marge entre les différents polygones

	type Boite is record
		epaisseur: Natural; -- t
		longueur: Natural; -- l
		largeur: Natural; -- w
		longueur_queue: Natural; -- q
		hauteur: Natural; -- h
		hauteur_interne: Natural; -- b (doit vérifier b<h-2t)
		nomFichier: Unbounded_String; -- nom du fichier
	end record;

	-- Cree un fichier SVG a partir des données d'une boite
	-- Requiert : Les donnees de la boite doivent etre valides :
	--   * toutes les valeurs doivent etre strictement positives
	--   * longueur >= largeur
	--   * hauteur/2 - epaisseur < hauteur_interne < hauteur - 2.epaisseur
	--   * hauteur > 3.epaisseur
	--   * longueur > 4.epaisseur
	--   * largeur > 4.epaisseur
	--   * longueur_queue <= longueur - 4.epaisseur
	--   * longueur_queue <= largeur - 4.epaisseur - 2.MIN_MARGE
	--   * longueur_queue <= hauteur/2 - epaisseur - MIN_MARGE
	--   * longueur_queue <= hauteur_interne - epaisseur - MIN_MARGE
	procedure creerBoite(B: Boite);

end;
