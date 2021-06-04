within BestInClass.ThermalZones;
model InternalHeatGain
  Modelica.Blocks.Sources.CombiTimeTable profile1(
    table=[0,0.05; 8,0.05; 9,0.9; 12,0.9; 12,0.8; 13,0.8; 13,1; 17,1; 19,0.1;
        24,0.05],
    timeScale=3600,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Fraction of internal heat gain"
    annotation (Placement(transformation(extent={{-60,150},{-40,170}})));
  Modelica.Blocks.Continuous.Integrator integrator1(k=1/3600/1000)
    annotation (Placement(transformation(extent={{60,150},{80,170}})));
  Modelica.Blocks.Math.Gain gain[1](k=16)
    annotation (Placement(transformation(extent={{-20,150},{0,170}})));
  Modelica.Blocks.Math.Gain gain1[1](k=1662.66)
    annotation (Placement(transformation(extent={{20,150},{40,170}})));
  Modelica.Blocks.Math.Gain gain3[3](k=984.67)
    annotation (Placement(transformation(extent={{-20,110},{0,130}})));
  Modelica.Blocks.Math.Gain gain5[3](k=207.58)
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Modelica.Blocks.Math.Gain gain7[3](k=131.42)
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Modelica.Blocks.Math.Gain gain9[3](k=207.58)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Math.Gain gain11[3](k=131.42)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=5)
    annotation (Placement(transformation(extent={{70,64},{82,76}})));
  Modelica.Blocks.Continuous.Integrator integrator2(k=1/3600/1000)
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  BestInClass.ThermalZones.GainSchedule profile2
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Math.Sum sum1(nin=3, k={1,1,0})
    annotation (Placement(transformation(extent={{20,110},{40,130}})));
  Modelica.Blocks.Math.Sum sum2(nin=3, k={1,1,0})
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Modelica.Blocks.Math.Sum sum3(nin=3, k={1,1,0})
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Modelica.Blocks.Math.Sum sum4(nin=3, k={1,1,0})
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Math.Sum sum5(nin=3, k={1,1,0})
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Math.Gain gain2[3](k=984.67)
    annotation (Placement(transformation(extent={{-20,-46},{0,-26}})));
  Modelica.Blocks.Math.Gain gain4[3](k=207.58)
    annotation (Placement(transformation(extent={{-20,-76},{0,-56}})));
  Modelica.Blocks.Math.Gain gain6[3](k=131.42)
    annotation (Placement(transformation(extent={{-20,-106},{0,-86}})));
  Modelica.Blocks.Math.Gain gain8[3](k=207.58)
    annotation (Placement(transformation(extent={{-20,-136},{0,-116}})));
  Modelica.Blocks.Math.Gain gain10[3](k=131.42)
    annotation (Placement(transformation(extent={{-20,-166},{0,-146}})));
  Modelica.Blocks.Math.MultiSum multiSum1(nu=5)
    annotation (Placement(transformation(extent={{70,-92},{82,-80}})));
  Modelica.Blocks.Continuous.Integrator integrator3(k=1/3600/1000)
    annotation (Placement(transformation(extent={{100,-96},{120,-76}})));
  Modelica.Blocks.Math.Sum sum6(nin=3, k={1,1,0})
    annotation (Placement(transformation(extent={{20,-46},{40,-26}})));
  Modelica.Blocks.Math.Sum sum7(nin=3, k={1,1,0})
    annotation (Placement(transformation(extent={{20,-76},{40,-56}})));
  Modelica.Blocks.Math.Sum sum8(nin=3, k={1,1,0})
    annotation (Placement(transformation(extent={{20,-106},{40,-86}})));
  Modelica.Blocks.Math.Sum sum9(nin=3, k={1,1,0})
    annotation (Placement(transformation(extent={{20,-136},{40,-116}})));
  Modelica.Blocks.Math.Sum sum10(nin=3, k={1,1,0})
    annotation (Placement(transformation(extent={{20,-166},{40,-146}})));
  BestInClass.ThermalZones.GainSchedule3 profile3
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
equation
  connect(profile1.y, gain.u)
    annotation (Line(points={{-39,160},{-22,160}}, color={0,0,127}));
  connect(gain.y, gain1.u)
    annotation (Line(points={{1,160},{18,160}}, color={0,0,127}));
  connect(gain1[1].y, integrator1.u)
    annotation (Line(points={{41,160},{58,160}}, color={0,0,127}));
  connect(profile2.yGaiCor, gain3.u) annotation (Line(points={{-59,88},{-40,88},
          {-40,120},{-22,120}}, color={0,0,127}));
  connect(profile2.yGaiSou, gain5.u) annotation (Line(points={{-59,84},{-28,84},
          {-28,90},{-22,90}}, color={0,0,127}));
  connect(profile2.yGaiEas, gain7.u) annotation (Line(points={{-59,80},{-28,80},
          {-28,60},{-22,60}}, color={0,0,127}));
  connect(profile2.yGaiNor, gain9.u) annotation (Line(points={{-59,76},{-34,76},
          {-34,30},{-22,30}}, color={0,0,127}));
  connect(profile2.yGaiWes, gain11.u) annotation (Line(points={{-59,72},{-40,72},
          {-40,0},{-22,0}}, color={0,0,127}));
  connect(multiSum.y, integrator2.u)
    annotation (Line(points={{83.02,70},{98,70}}, color={0,0,127}));
  connect(gain3.y, sum1.u)
    annotation (Line(points={{1,120},{18,120}}, color={0,0,127}));
  connect(gain5.y, sum2.u)
    annotation (Line(points={{1,90},{18,90}}, color={0,0,127}));
  connect(gain11.y, sum5.u)
    annotation (Line(points={{1,0},{18,0}}, color={0,0,127}));
  connect(gain9.y, sum4.u)
    annotation (Line(points={{1,30},{18,30}}, color={0,0,127}));
  connect(gain7.y, sum3.u)
    annotation (Line(points={{1,60},{18,60}}, color={0,0,127}));
  connect(sum1.y, multiSum.u[1]) annotation (Line(points={{41,120},{58,120},{58,
          73.36},{70,73.36}}, color={0,0,127}));
  connect(sum2.y, multiSum.u[2]) annotation (Line(points={{41,90},{58,90},{58,
          71.68},{70,71.68}}, color={0,0,127}));
  connect(sum3.y, multiSum.u[3]) annotation (Line(points={{41,60},{58,60},{58,
          70},{70,70},{70,70}}, color={0,0,127}));
  connect(sum4.y, multiSum.u[4]) annotation (Line(points={{41,30},{60,30},{60,
          68.32},{70,68.32}}, color={0,0,127}));
  connect(sum5.y, multiSum.u[5]) annotation (Line(points={{41,0},{60,0},{60,
          66.64},{70,66.64}}, color={0,0,127}));
  connect(multiSum1.y, integrator3.u)
    annotation (Line(points={{83.02,-86},{98,-86}}, color={0,0,127}));
  connect(gain2.y, sum6.u)
    annotation (Line(points={{1,-36},{18,-36}}, color={0,0,127}));
  connect(gain4.y, sum7.u)
    annotation (Line(points={{1,-66},{18,-66}}, color={0,0,127}));
  connect(gain10.y, sum10.u)
    annotation (Line(points={{1,-156},{18,-156}}, color={0,0,127}));
  connect(gain8.y, sum9.u)
    annotation (Line(points={{1,-126},{18,-126}}, color={0,0,127}));
  connect(gain6.y, sum8.u)
    annotation (Line(points={{1,-96},{18,-96}}, color={0,0,127}));
  connect(sum6.y, multiSum1.u[1]) annotation (Line(points={{41,-36},{58,-36},{
          58,-82.64},{70,-82.64}}, color={0,0,127}));
  connect(sum7.y, multiSum1.u[2]) annotation (Line(points={{41,-66},{58,-66},{
          58,-84.32},{70,-84.32}}, color={0,0,127}));
  connect(sum8.y, multiSum1.u[3]) annotation (Line(points={{41,-96},{58,-96},{
          58,-86},{70,-86}}, color={0,0,127}));
  connect(sum9.y, multiSum1.u[4]) annotation (Line(points={{41,-126},{60,-126},
          {60,-87.68},{70,-87.68}}, color={0,0,127}));
  connect(sum10.y, multiSum1.u[5]) annotation (Line(points={{41,-156},{60,-156},
          {60,-89.36},{70,-89.36}}, color={0,0,127}));
  connect(profile3.yGaiCor, gain2.u) annotation (Line(points={{-59,-62},{-40,
          -62},{-40,-36},{-22,-36}}, color={0,0,127}));
  connect(profile3.yGaiSou, gain4.u)
    annotation (Line(points={{-59,-66},{-22,-66}}, color={0,0,127}));
  connect(profile3.yGaiEas, gain6.u) annotation (Line(points={{-59,-70},{-40,
          -70},{-40,-96},{-22,-96}}, color={0,0,127}));
  connect(profile3.yGaiNor, gain8.u) annotation (Line(points={{-59,-74},{-40,
          -74},{-40,-126},{-22,-126}}, color={0,0,127}));
  connect(profile3.yGaiWes, gain10.u) annotation (Line(points={{-59,-78},{-40,
          -78},{-40,-156},{-22,-156}}, color={0,0,127}));
  annotation (uses(Modelica(version="3.2.2")), Diagram(coordinateSystem(extent=
            {{-100,-180},{140,180}})),
    Icon(graphics={             Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}));
end InternalHeatGain;
