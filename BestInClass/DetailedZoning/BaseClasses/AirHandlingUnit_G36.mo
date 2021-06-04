within BestInClass.DetailedZoning.BaseClasses;
model AirHandlingUnit_G36 "Air handing system for VAV"

  package MediumA = Buildings.Media.Air;
  package MediumW = Buildings.Media.Water;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Norminal flowrate of the AHU system";
  parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal";
  parameter Modelica.SIunits.Temperature THeaOn
    "Heating on setpoint for room";
  parameter Modelica.SIunits.Temperature THeaOff
    "Heating off setpoint for room";
  parameter Modelica.SIunits.Temperature TCooOn
    "Cooling on setpoint for room";
  parameter Modelica.SIunits.Temperature TCooOff
    "Cooling off setpoint for room";
  parameter Modelica.SIunits.PressureDifference dpBuiStaSet
    "Building static pressure";

  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{-164,212},{-144,232}}),
        iconTransformation(extent={{-94,70},{-74,90}})));

  Modelica.Blocks.Interfaces.RealInput uOutDamPos
    "Outdoor damper position setpoint"
    annotation (Placement(transformation(extent={{-220,-94},{-180,-54}}),
        iconTransformation(extent={{-120,20},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput uHea "Heating coil control signal"
    annotation (Placement(transformation(extent={{-220,-210},{-180,-170}}),
        iconTransformation(extent={{-120,-40},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput uCoo "Cooling coil control signal"
    annotation (Placement(transformation(extent={{-220,-260},{-180,-220}}),
        iconTransformation(extent={{-120,-70},{-100,-50}})));
  Modelica.Blocks.Interfaces.RealInput uRetDamPos
    "Return damper position setpoint" annotation (Placement(transformation(
          extent={{-220,6},{-180,46}}), iconTransformation(extent={{-120,50},{
            -100,70}})));
  Modelica.Blocks.Interfaces.RealOutput TSupAHU(each unit="K", each displayUnit=
       "degC") "AHU supply air temperature" annotation (Placement(
        transformation(extent={{480,-90},{500,-70}}), iconTransformation(extent=
           {{100,-64},{120,-44}})));
  Modelica.Blocks.Interfaces.RealOutput TRetAHU(each unit="K", each displayUnit=
       "degC") "AHU return temperature" annotation (Placement(transformation(
          extent={{480,-200},{500,-180}}), iconTransformation(extent={{100,-6},
            {120,14}})));
  Modelica.Fluid.Interfaces.FluidPort_a supplyAir(redeclare final package
      Medium = MediumA) "Supply air"
    annotation (Placement(transformation(extent={{472,52},{492,72}}),
        iconTransformation(extent={{90,-92},{110,-72}})));
  Modelica.Fluid.Interfaces.FluidPort_b returnAir(redeclare final package
      Medium = MediumA) "Return air"
    annotation (Placement(transformation(extent={{472,232},{492,252}}),
        iconTransformation(extent={{90,70},{110,90}})));

  Modelica.Blocks.Interfaces.RealOutput dpFan
    "Supply fan static discharge pressure" annotation (Placement(transformation(
          extent={{480,130},{500,150}}), iconTransformation(extent={{100,20},{
            120,40}})));
  Buildings.Fluid.Sources.Outside amb(redeclare package Medium = MediumA,
      nPorts=3) "Ambient conditions"
    annotation (Placement(transformation(extent={{-130,46},{-108,68}})));
  Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU heaCoi(
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumA,
    m1_flow_nominal=m_flow_nominal*1000*(10 - (-20))/4200/10,
    m2_flow_nominal=m_flow_nominal,
    configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    Q_flow_nominal=m_flow_nominal*1006*(16.7 - 8.5),
    dp1_nominal=0,
    dp2_nominal=200 + 200 + 100 + 40,
    allowFlowReversal1=false,
    allowFlowReversal2=allowFlowReversal,
    T_a1_nominal=318.15,
    T_a2_nominal=281.65) "Heating coil"
    annotation (Placement(transformation(extent={{124,66},{104,46}})));

  Buildings.Fluid.HeatExchangers.WetCoilCounterFlow cooCoi(
    UA_nominal=3*m_flow_nominal*1000*15/
        Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(
        T_a1=26.2,
        T_b1=12.8,
        T_a2=6,
        T_b2=16),
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumA,
    m1_flow_nominal=m_flow_nominal*1000*15/4200/10,
    m2_flow_nominal=m_flow_nominal,
    dp2_nominal=0,
    dp1_nominal=0,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    allowFlowReversal1=false,
    allowFlowReversal2=allowFlowReversal) "Cooling coil"
    annotation (Placement(transformation(extent={{216,66},{196,46}})));
  Buildings.Fluid.FixedResistances.PressureDrop dpRetDuc(
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = MediumA,
    allowFlowReversal=allowFlowReversal,
    dp_nominal=40) "Pressure drop for return duct"
    annotation (Placement(transformation(extent={{406,232},{386,252}})));
  Buildings.Fluid.Movers.SpeedControlled_y fanSup(
    redeclare package Medium = MediumA,
    per(pressure(V_flow={0,m_flow_nominal/1.2*2}, dp=2*{780 + 10 + dpBuiStaSet,
            0})),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) "Supply air fan"
    annotation (Placement(transformation(extent={{306,52},{326,72}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senRetFlo(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal)
    "Sensor for return fan flow rate"
    annotation (Placement(transformation(extent={{366,232},{346,252}})));
  Buildings.Fluid.Sources.Boundary_pT sinHea(
    redeclare package Medium = MediumW,
    p=300000,
    T=318.15,
    nPorts=1) "Sink for heating coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={86,-20})));
  Buildings.Fluid.Sources.Boundary_pT sinCoo(
    redeclare package Medium = MediumW,
    p=300000,
    T=285.15,
    nPorts=1) "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={186,-18})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TSup(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{336,52},{356,72}})));
  Buildings.Fluid.Sensors.RelativePressure dpDisSupFan(redeclare package Medium =
        MediumA) "Supply fan static discharge pressure" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={326,102})));
  Buildings.Fluid.Sources.MassFlowSource_T souCoo(
    redeclare package Medium = MediumW,
    T=279.15,
    nPorts=1,
    use_m_flow_in=true) "Source for cooling coil" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={236,-18})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TRet(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Return air temperature sensor"
    annotation (Placement(transformation(extent={{116,232},{96,252}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TMix(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Mixed air temperature sensor"
    annotation (Placement(transformation(extent={{36,52},{56,72}})));
  Buildings.Fluid.Sources.MassFlowSource_T souHea(
    redeclare package Medium = MediumW,
    T=318.15,
    use_m_flow_in=true,
    nPorts=1)           "Source for heating coil" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={138,-18})));
  Buildings.Fluid.Sensors.VolumeFlowRate VOut1(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal) "Outside air volume flow rate"
    annotation (Placement(transformation(extent={{-66,58},{-44,80}})));
  Buildings.Examples.VAVReheat.BaseClasses.MixingBox eco(
    redeclare package Medium = MediumA,
    mOut_flow_nominal=m_flow_nominal,
    dpOut_nominal=10,
    mRec_flow_nominal=m_flow_nominal,
    dpRec_nominal=10,
    mExh_flow_nominal=m_flow_nominal,
    dpExh_nominal=10,
    from_dp=false) "Economizer" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-4,56})));
public
  Buildings.Controls.OBC.CDL.Continuous.Gain gaiHeaCoi(k=m_flow_nominal*1000*40
        /4200/10) "Gain for heating coil mass flow rate"
    annotation (Placement(transformation(extent={{106,-118},{126,-98}})));
  Buildings.Controls.OBC.CDL.Continuous.Gain gaiCooCoi(k=m_flow_nominal*1000*15
        /4200/10) "Gain for cooling coil mass flow rate"
    annotation (Placement(transformation(extent={{106,-156},{126,-136}})));
  Buildings.Controls.OBC.CDL.Logical.OnOffController freSta(bandwidth=1)
    "Freeze stat for heating coil"
    annotation (Placement(transformation(extent={{6,0},{26,20}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant freStaTSetPoi(k=273.15
         + 3) "Freeze stat set point for heating coil"
    annotation (Placement(transformation(extent={{-34,6},{-14,26}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senSupFlo(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal)
    "Sensor for supply fan flow rate"
    annotation (Placement(transformation(extent={{406,52},{426,72}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant yFreHeaCoi(final k=1)
    "Flow rate signal for heating coil when freeze stat is on"
    annotation (Placement(transformation(extent={{0,-68},{20,-48}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swiFreSta "Switch for freeze stat"
    annotation (Placement(transformation(extent={{60,-92},{80,-72}})));
  Modelica.Blocks.Interfaces.RealInput uFan "Fan speed control signal"
    annotation (Placement(transformation(extent={{-220,-162},{-180,-122}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Interfaces.RealOutput VOutFlo "Outdoor air flowrate"
    annotation (Placement(transformation(extent={{480,172},{500,192}}),
        iconTransformation(extent={{100,46},{120,66}})));
  Modelica.Blocks.Interfaces.RealOutput TMixAHU(each unit="K", each displayUnit=
       "degC") "AHU entering temperature" annotation (Placement(transformation(
          extent={{480,-230},{500,-210}}), iconTransformation(extent={{100,-34},
            {120,-14}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant yExh(final k=1)
    "Exhasut damper position"
    annotation (Placement(transformation(extent={{-100,130},{-80,150}})));
equation

  connect(fanSup.port_b,dpDisSupFan. port_a) annotation (Line(
      points={{326,62},{326,92}},
      color={0,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dot));
  connect(TSup.port_a,fanSup. port_b) annotation (Line(
      points={{336,62},{326,62}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(amb.ports[1],VOut1. port_a) annotation (Line(
      points={{-108,59.9333},{-88,59.9333},{-88,69},{-66,69}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(cooCoi.port_b1,sinCoo. ports[1]) annotation (Line(
      points={{196,50},{186,50},{186,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(amb.weaBus, weaBus) annotation (Line(
      points={{-130,57.22},{-154,57.22},{-154,222}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(cooCoi.port_b2,fanSup. port_a) annotation (Line(
      points={{216,62},{306,62}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(VOut1.port_b,eco. port_Out) annotation (Line(
      points={{-44,69},{-36,69},{-36,62},{-14,62}},
      color={0,127,255},
      thickness=0.5));
  connect(eco.port_Sup,TMix. port_a) annotation (Line(
      points={{6,62},{36,62}},
      color={0,127,255},
      thickness=0.5));
  connect(eco.port_Exh,amb. ports[2]) annotation (Line(
      points={{-14,50},{-90,50},{-90,57},{-108,57}},
      color={0,127,255},
      thickness=0.5));
  connect(eco.port_Ret,TRet. port_b) annotation (Line(
      points={{6,50},{16,50},{16,242},{96,242}},
      color={0,127,255},
      thickness=0.5));
  connect(senRetFlo.port_a,dpRetDuc. port_b)
    annotation (Line(points={{366,242},{386,242}}, color={0,127,255}));
  connect(TSup.port_b,senSupFlo. port_a)
    annotation (Line(points={{356,62},{406,62}},   color={0,127,255}));
  connect(cooCoi.port_a1,souCoo. ports[1]) annotation (Line(
      points={{216,50},{236,50},{236,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(gaiHeaCoi.y,souHea. m_flow_in) annotation (Line(points={{128,-108},{
          130,-108},{130,-30}},  color={0,0,127}));
  connect(gaiCooCoi.y,souCoo. m_flow_in) annotation (Line(points={{128,-146},{
          228,-146},{228,-30}},  color={0,0,127}));
  connect(dpDisSupFan.port_b,amb. ports[3]) annotation (Line(
      points={{326,112},{326,116},{-82,116},{-82,54.0667},{-108,54.0667}},
      color={0,0,0},
      pattern=LinePattern.Dot));
  connect(senRetFlo.port_b,TRet. port_a) annotation (Line(points={{346,242},{
          116,242}},           color={0,127,255}));
  connect(freStaTSetPoi.y,freSta. reference)
    annotation (Line(points={{-12,16},{4,16}},    color={0,0,127}));
  connect(freSta.u,TMix. T) annotation (Line(points={{4,4},{-4,4},{-4,32},{26,
          32},{26,82},{46,82},{46,73}},         color={0,0,127}));
  connect(TMix.port_b,heaCoi. port_a2) annotation (Line(
      points={{56,62},{104,62}},
      color={0,127,255},
      thickness=0.5));
  connect(heaCoi.port_b2,cooCoi. port_a2) annotation (Line(
      points={{124,62},{196,62}},
      color={0,127,255},
      thickness=0.5));
  connect(souHea.ports[1],heaCoi. port_a1) annotation (Line(
      points={{138,-8},{138,50},{124,50}},
      color={28,108,200},
      thickness=0.5));
  connect(heaCoi.port_b1,sinHea. ports[1]) annotation (Line(
      points={{104,50},{86,50},{86,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(freSta.y, swiFreSta.u2) annotation (Line(points={{28,10},{36,10},{36,
          -82},{58,-82}}, color={255,0,255}));
  connect(yFreHeaCoi.y, swiFreSta.u1) annotation (Line(points={{22,-58},{48,-58},
          {48,-74},{58,-74}}, color={0,0,127}));
  connect(senSupFlo.port_b, supplyAir)
    annotation (Line(points={{426,62},{482,62}}, color={0,127,255}));
  connect(dpRetDuc.port_a, returnAir)
    annotation (Line(points={{406,242},{482,242}}, color={0,127,255}));
  connect(swiFreSta.y, gaiHeaCoi.u) annotation (Line(points={{82,-82},{88,-82},
          {88,-108},{104,-108}}, color={0,0,127}));
  connect(uHea, swiFreSta.u3) annotation (Line(points={{-200,-190},{42,-190},{
          42,-90},{58,-90}}, color={0,0,127}));
  connect(uCoo, gaiCooCoi.u) annotation (Line(points={{-200,-240},{82,-240},{82,
          -146},{104,-146}}, color={0,0,127}));
  connect(uRetDamPos, eco.yRet) annotation (Line(points={{-200,26},{-140,26},{
          -140,86},{-10.8,86},{-10.8,68}}, color={0,0,127}));
  connect(uOutDamPos, eco.yOut) annotation (Line(points={{-200,-74},{-146,-74},
          {-146,90},{-4,90},{-4,68}}, color={0,0,127}));
  connect(TSup.T, TSupAHU) annotation (Line(points={{346,73},{346,84},{380,84},
          {380,-80},{490,-80}}, color={0,0,127}));
  connect(uFan, fanSup.y) annotation (Line(points={{-200,-142},{-168,-142},{
          -168,98},{314,98},{314,74},{316,74}}, color={0,0,127}));
  connect(dpDisSupFan.p_rel, dpFan) annotation (Line(points={{317,102},{300,102},
          {300,140},{490,140}}, color={0,0,127}));
  connect(TRet.T, TRetAHU) annotation (Line(points={{106,253},{106,262},{282,
          262},{282,-190},{490,-190}}, color={0,0,127}));
  connect(VOut1.V_flow, VOutFlo) annotation (Line(points={{-55,81.1},{-55,182},
          {490,182}}, color={0,0,127}));
  connect(TMix.T, TMixAHU) annotation (Line(points={{46,73},{46,122},{250,122},
          {250,-220},{490,-220}}, color={0,0,127}));
  connect(yExh.y, eco.yExh)
    annotation (Line(points={{-78,140},{3,140},{3,68}}, color={0,0,127}));
  annotation (
  defaultComponentName="AHU",
        Diagram(
        coordinateSystem(preserveAspectRatio=true,
        extent={{-180,-280},{480,300}})),
        Icon(coordinateSystem(preserveAspectRatio=true),
        graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{100,90},{-100,70}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{98,-72},{-100,-92}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,72},{-48,-72}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,9},{4,-9}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward,
          origin={-39,-2},
          rotation=90),
        Rectangle(
          extent={{-68,90},{-60,70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-68,-72},{-60,-92}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{34,-72},{40,-92}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{56,-72},{62,-92}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
                                        Text(
        extent={{-148,148},{152,108}},
        textString="%name",
        lineColor={0,0,255}),
        Rectangle(
          extent={{-8,-74},{4,-80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-16,-74},{0,-90}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    experiment(
      StopTime=2073600,
      Interval=600,
      __Dymola_Algorithm="Dassl"));
end AirHandlingUnit_G36;
