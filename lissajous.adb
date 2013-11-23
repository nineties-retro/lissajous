with Ada.Numerics;  use Ada.Numerics;
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Text_IO;
package body Lissajous is

  Output_Line_Length: constant := 72;

  package Real_Functions is new Ada.Numerics.Generic_Elementary_Functions(Real);

  function Sign(X:Real) return Integer is
  begin
    if X < 0.0 then
      return -1;
    elsif X > 0.0 then
      return 1;
    else
      return 0;
    end if;
  end Sign;


  function Foo(X:Real) return Real is
  begin
    if Abs(X) < 0.1 then
      return X + X**3/6.0 + 0.075*X**5 + x**7/22.4;
    else
      return 2.0*Foo(X/(Real_Functions.Sqrt(1.0+X)+Real_Functions.Sqrt(1.0-X)));
    end if;
  end Foo;

  procedure Run
    (Relative_X_Frequency: Positive;
     Relative_Y_Frequency: Positive;
     Y_Phase:              Real)
  is
    X_Frequency: constant Real := Real(Relative_X_Frequency) * 2.0 * Pi;
    Y_Frequency: constant Real := Real(Relative_Y_Frequency) * 2.0 * Pi;
    Y: array (0..2*Relative_X_Frequency) of Integer;
    Line: String(1..79);
  begin
    for X1 in -Output_Line_Length/4 .. Output_Line_Length/4 loop
      declare
        T1: constant Real := Foo(Real(X1)/Real(Output_Line_Length/4));
        T2: constant Real := Pi-T1;
      begin
        for I in 0 .. Relative_X_Frequency-1 loop
          declare
            T3: constant Real := (T1+2.0*Real(I)*Pi)/X_Frequency;
            T4: constant Real := (T2+2.0*Real(I)*Pi)/X_Frequency;
            Y1: constant Real := 30.0*Real_Functions.Sin(Y_Frequency*T3+Y_Phase*Pi);
            Y2: constant Real := 30.0*Real_Functions.Sin(Y_Frequency*T4+Y_Phase*Pi);
          begin
            Y(2*I)   := Sign(Y1)*Integer(Real'Unbiased_Rounding(Abs(Y1)+0.5));
            Y(2*I+1) := Sign(Y2)*Integer(Real'Unbiased_Rounding(Abs(Y2)+0.5));
          end;
        end loop;
      end;

      for J in 1 .. 2*Relative_X_Frequency-1 loop
        declare
          T: Integer := Y(J);
          I: Integer := J-1;
        begin
          if T < Y(I) then
            loop
              Y(I+1) := Y(I);
              I := I - 1;
            exit when I < 0;
            end loop;
          end if;
          Y(I+1) := T;
        end;
      end loop;

      Line := (Line'Range => ' ');
      for I in 0 .. 2*Relative_X_Frequency-1 loop
        if I = 0 or else Y(I) /= Y(I-1) then
          Line(Output_Line_Length/2+Y(i)) := '*';
        end if;
      end loop;

      Ada.Text_IO.Put_Line(Line);
    end loop;
  end Run;

end Lissajous;
