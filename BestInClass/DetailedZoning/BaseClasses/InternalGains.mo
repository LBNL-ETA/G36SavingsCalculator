within BestInClass.DetailedZoning.BaseClasses;
block InternalGains "Internal heat gains"
  parameter Real kLig = 1;
  parameter Real kEqu = 1;
  parameter String peoFile "People load schedule file";
  parameter String ligFile "Lighting load schedule file";
  parameter String equFile "Equipment load schedule file";

  Modelica.Blocks.Sources.CombiTimeTable people(
    tableOnFile=true,
    tableName="people",
    fileName=Modelica.Utilities.Files.loadResource(peoFile),
    columns=2:22,
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    y(each unit="W/m2"))
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Interfaces.RealOutput qGaiFlo[3,21] annotation (Placement(
        transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={
            {100,-10},{120,10}})));
  Modelica.Blocks.Sources.CombiTimeTable lights(
    tableOnFile=true,
    tableName="lights",
    fileName=Modelica.Utilities.Files.loadResource(ligFile),
    columns=2:22,
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    y(each unit="W/m2"))
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.CombiTimeTable equipment(
    tableOnFile=true,
    tableName="equipment",
    fileName=Modelica.Utilities.Files.loadResource(equFile),
    columns=2:22,
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    y(each unit="W/m2"))
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));

  Modelica.Blocks.Math.Add3 totRadGai[21]
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Blocks.Math.Gain gaiRadPeo[21](each k=0.3)
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  Modelica.Blocks.Math.Gain gaiConPeo[21](each k=0.4)
    annotation (Placement(transformation(extent={{0,38},{20,58}})));
  Modelica.Blocks.Math.Gain gaiLatPeo[21](each k=0.3)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Modelica.Blocks.Math.Gain gaiRadLig[21](each k=0.7)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Math.Gain gaiConLig[21](each k=0.3)
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Math.Gain gaiRadEqu[21](each k=0.5)
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  Modelica.Blocks.Math.Add3 totConGai[21]
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  Modelica.Blocks.Math.Gain denRatLig[21](each k=kLig)
    "Density ratio of design lighting load"
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Blocks.Math.Gain denRatEqu[21](each k=kEqu)
    "Density ratio of design equipment load"
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
equation
  connect(people.y, gaiRadPeo.u) annotation (Line(points={{-59,60},{-52,60},{-52,
          80},{-2,80}},  color={0,0,127}));
  connect(gaiRadPeo.y, totRadGai.u1) annotation (Line(points={{21,80},{40,80},{40,
          68},{58,68}}, color={0,0,127}));
  connect(gaiRadLig.y, totRadGai.u2) annotation (Line(points={{21,-10},{40,-10},
          {40,60},{58,60}},color={0,0,127}));
  connect(gaiRadEqu.y, totRadGai.u3) annotation (Line(points={{21,-70},{48,-70},
          {48,52},{58,52}},color={0,0,127}));
  connect(people.y, gaiConPeo.u) annotation (Line(points={{-59,60},{-52,60},{-52,
          48},{-2,48}},  color={0,0,127}));
  connect(gaiConPeo.y, totConGai.u1) annotation (Line(points={{21,48},{32,48},{32,
          -32},{58,-32}},    color={0,0,127}));
  connect(gaiConLig.y, totConGai.u2)
    annotation (Line(points={{21,-40},{58,-40}},  color={0,0,127}));
  connect(gaiRadEqu.y, totConGai.u3) annotation (Line(points={{21,-70},{48,-70},
          {48,-48},{58,-48}},color={0,0,127}));
  connect(people.y, gaiLatPeo.u) annotation (Line(points={{-59,60},{-52,60},{-52,
          20},{-2,20}},  color={0,0,127}));
  connect(totRadGai.y, qGaiFlo[1, :]) annotation (Line(points={{81,60},{90,60},{
          90,0},{110,0}},  color={0,0,127}));
  connect(totConGai.y, qGaiFlo[2, :]) annotation (Line(points={{81,-40},{90,-40},
          {90,0},{110,0}}, color={0,0,127}));
  connect(gaiLatPeo.y, qGaiFlo[3, :]) annotation (Line(points={{21,20},{80,20},{
          80,0},{110,0}},  color={0,0,127}));
  connect(lights.y, denRatLig.u) annotation (Line(points={{-59,0},{-48,0},{-48,-10},
          {-42,-10}}, color={0,0,127}));
  connect(denRatLig.y, gaiRadLig.u)
    annotation (Line(points={{-19,-10},{-2,-10}}, color={0,0,127}));
  connect(denRatLig.y, gaiConLig.u) annotation (Line(points={{-19,-10},{-14,-10},
          {-14,-40},{-2,-40}}, color={0,0,127}));
  connect(equipment.y, denRatEqu.u)
    annotation (Line(points={{-59,-60},{-42,-60}}, color={0,0,127}));
  connect(denRatEqu.y, gaiRadEqu.u) annotation (Line(points={{-19,-60},{-10,-60},
          {-10,-70},{-2,-70}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Text(
          extent={{-90,48},{90,-48}},
          lineColor={28,108,200},
          textString="IntGai")}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=604800, __Dymola_Algorithm="Dassl"));
end InternalGains;
