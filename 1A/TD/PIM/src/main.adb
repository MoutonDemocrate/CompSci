with Ada.Text_IO;

procedure Main is
   IsPowered : Boolean ;
   IsQuitting : Boolean ;
   altitude : Short_Integer;
begin
   IsPowered := False ;
   IsQuitting := False ;
   while not IsQuitting loop
      Ada.Text_IO.Put_Line("Altitude :") ;
      Ada.Text_IO.Put_Line(String(altitude)) ;
      Ada.Text_IO.Put_Line("") ;
      Ada.Text_IO.Put_Line("Choisissez votre action :") ;
      Ada.Text_IO.Put_Line("Altitude :") ;
      Ada.Text_IO.Put_Line("Altitude :") ;
      Ada.Text_IO.Put_Line("Altitude :") ;
   end loop;
end Main;
