with boites;	use boites;
with Ada.text_io;	use Ada.text_io;
with Ada.Strings.Unbounded;	use Ada.Strings.Unbounded;

procedure test_boites is
   B: Boite;

begin
   B.epaisseur := 5;
   B.longueur := 200;
   B.largeur := 140;
   B.longueur_queue := 10;
   B.hauteur := 80;
   B.hauteur_interne := 50;
   B.nomFichier := To_Unbounded_String("test1.svg");
   creerBoite(B);

   B.epaisseur := 15;
   B.nomFichier := To_Unbounded_String("test2.svg");
   creerBoite(B);
end;
