within BestInClass.DetailedZoning.BaseClasses;
model AirHandlingUnit "Air handing system for VAV"

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

  Buildings.Fluid.Sources.Outside amb(
    redeclare package Medium = MediumA,
    nPorts=3) "Ambient conditions"
    annotation (Placement(transformation(extent={{-50,46},{-28,68}})));

  Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU heaCoi(
    show_T=true,
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
    annotation (Placement(transformation(extent={{204,66},{184,46}})));

  Buildings.Fluid.HeatExchangers.WetCoilCounterFlow cooCoi(
    show_T=true,
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
    annotation (Placement(transformation(extent={{296,66},{276,46}})));
  Buildings.Fluid.Sources.Boundary_pT sinHea(
    redeclare package Medium = MediumW,
    p=300000,
    T=318.15,
    nPorts=1) "Sink for heating coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={166,-20})));
  Buildings.Fluid.Sources.Boundary_pT sinCoo(
    redeclare package Medium = MediumW,
    p=300000,
    T=285.15,
    nPorts=1) "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={266,-18})));
  Modelica.Blocks.Routing.RealPassThrough TOut(y(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC",
      min=0))
    annotation (Placement(transformation(extent={{-134,212},{-114,232}})));
  Buildings.Fluid.Sources.MassFlowSource_T souCoo(
    redeclare package Medium = MediumW,
    T=279.15,
    nPorts=1,
    use_m_flow_in=true) "Source for cooling coil" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={316,-18})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TRet(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Return air temperature sensor"
    annotation (Placement(transformation(extent={{196,232},{176,252}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TMix(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Mixed air temperature sensor"
    annotation (Placement(transformation(extent={{116,52},{136,72}})));
  Buildings.Fluid.Sources.MassFlowSource_T souHea(
    redeclare package Medium = MediumW,
    T=318.15,
    use_m_flow_in=true,
    nPorts=1)           "Source for heating coil" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={218,-18})));
  Buildings.Fluid.Sensors.VolumeFlowRate VOut1(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal) "Outside air volume flow rate"
    annotation (Placement(transformation(extent={{14,58},{36,80}})));
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
        origin={76,56})));
public
  Buildings.Controls.OBC.CDL.Continuous.Gain gaiHeaCoi(k=m_flow_nominal*1000*40/
        4200/10)  "Gain for heating coil mass flow rate"
    annotation (Placement(transformation(extent={{186,-130},{206,-110}})));
  Buildings.Controls.OBC.CDL.Continuous.Gain gaiCooCoi(k=m_flow_nominal*1000*15/
        4200/10)  "Gain for cooling coil mass flow rate"
    annotation (Placement(transformation(extent={{186,-168},{206,-148}})));
  Buildings.Controls.OBC.CDL.Logical.OnOffController freSta(bandwidth=1)
    "Freeze stat for heating coil"
    annotation (Placement(transformation(extent={{86,0},{106,20}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant freStaTSetPoi(k=273.15 +
        3)    "Freeze stat set point for heating coil"
    annotation (Placement(transformation(extent={{46,6},{66,26}})));
  Modelica.Blocks.Sources.Constant TSupSetHea(y(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC",
      min=0), k=273.15 + 10) "Supply air temperature setpoint for heating"
    annotation (Placement(transformation(extent={{-140,-60},{-120,-40}})));
  Buildings.Examples.VAVReheat.Controls.ModeSelector
                        modeSelector
    annotation (Placement(transformation(extent={{-114,-218},{-94,-198}})));
  Controls.Economizer conEco(
    dT=1,
    VOut_flow_min=0.633225,
    Ti=120,
    k=0.1) "Controller for economizer"
    annotation (Placement(transformation(extent={{6,242},{26,262}})));
  Controls.RoomTemperatureSetpoint TSetRoo(
    final THeaOn=THeaOn,
    final THeaOff=THeaOff,
    final TCooOn=TCooOn,
    final TCooOff=TCooOff)
    annotation (Placement(transformation(extent={{0,-262},{20,-242}})));
  Controls.CoolingCoilTemperatureSetpoint TSetCoo "Setpoint for cooling coil"
    annotation (Placement(transformation(extent={{-44,-108},{-24,-88}})));
  Buildings.Controls.Continuous.LimPID heaCoiCon(
    yMax=1,
    yMin=0,
    Td=60,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.02,
    Ti=300)
           "Controller for heating coil"
    annotation (Placement(transformation(extent={{6,-122},{26,-102}})));
  Buildings.Controls.Continuous.LimPID cooCoiCon(
    Td=60,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=600,
    k=0.1,
    reverseActing=not (true)) "Controller for cooling coil"
    annotation (Placement(transformation(extent={{6,-170},{26,-150}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swiHeaCoi
    "Switch to switch off heating coil"
    annotation (Placement(transformation(extent={{146,-130},{166,-110}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swiCooCoi
    "Switch to switch off cooling coil"
    annotation (Placement(transformation(extent={{146,-168},{166,-148}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant coiOff(k=0)
    "Signal to switch water flow through coils off"
    annotation (Placement(transformation(extent={{26,-70},{46,-50}})));
  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{86,-78},{106,-58}})));
  Controls.ControlBus controlBus
    annotation (Placement(transformation(extent={{-94,-90},{-74,-70}}),
        iconTransformation(extent={{-94,-90},{-74,-70}})));
  Modelica.Blocks.Interfaces.RealInput TSupSetCoo
    "Supply air temperature (cooling) setpoint"
    annotation (Placement(transformation(extent={{-220,-94},{-180,-54}}),
        iconTransformation(extent={{-120,20},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput TRooAve "Average room temperature"
    annotation (Placement(transformation(extent={{-220,-210},{-180,-170}}),
        iconTransformation(extent={{-120,-70},{-100,-50}})));
  Modelica.Blocks.Interfaces.RealInput TRooMin "Minimum room temperature"
    annotation (Placement(transformation(extent={{-220,-260},{-180,-220}}),
        iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput tNexOcc "Next occupancy"
    annotation (Placement(transformation(extent={{-220,6},{-180,46}}),
        iconTransformation(extent={{-120,80},{-100,100}})));
  Modelica.Blocks.Interfaces.BooleanInput occupied
    "Boolean signal for occupied"
    annotation (Placement(transformation(extent={{-220,-34},{-180,6}}),
        iconTransformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.RealOutput TRooCooSet(each unit="K", each
      displayUnit="degC") "Room cooling setpoint temperature" annotation (
      Placement(transformation(extent={{480,-90},{500,-70}}),
        iconTransformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput TRooHeaSet(each unit="K", each
      displayUnit="degC") "Room heating setpoint temperature" annotation (
      Placement(transformation(extent={{480,-200},{500,-180}}),
        iconTransformation(extent={{100,-30},{120,-10}})));
  Modelica.Fluid.Interfaces.FluidPort_a supplyAir(redeclare final package
      Medium = MediumA) "Supply air"
    annotation (Placement(transformation(extent={{472,52},{492,72}}),
        iconTransformation(extent={{90,-92},{110,-72}})));
  Modelica.Fluid.Interfaces.FluidPort_b returnAir(redeclare final package
      Medium = MediumA) "Return air"
    annotation (Placement(transformation(extent={{472,232},{492,252}}),
        iconTransformation(extent={{90,70},{110,90}})));
  Buildings.Fluid.FixedResistances.PressureDrop dpRetDuc(
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = MediumA,
    allowFlowReversal=allowFlowReversal,
    dp_nominal=40) "Pressure drop for return duct"
    annotation (Placement(transformation(extent={{298,232},{278,252}})));
  Buildings.Fluid.Sensors.VolumeFlowRate senRetFlo(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal)
    "Sensor for return fan flow rate"
    annotation (Placement(transformation(extent={{258,232},{238,252}})));
  Buildings.Fluid.Movers.SpeedControlled_y fanSup(
    redeclare package Medium = MediumA,
    per(pressure(V_flow={0,m_flow_nominal/1.2*2}, dp=2*{780 + 10 + dpBuiStaSet,
            0})),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) "Supply air fan"
    annotation (Placement(transformation(extent={{338,52},{358,72}})));

  Buildings.Fluid.Sensors.VolumeFlowRate senSupFlo(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal)
    "Sensor for supply fan flow rate"
    annotation (Placement(transformation(extent={{420,52},{440,72}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TSup(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{368,52},{388,72}})));
  Buildings.Fluid.Sensors.RelativePressure dpDisSupFan(redeclare package Medium =
        MediumA) "Supply fan static discharge pressure" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={358,102})));
  Modelica.Blocks.Interfaces.BooleanOutput fanOn "Fan on signal" annotation (
      Placement(transformation(extent={{480,-230},{500,-210}}),
        iconTransformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput dPFan
    "Supply fan static discharge pressure" annotation (Placement(transformation(
          extent={{480,130},{500,150}}), iconTransformation(extent={{100,10},{120,
            30}})));
  Modelica.Blocks.Interfaces.RealInput uFan "Fan speed control signal"
    annotation (Placement(transformation(extent={{-220,66},{-180,106}}),
        iconTransformation(extent={{-120,-40},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Continuous.Greater gre
    annotation (Placement(transformation(extent={{102,-262},{122,-242}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con(k=0)
    annotation (Placement(transformation(extent={{32,-266},{52,-246}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi
    annotation (Placement(transformation(extent={{160,-262},{180,-242}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1(k=false)
    annotation (Placement(transformation(extent={{120,-232},{140,-212}})));
equation
  connect(amb.ports[1],VOut1. port_a) annotation (Line(
      points={{-28,59.9333},{-8,59.9333},{-8,69},{14,69}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(cooCoi.port_b1,sinCoo. ports[1]) annotation (Line(
      points={{276,50},{266,50},{266,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(weaBus.TDryBul,TOut.u) annotation (Line(
      points={{-154,222},{-136,222}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(amb.weaBus,weaBus)  annotation (Line(
      points={{-50,57.22},{-154,57.22},{-154,222}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(VOut1.port_b,eco. port_Out) annotation (Line(
      points={{36,69},{44,69},{44,62},{66,62}},
      color={0,127,255},
      thickness=0.5));
  connect(eco.port_Sup,TMix. port_a) annotation (Line(
      points={{86,62},{116,62}},
      color={0,127,255},
      thickness=0.5));
  connect(eco.port_Exh,amb. ports[2]) annotation (Line(
      points={{66,50},{-10,50},{-10,57},{-28,57}},
      color={0,127,255},
      thickness=0.5));
  connect(eco.port_Ret,TRet. port_b) annotation (Line(
      points={{86,50},{96,50},{96,242},{176,242}},
      color={0,127,255},
      thickness=0.5));
  connect(cooCoi.port_a1,souCoo. ports[1]) annotation (Line(
      points={{296,50},{316,50},{316,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(gaiHeaCoi.y,souHea. m_flow_in) annotation (Line(points={{208,-120},{
          210,-120},{210,-30}},  color={0,0,127}));
  connect(gaiCooCoi.y,souCoo. m_flow_in) annotation (Line(points={{208,-158},{
          308,-158},{308,-30}},  color={0,0,127}));
  connect(freStaTSetPoi.y,freSta. reference)   annotation (Line(points={{68,16},{84,16}},    color={0,0,127}));
  connect(freSta.u,TMix. T) annotation (Line(points={{84,4},{76,4},{76,32},{106,
          32},{106,82},{126,82},{126,73}},      color={0,0,127}));
  connect(TMix.port_b,heaCoi. port_a2) annotation (Line(
      points={{136,62},{184,62}},
      color={0,127,255},
      thickness=0.5));
  connect(heaCoi.port_b2,cooCoi. port_a2) annotation (Line(
      points={{204,62},{276,62}},
      color={0,127,255},
      thickness=0.5));
  connect(souHea.ports[1],heaCoi. port_a1) annotation (Line(
      points={{218,-8},{218,50},{204,50}},
      color={28,108,200},
      thickness=0.5));
  connect(heaCoi.port_b1,sinHea. ports[1]) annotation (Line(
      points={{184,50},{166,50},{166,-10}},
      color={28,108,200},
      thickness=0.5));
  connect(TSupSetHea.y,heaCoiCon. u_s) annotation (Line(
      points={{-119,-50},{-10,-50},{-10,-112},{4,-112}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(controlBus,modeSelector. cb) annotation (Line(
      points={{-84,-80},{-84,-201.182},{-110.818,-201.182}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(TRet.T,conEco. TRet) annotation (Line(
      points={{186,253},{186,274},{-6,274},{-6,259.333},{4.66667,259.333}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TMix.T,conEco. TMix) annotation (Line(
      points={{126,73},{126,270},{-4,270},{-4,255.333},{4.66667,255.333}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conEco.TSupHeaSet,TSupSetHea. y) annotation (Line(
      points={{4.66667,247.333},{-70,247.333},{-70,-18},{-54,-18},{-54,-50},{
          -119,-50}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TSetRoo.controlBus,controlBus)  annotation (Line(
      points={{12,-246},{-84,-246},{-84,-80}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(TSetCoo.TSet,cooCoiCon. u_s) annotation (Line(
      points={{-23,-98},{-14,-98},{-14,-160},{4,-160}},
      color={0,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TSetCoo.TSet,conEco. TSupCooSet) annotation (Line(
      points={{-23,-98},{-14,-98},{-14,-12},{-64,-12},{-64,243.333},{4.66667,
          243.333}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TSupSetHea.y,TSetCoo. TSetHea) annotation (Line(
      points={{-119,-50},{-54,-50},{-54,-94},{-46,-94}},
      color={0,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(modeSelector.cb,TSetCoo. controlBus) annotation (Line(
      points={{-110.818,-201.182},{-74,-201.182},{-74,-106},{-35.8,-106}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(conEco.VOut_flow,VOut1. V_flow) annotation (Line(
      points={{4.66667,251.333},{-4,251.333},{-4,182},{25,182},{25,81.1}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conEco.yOA,eco. yOut) annotation (Line(
      points={{26.6667,254},{76,254},{76,68}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TOut.y,controlBus. TOut) annotation (Line(points={{-113,222},{-84,222},
          {-84,-80}},                              color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(conEco.controlBus,controlBus)  annotation (Line(
      points={{10,252.667},{10,222},{-84,222},{-84,-80}},
      color={255,204,51},
      thickness=0.5));
  connect(swiCooCoi.u1,cooCoiCon. y) annotation (Line(points={{144,-150},{86,
          -150},{86,-160},{27,-160}},
                                  color={0,0,127}));
  connect(swiHeaCoi.u1,heaCoiCon. y)   annotation (Line(points={{144,-112},{27,-112}}, color={0,0,127}));
  connect(coiOff.y,swiCooCoi. u3) annotation (Line(points={{48,-60},{58,-60},{
          58,-166},{144,-166}},
                              color={0,0,127}));
  connect(coiOff.y,swiHeaCoi. u3) annotation (Line(points={{48,-60},{58,-60},{
          58,-128},{144,-128}},
                              color={0,0,127}));
  connect(gaiHeaCoi.u,swiHeaCoi. y)    annotation (Line(points={{184,-120},{168,-120}},         color={0,0,127}));
  connect(gaiCooCoi.u,swiCooCoi. y) annotation (Line(points={{184,-158},{168,
          -158}},               color={0,0,127}));
  connect(eco.yExh,conEco. yOA) annotation (Line(
      points={{83,68},{84,68},{84,254},{26.6667,254}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(eco.yRet,conEco. yRet) annotation (Line(
      points={{69.2,68},{69.2,248.667},{26.6667,248.667}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(freSta.y,or2. u1) annotation (Line(points={{108,10},{126,10},{126,-48},
          {66,-48},{66,-68},{84,-68}},                       color={255,0,255}));
  connect(or2.u2,modeSelector. yFan) annotation (Line(points={{84,-76},{66,-76},
          {66,-208},{-93.5455,-208}},color={255,0,255}));
  connect(or2.y,swiHeaCoi. u2) annotation (Line(points={{108,-68},{126,-68},{
          126,-120},{144,-120}},                color={255,0,255}));
  connect(TRooMin, controlBus.TRooMin) annotation (Line(points={{-200,-240},{
          -84,-240},{-84,-80}},
                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TRooAve, controlBus.TRooAve) annotation (Line(points={{-200,-190},{
          -160,-190},{-160,-80},{-84,-80}},
                                       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TSupSetCoo, TSetCoo.TCooOn) annotation (Line(points={{-200,-74},{-120,
          -74},{-120,-102},{-46,-102}}, color={0,0,127}));
  connect(occupied, controlBus.occupied) annotation (Line(points={{-200,-14},{
          -84,-14},{-84,-80}},
                           color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tNexOcc, controlBus.dTNexOcc) annotation (Line(points={{-200,26},{-84,
          26},{-84,-80}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TRooHeaSet, controlBus.TRooSetHea) annotation (Line(points={{490,-190},
          {-84,-190},{-84,-80}},                                          color={0,0,127},
      pattern=LinePattern.Dash),
                     Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(TRooCooSet, controlBus.TRooSetCoo) annotation (Line(points={{490,-80},
          {-84,-80}},                     color={0,0,127},
      pattern=LinePattern.Dash),                            Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senRetFlo.port_a,dpRetDuc. port_b)  annotation (Line(points={{258,242},
          {278,242}},                                                                        color={0,127,255}));
  connect(dpRetDuc.port_a, returnAir)  annotation (Line(points={{298,242},{482,
          242}},                                                                      color={0,127,255}));
  connect(TRet.port_a, senRetFlo.port_b) annotation (Line(points={{196,242},{
          238,242}},                 color={0,127,255}));
  connect(fanSup.port_b,dpDisSupFan. port_a) annotation (Line(
      points={{358,62},{358,92}},
      color={0,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dot));
  connect(TSup.port_a, fanSup.port_b) annotation (Line(
      points={{368,62},{358,62}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(cooCoi.port_b2,fanSup. port_a) annotation (Line(
      points={{296,62},{338,62}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(TSup.port_b, senSupFlo.port_a)
    annotation (Line(points={{388,62},{420,62}}, color={0,127,255}));
  connect(senSupFlo.port_b, supplyAir)   annotation (Line(points={{440,62},{482,62}}, color={0,127,255}));
  connect(dpDisSupFan.port_b, amb.ports[3]) annotation (Line(points={{358,112},
          {358,118},{-14,118},{-14,54.0667},{-28,54.0667}},color={0,127,255}));
  connect(modeSelector.yFan, fanOn) annotation (Line(points={{-93.5455,-208},{
          436,-208},{436,-220},{490,-220}}, color={255,0,255}));
  connect(dpDisSupFan.p_rel, dPFan) annotation (Line(points={{349,102},{330,102},
          {330,140},{490,140}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(uFan, fanSup.y) annotation (Line(points={{-200,86},{348,86},{348,74}},
                              color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TSup.T, heaCoiCon.u_m) annotation (Line(points={{378,73},{378,86},{
          402,86},{402,-136},{16,-136},{16,-124}}, color={0,0,127}));
  connect(TSup.T, cooCoiCon.u_m) annotation (Line(points={{378,73},{378,86},{
          402,86},{402,-182},{16,-182},{16,-172}}, color={0,0,127}));
  connect(heaCoiCon.y, gre.u1) annotation (Line(points={{27,-112},{46,-112},{46,
          -226},{82,-226},{82,-252},{100,-252}}, color={0,0,127}));
  connect(con.y, gre.u2) annotation (Line(points={{54,-256},{80,-256},{80,-260},
          {100,-260}}, color={0,0,127}));
  connect(gre.y, logSwi.u2)
    annotation (Line(points={{124,-252},{158,-252}}, color={255,0,255}));
  connect(con1.y, logSwi.u1) annotation (Line(points={{142,-222},{146,-222},{
          146,-244},{158,-244}}, color={255,0,255}));
  connect(logSwi.y, swiCooCoi.u2) annotation (Line(points={{182,-252},{202,-252},
          {202,-198},{124,-198},{124,-158},{144,-158}}, color={255,0,255}));
  connect(modeSelector.yFan, logSwi.u3) annotation (Line(points={{-93.5455,-208},
          {-60,-208},{-60,-276},{138,-276},{138,-260},{158,-260}}, color={255,0,
          255}));
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
end AirHandlingUnit;
