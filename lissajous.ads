package Lissajous is

  subtype Real is Long_Float;

  procedure Run
    (Relative_X_Frequency: Positive;
     Relative_Y_Frequency: Positive;
     Y_Phase:              Real);

end Lissajous;
