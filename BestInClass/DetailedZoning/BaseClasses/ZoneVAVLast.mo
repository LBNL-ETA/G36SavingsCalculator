within BestInClass.DetailedZoning.BaseClasses;
model ZoneVAVLast "Base class with a zone and a VAV box without splitters"
  package MediumA = Buildings.Media.Air "Medium air";
  package MediumW = Buildings.Media.Water "Medium water";
  parameter String zoneName "Thermal zone name from EnergyPlus";
  parameter Modelica.SIunits.MassFlowRate mRoo_flow_nominal
    "Nominal mass flowrate of the thermal zone";
  parameter Modelica.SIunits.Volume VRoo "Room volumn";
  parameter Boolean allowFlowReversal
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Evaluate=true);

  Buildings.ThermalZones.EnergyPlus.ThermalZone zon(
    redeclare package Medium = MediumA,
    zoneName=zoneName,
    nPorts=2) "Thermal zone"
    annotation (Placement(transformation(extent={{-40,80},{0,120}})));

  Buildings.Fluid.Sensors.VolumeFlowRate VSupRoo_flow(
    redeclare package Medium = MediumA,
    initType=Modelica.Blocks.Types.Init.InitialState,
    m_flow_nominal=mRoo_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Discharge air flow rate" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,10})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TSupRoo(
    redeclare package Medium = MediumA,
    initType=Modelica.Blocks.Types.Init.InitialState,
    m_flow_nominal=mRoo_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Discharge air temperature"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-20})));
  Buildings.Examples.VAVReheat.ThermalZones.VAVBranch VAVbox(
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW,
    m_flow_nominal=mRoo_flow_nominal,
    VRoo=VRoo,
    allowFlowReversal=allowFlowReversal) "VAV box"
    annotation (Placement(transformation(extent={{-40,-88},{0,-48}})));
  Modelica.Blocks.Interfaces.RealInput TRooHeaSet annotation (Placement(
        transformation(extent={{-140,-10},{-100,30}}),iconTransformation(extent={{-120,10},
            {-100,30}})));
  Modelica.Blocks.Interfaces.RealInput minAirFra annotation (Placement(
        transformation(extent={{-140,-68},{-100,-28}}), iconTransformation(
          extent={{-120,-48},{-100,-28}})));
  Modelica.Blocks.Interfaces.RealOutput TAir
    annotation (Placement(transformation(extent={{100,20},{120,40}}),
        iconTransformation(extent={{100,20},{120,40}})));
  Controls.RoomVAV3 conVAVRoo
                             "Controller for terminal unit for the room"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Interfaces.RealInput TRooCooSet annotation (Placement(
        transformation(extent={{-140,-40},{-100,0}}),  iconTransformation(
          extent={{-120,-20},{-100,0}})));
  Modelica.Fluid.Interfaces.FluidPort_b returnAir(redeclare final package
      Medium = MediumA)  "Return air"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}}),
        iconTransformation(extent={{-110,-90},{-90,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_a supplyAir1(redeclare final package
      Medium = MediumA)  "Supply air"
    annotation (Placement(transformation(extent={{-110,70},{-90,90}}),
        iconTransformation(extent={{-110,70},{-90,90}})));
  Modelica.Blocks.Interfaces.RealOutput yVavAct
    "VAV box acutal damper position" annotation (Placement(transformation(
          extent={{100,-40},{120,-20}}), iconTransformation(extent={{100,-40},{
            120,-20}})));
  Modelica.Blocks.Interfaces.RealInput qGai_flow[3](each unit="W/m2")
    "Radiant, convective and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-120,40},{-100,60}})));
equation
  connect(VSupRoo_flow.port_b, zon.ports[1]) annotation (Line(points={{-30,20},{
          -30,80},{-22,80},{-22,80.9}},
                                  color={0,127,255}));
  connect(TSupRoo.port_b, VSupRoo_flow.port_a)   annotation (Line(points={{-30,-10},{-30,0}},color={0,127,255}));
  connect(TSupRoo.port_a, VAVbox.port_b)   annotation (Line(points={{-30,-30},{-30,-48}}, color={0,127,255}));
  connect(zon.TAir, TAir) annotation (Line(points={{1,113.8},{80,113.8},{80,30},
          {110,30}},color={0,0,127}));
  connect(conVAVRoo.yVal, VAVbox.yVal) annotation (Line(points={{-59,-75},{-54,
          -75},{-54,-76},{-44,-76}}, color={0,0,127}));
  connect(conVAVRoo.yDam, VAVbox.yVAV) annotation (Line(points={{-59,-65.2},{-56,
          -65.2},{-56,-60},{-44,-60}},
                                     color={0,0,127}));
  connect(conVAVRoo.TRoo, TAir) annotation (Line(points={{-81,-73},{-84,-73},{
          -84,-100},{80,-100},{80,30},{110,30}},color={0,0,127}));
  connect(TRooHeaSet, conVAVRoo.TRooHeaSet) annotation (Line(points={{-120,10},
          {-84,10},{-84,-62},{-82,-62}}, color={0,0,127}));
  connect(TRooCooSet, conVAVRoo.TRooCooSet) annotation (Line(points={{-120,-20},
          {-86,-20},{-86,-66},{-82,-66}}, color={0,0,127}));
  connect(returnAir, returnAir) annotation (Line(points={{-100,-80},{-100,-80},
          {-98,-80},{-98,-80},{-100,-80},{-100,-80}}, color={0,127,255}));
  connect(returnAir, VAVbox.port_a) annotation (Line(points={{-100,-80},{-100,-110},
          {-30,-110},{-30,-88}}, color={0,127,255}));
  connect(zon.ports[2], supplyAir1) annotation (Line(points={{-18,80.9},{-18,72},
          {-60,72},{-60,80},{-100,80}}, color={0,127,255}));
  connect(qGai_flow, zon.qGai_flow) annotation (Line(points={{-120,60},{-74,60},
          {-74,110},{-42,110}}, color={0,0,127}));
  connect(VAVbox.y_actual,yVavAct)  annotation (Line(points={{2,-52},{52,-52},{
          52,-30},{110,-30}}, color={0,0,127}));
  connect(minAirFra, conVAVRoo.minFloCoo) annotation (Line(points={{-120,-48},{
          -88,-48},{-88,-78},{-82,-78}}, color={0,0,127}));
  annotation (Icon(                                             graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}),                        Diagram(
        coordinateSystem(extent={{-100,-140},{100,140}})));
end ZoneVAVLast;
