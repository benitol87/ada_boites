with boites;	use boites;
with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Text_IO;       use Ada.Text_IO;

procedure main is
   b0: Boite;
   function analyse return Boite is
      b: Boite;
      longueur_entree: Boolean:= False;
      epaisseur_entree: Boolean:= False;
      largeur_entree: Boolean:= False;
      longueur_queues_entree: Boolean:= False;
      hauteur_interne_entree: Boolean:= False;
      hauteur_entree: Boolean:= False;
      nom_fichier_entree: Boolean:= False;
      lancer_exception: Boolean:=True;

      parametre_manquant_exception : exception;

   begin
      for Arg in 1..(Argument_Count-1) loop
         -- affectations des parametres de la boite
         if Argument(Arg) = "-t" then
            epaisseur_entree := True;
            b.epaisseur := Argument(Arg+1);
         elsif Argument(Arg) = "-l" then
            longueur_entree := True;
            b.longueur := Argument(Arg+1);
         elsif Argument(Arg) = "-w" then
            largeur_entree := True;
            b.largeur := Argument(Arg+1);
         elsif Argument(Arg) = "-q" then
            longueur_queue_entree := True;
            b.longueur_queue := Argument(Arg+1);
         elsif Argument(Arg) = "-h" then
            hauteur_entree := True;
            b.hauteur := Argument(Arg+1);
         elsif Argument(Arg) = "-b" then
            hauteur_interne_entree := True;
            b.hauteur_interne := Argument(Arg+1);
         elsif Argument(Arg) = "-f" then
            nom_fichier_entree := True;
            b.nom_fichier := Argument(Arg+1);
         end if;
      end loop;
      -- vefification que la totalite des parametres de la boite soit remplie
      if longueur_entree = False then
         Put_Line("Longueur non entree");
      elsif epaisseur_entree = False then
         Put_Line("Epaisseur non entree");
      elsif largeur_entree = False then
         Put_Line("Largeur non entree");
      elsif longueur_queue_entree = False then
         Put_line("Lonqueur de queue non entree");
      elsif hauteur_entree = False then
         Put_Line("Hauteur non entree");
      elsif hauteur_interne_entree = False then
         Put_Line("Hauteur interne non entree");
      elsif nom_fichier_entree = False then
         Put_Line("Nom de fichier non entre");
      else
         lancer_exception :=False;
      end if;
      if lancer_exception then
         raise parametre_manquant_exception;
      end if;
      return b;
   end analyse;
begin
   -- Analyse de la ligne de commande, récupération des données
   -- (utilisation package commande)
   b0 := analyse;
   Put_Line(b0);
   -- Création de la boite
   -- (utilisation du package boite)

end;


