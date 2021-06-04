within BestInClass.ThermalZones;
model GainSchedule3 "Schedule for internal heat gains"
  //extends Modelica.
  Modelica.Blocks.Sources.CombiTimeTable occSch(
    table=[0,0; 6,0; 6,0.1; 7,0.1; 7,0.2; 8,0.2; 8,0.95; 9,0.95; 12,0.95; 12,0.5;
        13,0.5; 13,0.95; 17,0.95; 17,0.7; 18,0.7; 18,0.4; 20,0.4; 20,0.1; 22,0.1;
        22,0; 24,0; 30,0; 30,0.1; 31,0.1; 31,0.2; 32,0.2; 32,0.95; 33,0.95; 36,0.95;
        36,0.5; 37,0.5; 37,0.95; 41,0.95; 41,0.7; 42,0.7; 42,0.4; 44,0.4; 44,0.1;
        46,0.1; 46,0; 48,0; 54,0; 54,0.1; 55,0.1; 55,0.2; 56,0.2; 56,0.95; 57,0.95;
        60,0.95; 60,0.5; 61,0.5; 61,0.95; 65,0.95; 65,0.7; 66,0.7; 66,0.4; 68,0.4;
        68,0.1; 70,0.1; 70,0; 72,0; 78,0; 78,0.1; 79,0.1; 79,0.2; 80,0.2; 80,0.95;
        81,0.95; 84,0.95; 84,0.5; 85,0.5; 85,0.95; 89,0.95; 89,0.7; 90,0.7; 90,0.4;
        92,0.4; 92,0.1; 94,0.1; 94,0; 96,0; 102,0; 102,0.1; 103,0.1; 103,0.2; 104,
        0.2; 104,0.95; 105,0.95; 108,0.95; 108,0.5; 109,0.5; 109,0.95; 113,0.95;
        113,0.7; 114,0.7; 114,0.4; 116,0.4; 116,0.1; 118,0.1; 118,0; 120,0; 126,
        0; 126,0.1; 128,0.1; 128,0.5; 134,0.5; 134,0.1; 137,0.1; 137,0; 168,0],
    timeScale=3600,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Occupancy schedule for internal heat gains"
    annotation (Placement(transformation(extent={{-140,120},{-120,140}})));

  Modelica.Blocks.Sources.CombiTimeTable ligSch(
    table=[0,0.05; 5,0.05; 5,0.1; 7,0.1; 7,0.3; 8,0.3; 8,0.9; 17,0.9; 17,0.7; 18,
        0.7; 18,0.5; 20,0.5; 20,0.3; 22,0.3; 22,0.1; 23,0.1; 23,0.05; 24,0.05; 29,
        0.05; 29,0.1; 31,0.1; 31,0.3; 32,0.3; 32,0.9; 41,0.9; 41,0.7; 42,0.7; 42,
        0.5; 44,0.5; 44,0.3; 46,0.3; 46,0.1; 47,0.1; 48,0.05; 48,0.05; 53,0.05;
        53,0.1; 55,0.1; 55,0.3; 56,0.3; 56,0.9; 65,0.9; 65,0.7; 66,0.7; 66,0.5;
        68,0.5; 68,0.3; 70,0.3; 70,0.1; 71,0.1; 72,0.05; 72,0.05; 77,0.05; 77,0.1;
        79,0.1; 79,0.3; 80,0.3; 80,0.9; 89,0.9; 89,0.7; 90,0.7; 90,0.5; 92,0.5;
        92,0.3; 94,0.3; 94,0.1; 95,0.1; 96,0.05; 96,0.05; 101,0.05; 101,0.1; 103,
        0.1; 103,0.3; 104,0.3; 104,0.9; 113,0.9; 113,0.7; 114,0.7; 114,0.5; 116,
        0.5; 116,0.3; 118,0.3; 118,0.1; 119,0.1; 120,0.05; 120,0.05; 126,0.05; 126,
        0.1; 128,0.1; 128,0.5; 134,0.5; 134,0.15; 137,0.15; 137,0.05; 168,0.05],
    timeScale=3600,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Lighting schedule for internal heat gains"
    annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));

  Modelica.Blocks.Sources.CombiTimeTable equSch(
    table=[0,0.4; 8,0.4; 8,0.9; 12,0.9; 12,0.8; 13,0.8; 13,0.9; 17,0.9; 17,0.8;
        18,0.8; 18,0.6; 20,0.6; 20,0.5; 22,0.5; 22,0.4; 24,0.4; 32,0.4; 32,0.9;
        36,0.9; 36,0.8; 37,0.8; 37,0.9; 41,0.9; 41,0.8; 42,0.8; 42,0.6; 44,0.6;
        44,0.5; 46,0.5; 46,0.4; 48,0.4; 56,0.4; 56,0.9; 60,0.9; 60,0.8; 61,0.8;
        61,0.9; 65,0.9; 65,0.8; 66,0.8; 66,0.6; 68,0.6; 68,0.5; 70,0.5; 70,0.4;
        72,0.4; 80,0.4; 80,0.9; 84,0.9; 84,0.8; 85,0.8; 85,0.9; 89,0.9; 89,0.8;
        90,0.8; 90,0.6; 92,0.6; 92,0.5; 94,0.5; 94,0.4; 96,0.4; 104,0.4; 104,0.9;
        108,0.9; 108,0.8; 109,0.8; 109,0.9; 113,0.9; 113,0.8; 114,0.8; 114,0.6;
        116,0.6; 116,0.5; 118,0.5; 118,0.4; 120,0.4; 120,0.3; 126,0.3; 126,0.4;
        128,0.4; 128,0.5; 134,0.5; 134,0.35; 137,0.35; 137,0.3; 168,0.3],
    timeScale=3600,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Equipment schedule for internal heat gains"
    annotation (Placement(transformation(extent={{-140,-110},{-120,-90}})));
  Modelica.Blocks.Math.MatrixGain occFra(K=[0.3; 0.4; 0.3])
    "Matrix gain to split up heat gain in radiant, convective and latent gain"
    annotation (Placement(transformation(extent={{-106,120},{-86,140}})));
  Modelica.Blocks.Math.MatrixGain ligFra(K=[0.7; 0.3; 0.0])
    "Matrix gain to split up heat gain in radiant, convective and latent gain"
    annotation (Placement(transformation(extent={{-106,-30},{-86,-10}})));
  Modelica.Blocks.Math.MatrixGain eqiFra(K=[0.5; 0.5; 0.0])
    "Matrix gain to split up heat gain in radiant, convective and latent gain"
    annotation (Placement(transformation(extent={{-104,-110},{-84,-90}})));
  Modelica.Blocks.Math.Gain intOccCor[3](each k=7.3) "Intensity for core zone"
    annotation (Placement(transformation(extent={{-60,152},{-40,172}})));
  Modelica.Blocks.Math.Gain intOccWes[3](each k=14) "Intensity for east zone"
    annotation (Placement(transformation(extent={{-60,120},{-40,140}})));
  Modelica.Blocks.Math.Gain intLigCor[3](each k=11.8) "Intensity for core zone"
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Math.Add3 totGaiCor[3]
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Blocks.Math.Add3 totGaiEas[3]
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Blocks.Math.Gain intLigSou[3](each k=5.4) "Intensity for core zone"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Math.Gain intLigEas[3](each k=3.1)
                                                    "Intensity for core zone"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Math.Gain intLigNor[3](each k=8.6) "Intensity for core zone"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Math.Gain intLigWes[3](each k=14) "Intensity for core zone"
    annotation (Placement(transformation(extent={{-60,-68},{-40,-48}})));
  Modelica.Blocks.Math.Gain intEquCor[3](each k=10.3) "Intensity for core zone"
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  Modelica.Blocks.Math.Gain intEquSou[3](each k=3.1) "Intensity for core zone"
    annotation (Placement(transformation(extent={{-60,-130},{-40,-110}})));
  Modelica.Blocks.Math.Gain intEquEas[3](each k=2.4)  "Intensity for core zone"
    annotation (Placement(transformation(extent={{-60,-160},{-40,-140}})));
  Modelica.Blocks.Math.Gain intEquWes[3](each k=2.9) "Intensity for core zone"
    annotation (Placement(transformation(extent={{-60,-190},{-40,-170}})));
  Modelica.Blocks.Interfaces.RealOutput yGaiSou[3] "Internal heat gain "
    annotation (Placement(transformation(extent={{120,20},{140,40}}),
        iconTransformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput yGaiEas[3] "Internal heat gain "
    annotation (Placement(transformation(extent={{120,-30},{140,-10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput yGaiNor[3] "Internal heat gain "
    annotation (Placement(transformation(extent={{120,-100},{140,-80}}),
        iconTransformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput yGaiWes[3] "Internal heat gain "
    annotation (Placement(transformation(extent={{120,-160},{140,-140}}),
        iconTransformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Sources.CombiTimeTable occSchSou(
    table=[0,0; 10,0; 10,0.9; 11,0.9; 11,0; 15,0; 15,0.4; 16,0.4; 16,0; 24,0],
    timeScale=3600,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Occupancy schedule for internal heat gains"
    annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
  Modelica.Blocks.Math.MatrixGain occFra1(K=[0.3; 0.4; 0.3])
    "Matrix gain to split up heat gain in radiant, convective and latent gain"
    annotation (Placement(transformation(extent={{-106,80},{-86,100}})));
  Modelica.Blocks.Math.Gain intOccEas[3](each k=15.5)
                                                    "Intensity for east zone"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Math.Add3 totGaiWes[3]
    annotation (Placement(transformation(extent={{40,-160},{60,-140}})));
  Modelica.Blocks.Math.Add totGaiSou[3]
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Modelica.Blocks.Interfaces.RealOutput yGaiCor[3] "Internal heat gain "
    annotation (Placement(transformation(extent={{120,70},{140,90}}),
        iconTransformation(extent={{100,70},{120,90}})));
equation
  connect(ligSch.y,ligFra. u)
    annotation (Line(points={{-119,-20},{-108,-20}},
                                                  color={0,0,127}));
  connect(equSch.y,eqiFra. u)
    annotation (Line(points={{-119,-100},{-106,-100}},
                                                  color={0,0,127}));
  connect(occSch.y, occFra.u)
    annotation (Line(points={{-119,130},{-108,130}},
                                                   color={0,0,127}));
  connect(occFra.y, intOccCor.u) annotation (Line(points={{-85,130},{-70,130},{
          -70,162},{-62,162}}, color={0,0,127}));
  connect(occFra.y, intOccWes.u)
    annotation (Line(points={{-85,130},{-62,130}}, color={0,0,127}));
  connect(ligFra.y, intLigCor.u) annotation (Line(points={{-85,-20},{-72,-20},{
          -72,60},{-62,60}}, color={0,0,127}));
  connect(intOccCor.y, totGaiCor.u1) annotation (Line(points={{-39,162},{0,162},
          {0,88},{38,88}},    color={0,0,127}));
  connect(ligFra.y, intLigSou.u) annotation (Line(points={{-85,-20},{-72,-20},{
          -72,30},{-62,30}}, color={0,0,127}));
  connect(ligFra.y, intLigEas.u) annotation (Line(points={{-85,-20},{-72,-20},{
          -72,0},{-62,0}}, color={0,0,127}));
  connect(ligFra.y, intLigNor.u) annotation (Line(points={{-85,-20},{-72,-20},{
          -72,-30},{-62,-30}}, color={0,0,127}));
  connect(ligFra.y, intLigWes.u) annotation (Line(points={{-85,-20},{-72,-20},{
          -72,-58},{-62,-58}}, color={0,0,127}));
  connect(intLigCor.y, totGaiCor.u2) annotation (Line(points={{-39,60},{-20,60},
          {-20,80},{38,80}},color={0,0,127}));
  connect(eqiFra.y, intEquCor.u) annotation (Line(points={{-83,-100},{-72,-100},
          {-72,-90},{-62,-90}}, color={0,0,127}));
  connect(eqiFra.y, intEquSou.u) annotation (Line(points={{-83,-100},{-72,-100},
          {-72,-120},{-62,-120}}, color={0,0,127}));
  connect(eqiFra.y, intEquEas.u) annotation (Line(points={{-83,-100},{-72,-100},
          {-72,-150},{-62,-150}}, color={0,0,127}));
  connect(eqiFra.y, intEquWes.u) annotation (Line(points={{-83,-100},{-72,-100},
          {-72,-180},{-62,-180}}, color={0,0,127}));
  connect(intEquCor.y, totGaiCor.u3) annotation (Line(points={{-39,-90},{0,-90},
          {0,72},{38,72}},    color={0,0,127}));
  connect(occSchSou.y, occFra1.u)
    annotation (Line(points={{-119,90},{-108,90}},
                                                 color={0,0,127}));
  connect(occFra1.y, intOccEas.u)
    annotation (Line(points={{-85,90},{-62,90}}, color={0,0,127}));
  connect(intEquWes.y, totGaiWes.u3) annotation (Line(points={{-39,-180},{20,
          -180},{20,-158},{38,-158}}, color={0,0,127}));
  connect(intLigWes.y, totGaiWes.u2) annotation (Line(points={{-39,-58},{-20,
          -58},{-20,-150},{38,-150}},
                               color={0,0,127}));
  connect(intOccWes.y, totGaiWes.u1) annotation (Line(points={{-39,130},{-6,130},
          {-6,-142},{38,-142}}, color={0,0,127}));
  connect(totGaiWes.y, yGaiWes)
    annotation (Line(points={{61,-150},{130,-150}}, color={0,0,127}));
  connect(intOccEas.y, totGaiEas.u1) annotation (Line(points={{-39,90},{12,90},
          {12,-12},{38,-12}}, color={0,0,127}));
  connect(intLigEas.y, totGaiEas.u2) annotation (Line(points={{-39,0},{-20,0},{
          -20,-20},{38,-20}},
                          color={0,0,127}));
  connect(intEquEas.y, totGaiEas.u3) annotation (Line(points={{-39,-150},{-32,
          -150},{-32,-28},{38,-28}}, color={0,0,127}));
  connect(totGaiSou.y, yGaiSou)
    annotation (Line(points={{61,30},{130,30}}, color={0,0,127}));
  connect(intLigSou.y, totGaiSou.u1) annotation (Line(points={{-39,30},{20,30},
          {20,36},{38,36}}, color={0,0,127}));
  connect(intEquSou.y, totGaiSou.u2) annotation (Line(points={{-39,-120},{20,
          -120},{20,24},{38,24}}, color={0,0,127}));
  connect(intLigNor.y, yGaiNor) annotation (Line(points={{-39,-30},{-36,-30},{
          -36,-50},{62,-50},{62,-90},{130,-90}}, color={0,0,127}));
  connect(totGaiCor.y, yGaiCor)
    annotation (Line(points={{61,80},{130,80}}, color={0,0,127}));
  connect(totGaiEas.y, yGaiEas)
    annotation (Line(points={{61,-20},{130,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          lineColor={0,0,255})}),         Diagram(coordinateSystem(extent={{
            -160,-200},{120,180}})));
end GainSchedule3;
