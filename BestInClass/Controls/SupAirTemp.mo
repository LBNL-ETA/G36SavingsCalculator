within BestInClass.Controls;
block SupAirTemp "Supply air temperature setpoint"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Temperature TOutLow
    "Outdoor temperature at the low bound";
  parameter Modelica.SIunits.Temperature TOutHigh
    "Outdoor temperature at the high bound";
  parameter Modelica.SIunits.Temperature TSupSetCooLow
    "Cooling supply air temperature at the low bound";
  parameter Modelica.SIunits.Temperature TSupSetCooHigh
    "Cooling supply air temperature at the high bound";
  Modelica.Blocks.Sources.Constant x1(k=TOutLow)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Sources.Constant f1(k=TSupSetCooHigh)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Constant x2(k=TOutHigh)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Constant f2(k=TSupSetCooLow)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Buildings.Controls.OBC.CDL.Continuous.Line lin
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Interfaces.RealInput TOut(unit="K", displayUnit="degC")
                        "Outdoor air dry bulb temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-120,0},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput TSet(unit="K", displayUnit="degC")
                        "Temperature set point"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(x1.y, lin.x1) annotation (Line(points={{-39,70},{-16,70},{-16,18},
          {-2,18}},
                color={0,0,127}));
  connect(f1.y, lin.f1) annotation (Line(points={{-39,30},{-20,30},{-20,14},
          {-2,14}},
                color={0,0,127}));
  connect(x2.y, lin.x2) annotation (Line(points={{-39,-30},{-20,-30},{-20,6},
          {-2,6}},
        color={0,0,127}));
  connect(f2.y, lin.f2) annotation (Line(points={{-39,-70},{-16,-70},{-16,2},
          {-2,2}},
               color={0,0,127}));
  connect(TOut, lin.u) annotation (Line(points={{-120,0},{-62,0},{-62,10},{-2,10}},
                   color={0,0,127}));
  connect(lin.y, TSet) annotation (Line(points={{22,10},{60,10},{60,0},{110,0}},
               color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SupAirTemp;
