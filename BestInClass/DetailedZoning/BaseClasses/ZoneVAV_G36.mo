within BestInClass.DetailedZoning.BaseClasses;
model ZoneVAV_G36 "Base class with a zone and a VAV box"
  package MediumA = Buildings.Media.Air "Medium air";
  package MediumW = Buildings.Media.Water "Medium water";
  parameter String zoneName "Thermal zone name from EnergyPlus";
  parameter Modelica.SIunits.MassFlowRate mRoo_flow_nominal
    "Nominal mass flowrate of the thermal zone";
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_nominal
    "Nominal mass flowrate in the splitter";
  parameter Modelica.SIunits.VolumeFlowRate VRoo_flow_nominal=mRoo_flow_nominal/1.2;
  parameter Modelica.SIunits.VolumeFlowRate VDisSetMin_flow;
  parameter Modelica.SIunits.Volume VRoo "Room volumn";
  parameter Modelica.SIunits.Area AFlo "Room area";
  parameter Modelica.SIunits.Time samplePeriod=120;
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
  Buildings.Fluid.FixedResistances.Junction splSupRoo(
    redeclare package Medium = MediumA,
    m_flow_nominal={mSpl_flow_nominal + mRoo_flow_nominal,mSpl_flow_nominal,
        mRoo_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving)
    "Splitter for room supply"
    annotation (Placement(transformation(extent={{-40,-110},{-20,-130}})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo(
    redeclare package Medium = MediumA,
    m_flow_nominal={mSpl_flow_nominal+mRoo_flow_nominal,mSpl_flow_nominal,
        mRoo_flow_nominal},
    from_dp=false,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return"
    annotation (Placement(transformation(extent={{20,58},{0,38}})));
  Modelica.Blocks.Interfaces.RealInput TRooHeaSet annotation (Placement(
        transformation(extent={{-140,20},{-100,60}}), iconTransformation(extent={{-120,40},
            {-100,60}})));
  Modelica.Blocks.Interfaces.RealOutput TDis "Discharge air temperature"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
  Buildings.Controls.OBC.ASHRAE.G36_PR1.TerminalUnits.Controller conVAVRoo(
    final AFlo=AFlo,
    final V_flow_nominal=VRoo_flow_nominal,
    final samplePeriod=samplePeriod,
    final VDisSetMin_flow=VDisSetMin_flow,
    VDisHeaSetMax_flow=0.5*VRoo_flow_nominal)
    "Controller for terminal unit for the room"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Interfaces.RealInput TRooCooSet annotation (Placement(
        transformation(extent={{-140,-10},{-100,30}}), iconTransformation(
          extent={{-120,10},{-100,30}})));
  Modelica.Fluid.Interfaces.FluidPort_a supplyAir(redeclare final package
      Medium = MediumA)  "Supply air"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}}),
        iconTransformation(extent={{90,-90},{110,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_b returnAir(redeclare final package
      Medium = MediumA)  "Return air"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}}),
        iconTransformation(extent={{-110,-90},{-90,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_b returnAir1(redeclare final package
      Medium = MediumA)  "Return air"
    annotation (Placement(transformation(extent={{90,70},{110,90}}),
        iconTransformation(extent={{90,70},{110,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a supplyAir1(redeclare final package
      Medium = MediumA)  "Supply air"
    annotation (Placement(transformation(extent={{-110,70},{-90,90}}),
        iconTransformation(extent={{-110,70},{-90,90}})));
  Modelica.Blocks.Interfaces.RealOutput VDis "Discharge air flowrate"
    annotation (Placement(transformation(extent={{100,16},{120,36}}),
        iconTransformation(extent={{100,16},{120,36}})));
  Modelica.Blocks.Interfaces.RealInput TSupAHU "Supply air temperature"
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}}),
        iconTransformation(extent={{-120,-30},{-100,-10}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uOpeMod
    "Zone operation mode"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}}),
        iconTransformation(extent={{-140,-70},{-100,-30}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yZonTemResReq
    "Zone cooling supply air temperature reset request"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}}),
        iconTransformation(extent={{100,-46},{140,-6}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yZonPreResReq
    "Zone static pressure reset requests"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}}),
        iconTransformation(extent={{100,-70},{140,-30}})));
  Modelica.Blocks.Interfaces.RealOutput TRooAir "Zone air temperature"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealInput qGai_flow[3](each unit="W/m2")
    "Radiant, convective and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-140,50},{-100,90}}),
        iconTransformation(extent={{-120,40},{-100,60}})));
