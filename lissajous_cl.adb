with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Text_IO;       use Ada.Text_IO;
with Lissajous;

procedure Lissajous_CL is
begin
  if Argument_Count /= 3 then
    Put(Command_Name);
    Put(": relative_X_fequency  relative_Y_frequency  Y_phase");
    New_Line;
    Set_Exit_Status(Failure);
  else
    Lissajous.Run
      (Positive'Value(Argument(1)),
       Positive'Value(Argument(2)),
       Lissajous.Real'Value(Argument(3)));
    Set_Exit_Status(Success);
  end if;
end Lissajous_CL;
