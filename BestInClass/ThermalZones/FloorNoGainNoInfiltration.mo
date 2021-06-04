within BestInClass.ThermalZones;
model FloorNoGainNoInfiltration "Model of a floor of the building"
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for air" annotation (choicesAllMatching=true);

  parameter Boolean use_windPressure=true
    "Set to true to enable wind pressure";

  parameter Buildings.HeatTransfer.Types.InteriorConvection intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Temperature
    "Convective heat transfer model for room-facing surfaces of opaque constructions";
  parameter Modelica.SIunits.Angle lat "Latitude";
  parameter Real winWalRat(
    min=0.01,
    max=0.99) = 0.33 "Window to wall ratio for exterior walls";
  parameter Modelica.SIunits.Length hWin = 1.5 "Height of windows";
  parameter Buildings.HeatTransfer.Data.Solids.Plywood matFur(x=0.15,
      nStaRef=5) "Material for furniture"
    annotation (Placement(transformation(extent={{140,460},{160,480}})));
  parameter Buildings.HeatTransfer.Data.Resistances.Carpet matCar "Carpet"
    annotation (Placement(transformation(extent={{180,460},{200,480}})));
  parameter Buildings.HeatTransfer.Data.Solids.Concrete matCon(
    x=0.1,
    k=1.311,
    c=836,
    nStaRef=5) "Concrete"
    annotation (Placement(transformation(extent={{140,430},{160,450}})));
  parameter Buildings.HeatTransfer.Data.Solids.Plywood matWoo(
    x=0.01,
    k=0.11,
    d=544,
    nStaRef=1) "Wood for exterior construction"
    annotation (Placement(transformation(extent={{140,400},{160,420}})));
  parameter Buildings.HeatTransfer.Data.Solids.Generic matIns(
    x=0.087,
    k=0.049,
    c=836.8,
    d=265,
    nStaRef=5) "Steelframe construction with insulation"
    annotation (Placement(transformation(extent={{180,400},{200,420}})));
  parameter Buildings.HeatTransfer.Data.Solids.GypsumBoard matGyp(
    x=0.0127,
    k=0.16,
    c=830,
    d=784,
    nStaRef=2) "Gypsum board"
    annotation (Placement(transformation(extent={{140,372},{160,392}})));
  parameter Buildings.HeatTransfer.Data.Solids.GypsumBoard matGyp2(
    x=0.025,
    k=0.16,
    c=830,
    d=784,
    nStaRef=2) "Gypsum board"
    annotation (Placement(transformation(extent={{180,372},{200,392}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conExtWal(final
      nLay=3, material={matWoo,matIns,matGyp}) "Exterior construction"
    annotation (Placement(transformation(extent={{280,460},{300,480}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conIntWal(final
      nLay=1, material={matGyp2}) "Interior wall construction"
    annotation (Placement(transformation(extent={{320,460},{340,480}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conFlo(final
      nLay=1, material={matCon}) "Floor construction (opa_a is carpet)"
    annotation (Placement(transformation(extent={{280,420},{300,440}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conFur(final
      nLay=1, material={matFur})
    "Construction for internal mass of furniture"
    annotation (Placement(transformation(extent={{320,420},{340,440}})));
  parameter Buildings.HeatTransfer.Data.Solids.Plywood matCarTra(
    k=0.11,
    d=544,
    nStaRef=1,
    x=0.215/0.11) "Wood for floor"
    annotation (Placement(transformation(extent={{102,460},{122,480}})));
  parameter
    Buildings.HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear glaSys(
    UFra=2,
    shade=Buildings.HeatTransfer.Data.Shades.Gray(),
    haveInteriorShade=false,
    haveExteriorShade=false) "Data record for the glazing system"
    annotation (Placement(transformation(extent={{240,460},{260,480}})));
  parameter Real kIntNor(min=0, max=1) = 1
    "Gain factor to scale internal heat gain in north zone";
  constant Modelica.SIunits.Height hRoo=2.74 "Room height";

  parameter Boolean sampleModel = false
    "Set to true to time-sample the model, which can give shorter simulation time if there is already time sampling in the system model"
    annotation (
      Evaluate=true,
      Dialog(tab="Experimental (may be changed in future releases)"));

  Buildings.ThermalZones.Detailed.MixedAir sou(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=568.77/hRoo,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=1,
    datConExtWin(
      layers={conExtWal},
      A={49.91*hRoo},
      glaSys={glaSys},
      wWin={winWalRat/hWin*49.91*hRoo},
      each hWin=hWin,
      fFra={0.1},
      til={Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.S}),
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={568.77/hRoo,414.68},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=3,
    datConBou(
      layers={conIntWal,conIntWal,conIntWal},
      A={6.47,40.76,6.47}*hRoo,
      til={Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}),
    nSurBou=0,
    nPorts=2,
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "South zone"
    annotation (Placement(transformation(extent={{144,-44},{184,-4}})));
  Buildings.ThermalZones.Detailed.MixedAir eas(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=360.0785/hRoo,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=1,
    datConExtWin(
      layers={conExtWal},
      A={33.27*hRoo},
      glaSys={glaSys},
      wWin={winWalRat/hWin*33.27*hRoo},
      each hWin=hWin,
      fFra={0.1},
      til={Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.E}),
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={360.0785/hRoo,262.52},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=1,
    datConBou(
      layers={conIntWal},
      A={24.13}*hRoo,
      til={Buildings.Types.Tilt.Wall}),
    nSurBou=2,
    surBou(
      each A=6.47*hRoo,
      each absIR=0.9,
      each absSol=0.9,
      til={Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}),
    nPorts=2,
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "East zone"
    annotation (Placement(transformation(extent={{304,56},{344,96}})));
  Buildings.ThermalZones.Detailed.MixedAir nor(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=568.77/hRoo,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=1,
    datConExtWin(
      layers={conExtWal},
      A={49.91*hRoo},
      glaSys={glaSys},
      wWin={winWalRat/hWin*49.91*hRoo},
      each hWin=hWin,
      fFra={0.1},
      til={Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.N}),
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={568.77/hRoo,414.68},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=3,
    datConBou(
      layers={conIntWal,conIntWal,conIntWal},
      A={6.47,40.76,6.47}*hRoo,
      til={Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}),
    nSurBou=0,
    nPorts=2,
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "North zone"
    annotation (Placement(transformation(extent={{144,116},{184,156}})));
  Buildings.ThermalZones.Detailed.MixedAir wes(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=360.0785/hRoo,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=1,
    datConExtWin(
      layers={conExtWal},
      A={33.27*hRoo},
      glaSys={glaSys},
      wWin={winWalRat/hWin*33.27*hRoo},
      each hWin=hWin,
      fFra={0.1},
      til={Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.W}),
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={360.0785/hRoo,262.52},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=1,
    datConBou(
      layers={conIntWal},
      A={24.13}*hRoo,
      til={Buildings.Types.Tilt.Wall}),
    nSurBou=2,
    surBou(
      each A=6.47*hRoo,
      each absIR=0.9,
      each absSol=0.9,
      til={Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}),
    extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.TemperatureWind,
    nPorts=2,
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "West zone"
    annotation (Placement(transformation(extent={{12,36},{52,76}})));
  Buildings.ThermalZones.Detailed.MixedAir cor(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=2698/hRoo,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=0,
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={2698/hRoo,1967.01},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=0,
    nSurBou=4,
    surBou(
      A={40.76,24.13,40.76,24.13}*hRoo,
      each absIR=0.9,
      each absSol=0.9,
      til={Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}),
    nPorts=2,
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "Core zone"
    annotation (Placement(transformation(extent={{144,36},{184,76}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b portsSou[2](
      redeclare package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{70,-42},{110,-26}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b portsEas[2](
      redeclare package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{314,28},{354,44}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b portsNor[2](
      redeclare package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{70,118},{110,134}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b portsWes[2](
      redeclare package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{-50,38},{-10,54}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b portsCor[2](
      redeclare package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{70,38},{110,54}})));
  Modelica.Blocks.Sources.Constant uSha(k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-80,170},{-60,190}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=1)
    annotation (Placement(transformation(extent={{-40,170},{-20,190}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather bus"
    annotation (Placement(transformation(extent={{200,190},{220,210}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAirSou
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{290,340},{310,360}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAirEas
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,310},{312,330}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAirNor
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,280},{312,300}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAirWes
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,248},{312,268}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAirPer5
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{294,218},{314,238}})));
  Modelica.Blocks.Routing.Multiplex5 multiplex5_1
    annotation (Placement(transformation(extent={{340,280},{360,300}})));
  Modelica.Blocks.Interfaces.RealOutput TRooAir[5](
    each unit="K",
    each displayUnit="degC") "Room air temperatures"
    annotation (Placement(transformation(extent={{380,150},{400,170}}),
        iconTransformation(extent={{380,150},{400,170}})));

  GainScheduleZero gainScheduleZero
    annotation (Placement(transformation(extent={{-80,100},{-60,120}})));
equation
  connect(sou.surf_conBou[1], wes.surf_surBou[2]) annotation (Line(
      points={{170,-40.6667},{170,-54},{62,-54},{62,20},{28.2,20},{28.2,42.5}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sou.surf_conBou[2], cor.surf_surBou[1]) annotation (Line(
      points={{170,-40},{170,-54},{200,-54},{200,20},{160.2,20},{160.2,41.25}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sou.surf_conBou[3], eas.surf_surBou[1]) annotation (Line(
      points={{170,-39.3333},{170,-54},{320.2,-54},{320.2,61.5}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(eas.surf_conBou[1], cor.surf_surBou[2]) annotation (Line(
      points={{330,60},{330,20},{160.2,20},{160.2,41.75}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(eas.surf_surBou[2], nor.surf_conBou[1]) annotation (Line(
      points={{320.2,62.5},{320.2,24},{220,24},{220,100},{170,100},{170,119.333}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(nor.surf_conBou[2], cor.surf_surBou[3]) annotation (Line(
      points={{170,120},{170,100},{200,100},{200,26},{160.2,26},{160.2,42.25}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(nor.surf_conBou[3], wes.surf_surBou[1]) annotation (Line(
      points={{170,120.667},{170,100},{60,100},{60,20},{28.2,20},{28.2,41.5}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(wes.surf_conBou[1], cor.surf_surBou[4]) annotation (Line(
      points={{38,40},{38,30},{160.2,30},{160.2,42.75}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(uSha.y, replicator.u) annotation (Line(
      points={{-59,180},{-42,180}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(replicator.y, nor.uSha) annotation (Line(
      points={{-19,180},{130,180},{130,154},{142.4,154}},
      color={0,0,127},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(replicator.y, wes.uSha) annotation (Line(
      points={{-19,180},{-6,180},{-6,74},{10.4,74}},
      color={0,0,127},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(replicator.y, eas.uSha) annotation (Line(
      points={{-19,180},{232,180},{232,94},{302.4,94}},
      color={0,0,127},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(replicator.y, sou.uSha) annotation (Line(
      points={{-19,180},{130,180},{130,-6},{142.4,-6}},
      color={0,0,127},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(replicator.y, cor.uSha) annotation (Line(
      points={{-19,180},{130,180},{130,74},{142.4,74}},
      color={0,0,127},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(sou.weaBus, weaBus) annotation (Line(
      points={{181.9,-6.1},{181.9,8},{210,8},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(eas.weaBus, weaBus) annotation (Line(
      points={{341.9,93.9},{341.9,120},{210,120},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(nor.weaBus, weaBus) annotation (Line(
      points={{181.9,153.9},{182,160},{182,168},{210,168},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(wes.weaBus, weaBus) annotation (Line(
      points={{49.9,73.9},{49.9,168},{210,168},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(cor.weaBus, weaBus) annotation (Line(
      points={{181.9,73.9},{181.9,90},{210,90},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(multiplex5_1.y, TRooAir) annotation (Line(
      points={{361,290},{372,290},{372,160},{390,160}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(temAirSou.T, multiplex5_1.u1[1]) annotation (Line(
      points={{310,350},{328,350},{328,300},{338,300}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(temAirEas.T, multiplex5_1.u2[1]) annotation (Line(
      points={{312,320},{324,320},{324,295},{338,295}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(temAirNor.T, multiplex5_1.u3[1]) annotation (Line(
      points={{312,290},{338,290}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(temAirWes.T, multiplex5_1.u4[1]) annotation (Line(
      points={{312,258},{324,258},{324,285},{338,285}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(temAirPer5.T, multiplex5_1.u5[1]) annotation (Line(
      points={{314,228},{322,228},{322,228},{332,228},{332,280},{338,280}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sou.heaPorAir, temAirSou.port) annotation (Line(
      points={{163,-24},{224,-24},{224,100},{264,100},{264,350},{290,350}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(eas.heaPorAir, temAirEas.port) annotation (Line(
      points={{323,76},{286,76},{286,320},{292,320}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(nor.heaPorAir, temAirNor.port) annotation (Line(
      points={{163,136},{164,136},{164,290},{292,290}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(wes.heaPorAir, temAirWes.port) annotation (Line(
      points={{31,56},{70,56},{70,114},{186,114},{186,258},{292,258}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(cor.heaPorAir, temAirPer5.port) annotation (Line(
      points={{163,56},{162,56},{162,228},{294,228}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sou.ports[1], portsSou[1]) annotation (Line(
      points={{149,-36},{114,-36},{114,-34},{80,-34}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou.ports[2], portsSou[2]) annotation (Line(
      points={{149,-32},{124,-32},{124,-34},{100,-34}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(eas.ports[1], portsEas[1]) annotation (Line(
      points={{309,64},{300,64},{300,36},{324,36}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(eas.ports[2], portsEas[2]) annotation (Line(
      points={{309,68},{300,68},{300,36},{344,36}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(nor.ports[1], portsNor[1]) annotation (Line(
      points={{149,124},{114,124},{114,126},{80,126}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(nor.ports[2], portsNor[2]) annotation (Line(
      points={{149,128},{124,128},{124,126},{100,126}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(wes.ports[1], portsWes[1]) annotation (Line(
      points={{17,44},{-12,44},{-12,46},{-40,46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(wes.ports[2], portsWes[2]) annotation (Line(
      points={{17,48},{-2,48},{-2,46},{-20,46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(cor.ports[1], portsCor[1]) annotation (Line(
      points={{149,44},{114,44},{114,46},{80,46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(cor.ports[2], portsCor[2]) annotation (Line(
      points={{149,48},{124,48},{124,46},{100,46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(gainScheduleZero.yGaiNor, nor.qGai_flow) annotation (Line(points={{-59,
          106},{-20,106},{-20,144},{142.4,144}}, color={0,0,127}));
  connect(gainScheduleZero.yGaiWes, wes.qGai_flow) annotation (Line(points={{-59,
          102},{-20,102},{-20,64},{10.4,64}}, color={0,0,127}));
  connect(gainScheduleZero.yGaiSou, sou.qGai_flow) annotation (Line(points={{-59,
          114},{-46,114},{-46,-26},{124,-26},{124,-16},{142.4,-16}}, color={0,0,
          127}));
  connect(gainScheduleZero.yGaiCor, cor.qGai_flow) annotation (Line(points={{-59,
          118},{136,118},{136,64},{142.4,64}}, color={0,0,127}));
  connect(gainScheduleZero.yGaiEas, eas.qGai_flow) annotation (Line(points={{-59,
          110},{292,110},{292,84},{302.4,84}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-160,-100},
            {400,500}},
        initialScale=0.1)),     Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-160,-100},{400,500}}), graphics={
        Rectangle(
          extent={{-80,-80},{380,180}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,160},{360,-60}},
          pattern=LinePattern.None,
          lineColor={117,148,176},
          fillColor={170,213,255},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{0,-80},{294,-60}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,-74},{294,-66}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{8,8},{294,100}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,88},{280,22}},
          pattern=LinePattern.None,
          lineColor={117,148,176},
          fillColor={170,213,255},
          fillPattern=FillPattern.Sphere),
        Polygon(
          points={{-56,170},{20,94},{12,88},{-62,162},{-56,170}},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{290,16},{366,-60},{358,-66},{284,8},{290,16}},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{284,96},{360,168},{368,162},{292,90},{284,96}},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-80,120},{-60,-20}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-74,120},{-66,-20}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-64,-56},{18,22},{26,16},{-58,-64},{-64,-56}},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{360,122},{380,-18}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{366,122},{374,-18}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,170},{296,178}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,160},{296,180}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,166},{296,174}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-84,234},{-62,200}},
          lineColor={0,0,255},
          textString="dP")}),
    Documentation(revisions="<html>
<ul>
<li>
May 1, 2013, by Michael Wetter:<br/>
Declared the parameter record to be a parameter, as declaring its elements
to be parameters does not imply that the whole record has the variability of a parameter.
</li>
</ul>
</html>"));
end FloorNoGainNoInfiltration;
