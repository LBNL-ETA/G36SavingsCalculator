within BestInClass.FiveZone.OpenLoop;
model RefBldgMediumOffice
  "Validation model for six zones small office building"
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Air "Medium model";
  parameter Modelica.SIunits.Angle lat=41.98*3.14159/180 "Latitude";

  inner Buildings.ThermalZones.EnergyPlus.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "/home/kun/Documents/bic-savcal36/energyplus/idf/RefBldgMediumOfficeNew2004_Chicago_noIGnoInfnoWin.idf"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
    fmuName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/src/EnergyPlus/FMUs/Zones1.fmu"))
    "Building model"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  Modelica.Blocks.Sources.Constant qConGai_flow(k=0) "Convective heat gain"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Constant qRadGai_flow(k=0) "Radiative heat gain"
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Blocks.Routing.Multiplex3 mul "Multiplex for gains"
    annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
  Modelica.Blocks.Sources.Constant qLatGai_flow(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Buildings.ThermalZones.EnergyPlus.ThermalZone cor(redeclare package Medium =
        Medium, zoneName="Core_mid",
    T_start=274.85)                  "Thermal zone"
    annotation (Placement(transformation(extent={{20,68},{60,108}})));
  Buildings.ThermalZones.EnergyPlus.ThermalZone sou(redeclare package Medium =
        Medium, zoneName="Perimeter_mid_ZN_1",
    T_start=274.85)                            "Thermal zone"
    annotation (Placement(transformation(extent={{20,10},{60,50}})));
  Buildings.ThermalZones.EnergyPlus.ThermalZone eas(redeclare package Medium =
        Medium, zoneName="Perimeter_mid_ZN_2",
    T_start=274.85)                            "Thermal zone"
    annotation (Placement(transformation(extent={{20,-50},{60,-10}})));
  Buildings.ThermalZones.EnergyPlus.ThermalZone nor(redeclare package Medium =
        Medium, zoneName="Perimeter_mid_ZN_3",
    T_start=274.85)                            "Thermal zone"
    annotation (Placement(transformation(extent={{20,-104},{60,-64}})));
  Buildings.ThermalZones.EnergyPlus.ThermalZone wes(redeclare package Medium =
        Medium, zoneName="Perimeter_mid_ZN_4",
    T_start=274.85)                            "Thermal zone"
    annotation (Placement(transformation(extent={{20,-156},{60,-116}})));
  Modelica.Blocks.Sources.CombiTimeTable datRea(
    tableOnFile=true,
    fileName=Modelica.Utilities.Files.loadResource(
        "/home/kun/Documents/bic-savcal36/energyplus/idf/RefBldgMediumOfficeNew2004_Chicago_noIGnoInfnoWin.dat"),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    tableName="EnergyPlus",
    columns=2:7,
    y(each unit="K", each displayUnit="degC"),
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    "Data reader with results from EnergyPlus"
    annotation (Placement(transformation(extent={{-100,-120},{-80,-100}})));

equation
  connect(qRadGai_flow.y, mul.u1[1]) annotation (Line(
      points={{-79,40},{-60,40},{-60,7},{-50,7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow.y, mul.u2[1]) annotation (Line(
      points={{-79,0},{-50,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mul.u3[1], qLatGai_flow.y) annotation (Line(points={{-50,-7},{-60,-7},
          {-60,-40},{-79,-40}}, color={0,0,127}));
  connect(cor.qGai_flow, mul.y)
    annotation (Line(points={{18,98},{-20,98},{-20,0},{-27,0}},
                                                           color={0,0,127}));
  connect(mul.y, sou.qGai_flow)
    annotation (Line(points={{-27,0},{0,0},{0,40},{18,40}},  color={0,0,127}));
  connect(eas.qGai_flow, mul.y) annotation (Line(points={{18,-20},{0,-20},{0,0},
          {-27,0}},color={0,0,127}));
  connect(nor.qGai_flow, mul.y)
    annotation (Line(points={{18,-74},{-20,-74},{-20,0},{-27,0}},
                                                             color={0,0,127}));
  connect(mul.y, wes.qGai_flow) annotation (Line(points={{-27,0},{-20,0},{-20,
          -126},{18,-126}},
                     color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Validation of free floating temperatures.
The model uses the small office building of the DOE Reference Buildings.
The Modelica model is in free floating mode, and the data reader <code>datRea</code>
outputs, for comparison, the free floating room temperatures that were
obtained from an EnergyPlus simulation.
</p>
</html>", revisions="<html>
<ul><li>
February 14, 2018, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
 __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus/Validation/RefBldgSmallOffice.mos"
        "Simulate and plot"),
experiment(
      StopTime=5184000,
      Interval=600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-140,-160},{140,120}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end RefBldgMediumOffice;