equation
  connect(VSupRoo_flow.port_b, zon.ports[1]) annotation (Line(points={{-30,20},
          {-30,80},{-22,80},{-22,80.9}},
                                  color={0,127,255}));
  connect(splRetRoo.port_3, zon.ports[2]) annotation (Line(points={{10,58},{10,
          70},{-18,70},{-18,80.9}}, color={0,127,255}));
  connect(splSupRoo.port_3, VAVbox.port_a) annotation (Line(
      points={{-30,-110},{-30,-88}},
      color={0,127,255},
      thickness=0.5));
  connect(TSupRoo.port_b, VSupRoo_flow.port_a)   annotation (Line(points={{-30,-10},{-30,0}},color={0,127,255}));
  connect(TSupRoo.port_a, VAVbox.port_b)   annotation (Line(points={{-30,-30},{-30,-48}}, color={0,127,255}));
  connect(conVAVRoo.yVal, VAVbox.yVal) annotation (Line(points={{-58,-69},{-54,-69},
          {-54,-76},{-44,-76}},      color={0,0,127}));
  connect(conVAVRoo.yDam, VAVbox.yVAV) annotation (Line(points={{-58,-64},{-56,-64},
          {-56,-60},{-44,-60}},      color={0,0,127}));
  connect(splSupRoo.port_2, supplyAir) annotation (Line(points={{-20,-120},{40,
          -120},{40,-80},{100,-80}}, color={0,127,255}));
  connect(returnAir, returnAir) annotation (Line(points={{-100,-80},{-100,-80},
          {-98,-80},{-98,-80},{-100,-80},{-100,-80}}, color={0,127,255}));
  connect(returnAir, splSupRoo.port_1) annotation (Line(points={{-100,-80},{-94,
          -80},{-94,-120},{-40,-120}}, color={0,127,255}));
  connect(splRetRoo.port_1, returnAir1) annotation (Line(points={{20,48},{60,48},
          {60,80},{100,80}}, color={0,127,255}));
  connect(supplyAir1, splRetRoo.port_2) annotation (Line(points={{-100,80},{-50,
          80},{-50,48},{0,48}}, color={0,127,255}));
  connect(conVAVRoo.VDis_flow, VSupRoo_flow.V_flow) annotation (Line(points={{-82,-72},
          {-86,-72},{-86,10},{-41,10}},      color={0,0,127}));
  connect(TSupRoo.T, conVAVRoo.TDis) annotation (Line(points={{-41,-20},{-86,
          -20},{-86,-76},{-82,-76}},
                                color={0,0,127}));
  connect(TRooHeaSet, conVAVRoo.TZonHeaSet) annotation (Line(points={{-120,40},
          {-94,40},{-94,-60},{-82,-60}},color={0,0,127}));
  connect(TRooCooSet, conVAVRoo.TZonCooSet) annotation (Line(points={{-120,10},
          {-96,10},{-96,-62},{-82,-62}},color={0,0,127}));
  connect(TSupAHU, conVAVRoo.TSupAHU) annotation (Line(points={{-120,-30},{-90,
          -30},{-90,-78},{-82,-78}},
                                color={0,0,127}));
  connect(uOpeMod, conVAVRoo.uOpeMod) annotation (Line(points={{-120,-50},{-84,
          -50},{-84,-80},{-82,-80}},
                                color={255,127,0}));
  connect(conVAVRoo.yZonTemResReq, yZonTemResReq) annotation (Line(points={{-58,
          -74},{-54,-74},{-54,-92},{20,-92},{20,-20},{110,-20}}, color={255,127,
          0}));
  connect(yZonPreResReq, yZonPreResReq)
    annotation (Line(points={{110,-60},{110,-60}}, color={255,127,0}));
  connect(conVAVRoo.yZonPreResReq, yZonPreResReq) annotation (Line(points={{-58,
          -78},{-56,-78},{-56,-94},{26,-94},{26,-60},{110,-60}}, color={255,127,
          0}));
  connect(conVAVRoo.TZon, zon.TAir) annotation (Line(points={{-82,-70},{-84,-70},
          {-84,-100},{24,-100},{24,113.8},{1,113.8}}, color={0,0,127}));
  connect(VSupRoo_flow.V_flow, VDis) annotation (Line(points={{-41,10},{-60,10},
          {-60,26},{110,26}}, color={0,0,127}));
  connect(TSupRoo.T, TDis) annotation (Line(points={{-41,-20},{-60,-20},{-60,0},
          {110,0}}, color={0,0,127}));
  connect(zon.TAir, TRooAir) annotation (Line(points={{1,113.8},{24,113.8},{24,40},
          {110,40}}, color={0,0,127}));
  connect(qGai_flow, zon.qGai_flow) annotation (Line(points={{-120,70},{-60,70},
          {-60,110},{-42,110}}, color={0,0,127}));
  connect(conVAVRoo.yDam_actual, VAVbox.y_actual) annotation (Line(points={{-82,
          -74},{-88,-74},{-88,-38},{8,-38},{8,-52},{2,-52}}, color={0,0,127}));
  annotation (Icon(                                             graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}),                        Diagram(
        coordinateSystem(extent={{-100,-140},{100,140}})));
end ZoneVAV_G36;
