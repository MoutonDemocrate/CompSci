with Ada.Text_IO ; use Ada.Text_IO ;
with Ada.Integer_Text_IO ; use Ada.Integer_Text_IO ;

procedure Ex1_PGCD is
   a : Integer ;
   b : Integer ;
   na : Integer ;
   nb : Integer ;
   pgcd : Integer ;
begin
   -- Demander deux entiers a et b
   Put("a = ");
   Get(a);
   Put("b = ");
   Get(b);
   pragma Assert (a > 0 and b > 0) ;
   -- Déterminer le pgcd de a et b
   na := a ;
   nb := b ;
   		-- Déterminer na et nb diférents
   while not (na = nb) loop
      		-- soustraire au plus grand le plus petit
      if na > nb then
         na := na - nb ;
      else
         nb := nb - na ;
      end if;
   end loop;
   pgcd := na ;
   -- Afficher le pgcd
   Put("PGCD = ");
   Put(pgcd);
end Ex1_PGCD;
