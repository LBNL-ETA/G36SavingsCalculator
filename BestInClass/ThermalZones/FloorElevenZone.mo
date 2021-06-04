within BestInClass.ThermalZones;
model FloorElevenZone "Model of a floor of the building"
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
  constant Modelica.SIunits.Height hRoo=2.74 "Room height";
  parameter Buildings.HeatTransfer.Data.Solids.Plywood matFur(x=0.15,
      nStaRef=5) "Material for furniture"
    annotation (Placement(transformation(extent={{140,466},{160,486}})));
  parameter Buildings.HeatTransfer.Data.Resistances.Carpet matCar "Carpet"
    annotation (Placement(transformation(extent={{180,466},{200,486}})));
  parameter Buildings.HeatTransfer.Data.Solids.Concrete matCon(
    x=0.1,
    k=1.311,
    c=836,
    nStaRef=5) "Concrete"
    annotation (Placement(transformation(extent={{140,440},{160,460}})));
  parameter Buildings.HeatTransfer.Data.Solids.Plywood matWoo(
    x=0.01,
    k=0.11,
    d=544,
    nStaRef=1) "Wood for exterior construction"
    annotation (Placement(transformation(extent={{60,466},{80,486}})));
  parameter Buildings.HeatTransfer.Data.Solids.Generic matIns(
    x=0.087,
    k=0.049,
    c=836.8,
    d=265,
    nStaRef=5) "Steelframe construction with insulation"
    annotation (Placement(transformation(extent={{100,466},{120,486}})));
  parameter Buildings.HeatTransfer.Data.Solids.GypsumBoard matGyp(
    x=0.0127,
    k=0.16,
    c=830,
    d=784,
    nStaRef=2) "Gypsum board"
    annotation (Placement(transformation(extent={{60,440},{80,460}})));
  parameter Buildings.HeatTransfer.Data.Solids.GypsumBoard matGyp2(
    x=0.025,
    k=0.16,
    c=830,
    d=784,
    nStaRef=2) "Gypsum board"
    annotation (Placement(transformation(extent={{100,440},{120,460}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conExtWal(final
      nLay=3, material={matWoo,matIns,matGyp}) "Exterior construction"
    annotation (Placement(transformation(extent={{280,466},{300,486}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conIntWal(final
      nLay=1, material={matGyp2}) "Interior wall construction"
    annotation (Placement(transformation(extent={{320,466},{340,486}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conFlo(final
      nLay=1, material={matCon}) "Floor construction (opa_a is carpet)"
    annotation (Placement(transformation(extent={{280,440},{300,460}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conFur(final
      nLay=1, material={matFur})
    "Construction for internal mass of furniture"
    annotation (Placement(transformation(extent={{320,440},{340,460}})));
  parameter Buildings.HeatTransfer.Data.Solids.Plywood matCarTra(
    k=0.11,
    d=544,
    nStaRef=1,
    x=0.215/0.11) "Wood for floor"
    annotation (Placement(transformation(extent={{180,440},{200,460}})));
  parameter
    Buildings.HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear glaSys(
    UFra=2,
    shade=Buildings.HeatTransfer.Data.Shades.Gray(),
    haveInteriorShade=false,
    haveExteriorShade=false) "Data record for the glazing system"
    annotation (Placement(transformation(extent={{240,466},{260,486}})));

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
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "South office zone"
    annotation (Placement(transformation(extent={{-94,-84},{-54,-44}})));
  Buildings.ThermalZones.Detailed.MixedAir conEas(
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
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "East conference zone"
    annotation (Placement(transformation(extent={{146,94},{186,134}})));
  Buildings.ThermalZones.Detailed.MixedAir offNor(
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
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
    nSurBou=0,
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "North office zone"
    annotation (Placement(transformation(extent={{-94,308},{-54,348}})));

  Buildings.ThermalZones.Detailed.MixedAir offWes(
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
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "West office zone"
    annotation (Placement(transformation(extent={{-306,68},{-266,108}})));
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
      A={360.0785/hRoo,262.52},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=0,
    nSurBou=4,
    surBou(
      A={40.76,24.13,40.76,24.13}*hRoo,
      each absIR=0.9,
      each absSol=0.9,
      til={Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "Corridor zone"
    annotation (Placement(transformation(extent={{-94,210},{-54,250}})));
  RoomLeakage leaSou(redeclare package Medium = Medium, VRoo=568.77,
    s=49.91/33.27,
    azi=Buildings.Types.Azimuth.S,
    final use_windPressure=use_windPressure)
    "Model for air infiltration through the envelope"
    annotation (Placement(transformation(extent={{-356,440},{-320,480}})));
  RoomLeakage leaEas(redeclare package Medium = Medium, VRoo=360.0785,
    s=33.27/49.91,
    azi=Buildings.Types.Azimuth.E,
    final use_windPressure=use_windPressure)
    "Model for air infiltration through the envelope"
    annotation (Placement(transformation(extent={{-356,400},{-320,440}})));
  RoomLeakage leaNor(redeclare package Medium = Medium, VRoo=568.77,
    s=49.91/33.27,
    azi=Buildings.Types.Azimuth.N,
    final use_windPressure=use_windPressure)
    "Model for air infiltration through the envelope"
    annotation (Placement(transformation(extent={{-356,360},{-320,400}})));
  RoomLeakage leaWes(redeclare package Medium = Medium, VRoo=360.0785,
    s=33.27/49.91,
    azi=Buildings.Types.Azimuth.W,
    final use_windPressure=use_windPressure)
    "Model for air infiltration through the envelope"
    annotation (Placement(transformation(extent={{-356,320},{-320,360}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temOffWes
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,370},{312,390}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temOffNor
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,330},{312,350}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temConEas
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,290},{312,310}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temOffSou
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,250},{312,270}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temCor
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,210},{312,230}})));
  Modelica.Blocks.Routing.Multiplex5 multiplex5_1
    annotation (Placement(transformation(extent={{340,280},{360,300}})));
  Modelica.Blocks.Interfaces.RealOutput TRooAir[5](
    each unit="K",
    each displayUnit="degC") "Room air temperatures"
    annotation (Placement(transformation(extent={{400,280},{420,300}}),
        iconTransformation(extent={{100,-60},{120,-40}})));
  Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium = Medium)
    "Building pressure measurement"
    annotation (Placement(transformation(extent={{-208,310},{-228,330}})));
  Buildings.Fluid.Sources.Outside out(          redeclare package Medium = Medium,
      nPorts=1)
    annotation (Placement(transformation(extent={{-348,282},{-328,302}})));

  Buildings.ThermalZones.Detailed.MixedAir lob(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=2698/hRoo,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=0,
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={360.0785/hRoo,262.52},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=0,
    nSurBou=4,
    surBou(
      A={40.76,24.13,40.76,24.13}*hRoo,
      each absIR=0.9,
      each absSol=0.9,
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,
          Buildings.Types.Tilt.Wall}),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel,
    nPorts=1)                      "Lobby zone"
    annotation (Placement(transformation(extent={{-94,116},{-54,156}})));
  Buildings.ThermalZones.Detailed.MixedAir din(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=2698/hRoo,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=0,
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={360.0785/hRoo,262.52},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=0,
    nSurBou=4,
    surBou(
      A={40.76,24.13,40.76,24.13}*hRoo,
      each absIR=0.9,
      each absSol=0.9,
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,
          Buildings.Types.Tilt.Wall}),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "Dining zone"
    annotation (Placement(transformation(extent={{-194,146},{-154,186}})));
  Buildings.ThermalZones.Detailed.MixedAir sta(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=2698/hRoo,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=0,
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={360.0785/hRoo,262.52},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=0,
    nSurBou=4,
    surBou(
      A={40.76,24.13,40.76,24.13}*hRoo,
      each absIR=0.9,
      each absSol=0.9,
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,
          Buildings.Types.Tilt.Wall}),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "Stairs zone"
    annotation (Placement(transformation(extent={{-194,56},{-154,96}})));
  Buildings.ThermalZones.Detailed.MixedAir res(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=2698/hRoo,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=0,
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={360.0785/hRoo,262.52},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=0,
    nSurBou=4,
    surBou(
      A={40.76,24.13,40.76,24.13}*hRoo,
      each absIR=0.9,
      each absSol=0.9,
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,
          Buildings.Types.Tilt.Wall}),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "Restroom zone"
    annotation (Placement(transformation(extent={{46,96},{86,136}})));
  Buildings.ThermalZones.Detailed.MixedAir sto(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=2698/hRoo,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=0,
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={360.0785/hRoo,262.52},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=0,
    nSurBou=4,
    surBou(
      A={40.76,24.13,40.76,24.13}*hRoo,
      each absIR=0.9,
      each absSol=0.9,
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,
          Buildings.Types.Tilt.Wall}),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "Storage zone"
    annotation (Placement(transformation(extent={{-14,56},{26,96}})));
  Buildings.ThermalZones.Detailed.MixedAir equ(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=2698/hRoo,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=0,
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={360.0785/hRoo,262.52},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=0,
    nSurBou=4,
    surBou(
      A={40.76,24.13,40.76,24.13}*hRoo,
      each absIR=0.9,
      each absSol=0.9,
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,
          Buildings.Types.Tilt.Wall}),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "Mechanical or electrical equipment zone"
    annotation (Placement(transformation(extent={{-14,158},{26,198}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-240,368},{-200,408}}), iconTransformation(
          extent={{-78,96},{-58,116}})));
  Modelica.Blocks.Routing.Multiplex6 multiplex6_1
    annotation (Placement(transformation(extent={{340,100},{360,120}})));
  Modelica.Blocks.Interfaces.RealOutput TRooAir1[6](each unit="K", each
      displayUnit="degC")    "Room air temperatures"
    annotation (Placement(transformation(extent={{400,100},{420,120}}),
        iconTransformation(extent={{100,40},{120,60}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temDin
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,170},{312,190}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temSta
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,130},{312,150}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temLob
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,90},{312,110}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temEqu
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,50},{312,70}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temSto
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,10},{312,30}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temRes
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,-30},{312,-10}})));
  Modelica.Blocks.Interfaces.RealInput qGaiOffWes[3](each unit="W/m2")
    "Radiant, convective and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-440,240},{-400,280}}),
        iconTransformation(extent={{-112,94},{-100,106}})));
  Modelica.Blocks.Interfaces.RealInput qGaiOffNor[3](each unit="W/m2")
    "Radiant, convective and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-440,200},{-400,240}}),
        iconTransformation(extent={{-112,74},{-100,86}})));
  Modelica.Blocks.Interfaces.RealInput qGaiConEas[3](each unit="W/m2")
    "Radiant, convective and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-440,170},{-400,210}}),
        iconTransformation(extent={{-112,54},{-100,66}})));
  Modelica.Blocks.Interfaces.RealInput qGaiOffSou[3](each unit="W/m2")
    "Radiant, convective and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-440,130},{-400,170}}),
        iconTransformation(extent={{-112,34},{-100,46}})));
  Modelica.Blocks.Interfaces.RealInput qGaiCor[3](each unit="W/m2")
    "Radiant, convective and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-440,90},{-400,130}}),
        iconTransformation(extent={{-112,14},{-100,26}})));
  Modelica.Blocks.Interfaces.RealInput qGaiDin[3](each unit="W/m2")
    "Radiant, convective and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-440,50},{-400,90}}),
        iconTransformation(extent={{-112,-6},{-100,6}})));
  Modelica.Blocks.Interfaces.RealInput qGaiSta[3](each unit="W/m2")
    "Radiant, convective and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-440,20},{-400,60}}),
        iconTransformation(extent={{-112,-26},{-100,-14}})));
  Modelica.Blocks.Interfaces.RealInput qGaiLob[3](each unit="W/m2")
    "Radiant, convective and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-440,-10},{-400,30}}),
        iconTransformation(extent={{-112,-46},{-100,-34}})));
  Modelica.Blocks.Interfaces.RealInput qGaiEqu[3](each unit="W/m2")
    "Radiant, convective and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-440,-40},{-400,0}}),
        iconTransformation(extent={{-112,-66},{-100,-54}})));
  Modelica.Blocks.Interfaces.RealInput qGaiSto[3](each unit="W/m2")
    "Radiant, convective and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-440,-70},{-400,-30}}),
        iconTransformation(extent={{-112,-86},{-100,-74}})));
  Modelica.Blocks.Interfaces.RealInput qGaiRes[3](each unit="W/m2")
    "Radiant, convective and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-440,-100},{-400,-60}}),
        iconTransformation(extent={{-112,-106},{-100,-94}})));
equation
  connect(sou.surf_conBou[1], offWes.surf_surBou[2]) annotation (Line(
      points={{-68,-80.6667},{-68,-86},{-290,-86},{-290,-12},{-289.8,-12},{
          -289.8,74.5}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sou.surf_conBou[2], cor.surf_surBou[1]) annotation (Line(
      points={{-68,-80},{-68,-86},{204,-86},{204,204},{-77.8,204},{-77.8,215.25}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sou.surf_conBou[3], conEas.surf_surBou[1]) annotation (Line(
      points={{-68,-79.3333},{-68,-86},{162,-86},{162,6},{162.2,6},{162.2,99.5}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(conEas.surf_conBou[1], cor.surf_surBou[2]) annotation (Line(
      points={{172,98},{172,90},{198,90},{198,204},{-77.8,204},{-77.8,215.75}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(conEas.surf_surBou[2], offNor.surf_conBou[1]) annotation (Line(
      points={{162.2,100.5},{162.2,92},{110,92},{110,286},{-68,286},{-68,
          311.333}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(offNor.surf_conBou[2], cor.surf_surBou[3]) annotation (Line(
      points={{-68,312},{-68,286},{26,286},{26,204},{-77.8,204},{-77.8,216.25}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(offNor.surf_conBou[3], offWes.surf_surBou[1]) annotation (Line(
      points={{-68,312.667},{-68,286},{-320,286},{-320,60},{-289.8,60},{-289.8,
          73.5}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(multiplex5_1.y, TRooAir) annotation (Line(
      points={{361,290},{410,290}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(temOffWes.T, multiplex5_1.u1[1]) annotation (Line(
      points={{312,380},{328,380},{328,300},{338,300}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(temOffNor.T, multiplex5_1.u2[1]) annotation (Line(
      points={{312,340},{324,340},{324,295},{338,295}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(temConEas.T, multiplex5_1.u3[1]) annotation (Line(
      points={{312,300},{326,300},{326,290},{338,290}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(temOffSou.T, multiplex5_1.u4[1]) annotation (Line(
      points={{312,260},{324,260},{324,285},{338,285}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(temCor.T, multiplex5_1.u5[1]) annotation (Line(
      points={{312,220},{332,220},{332,280},{338,280}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(offWes.surf_conBou[1], cor.surf_surBou[4]) annotation (Line(points={{
          -280,72},{-280,60},{-320,60},{-320,204},{-80,204},{-80,216.75},{-77.8,
          216.75}}, color={191,0,0}));
  connect(leaSou.weaBus, weaBus) annotation (Line(
      points={{-356,460},{-368,460},{-368,480},{-220,480},{-220,388}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(leaSou.weaBus, leaEas.weaBus) annotation (Line(
      points={{-356,460},{-368,460},{-368,420},{-356,420}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot));
  connect(leaNor.weaBus, leaEas.weaBus) annotation (Line(
      points={{-356,380},{-368,380},{-368,420},{-356,420}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot));
  connect(leaWes.weaBus, leaEas.weaBus) annotation (Line(
      points={{-356,340},{-368,340},{-368,420},{-356,420}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot));
  connect(out.weaBus, leaEas.weaBus) annotation (Line(
      points={{-348,292.2},{-368,292.2},{-368,420},{-356,420}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot));
  connect(weaBus, offNor.weaBus) annotation (Line(
      points={{-220,388},{-56.1,388},{-56.1,345.9}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(cor.weaBus, offNor.weaBus) annotation (Line(
      points={{-56.1,247.9},{-56.1,345.9}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot));
  connect(cor.weaBus, equ.weaBus) annotation (Line(
      points={{-56.1,247.9},{-18,247.9},{-18,248},{22,248},{22,195.9},{23.9,195.9}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot));

  connect(cor.weaBus, res.weaBus) annotation (Line(
      points={{-56.1,247.9},{83.9,247.9},{83.9,133.9}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot));
  connect(cor.weaBus, conEas.weaBus) annotation (Line(
      points={{-56.1,247.9},{183.9,247.9},{183.9,131.9}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot));
  connect(sto.weaBus, equ.weaBus) annotation (Line(
      points={{23.9,93.9},{23.9,195.9}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot));
  connect(lob.weaBus, cor.weaBus) annotation (Line(
      points={{-56.1,153.9},{-56.1,247.9}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot));
  connect(din.weaBus, offNor.weaBus) annotation (Line(
      points={{-156.1,183.9},{-156.1,388},{-56.1,388},{-56.1,345.9}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot));
  connect(sta.weaBus, din.weaBus) annotation (Line(
      points={{-156.1,93.9},{-156.1,183.9}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot));
  connect(sou.weaBus, lob.weaBus) annotation (Line(
      points={{-56.1,-46.1},{-56.1,153.9}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot));
  connect(leaSou.weaBus, offWes.weaBus) annotation (Line(
      points={{-356,460},{-368,460},{-368,480},{-268.1,480},{-268.1,105.9}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dot));
  connect(out.ports[1], senRelPre.port_b)   annotation (Line(points={{-328,292},
          {-320,292},{-320,320},{-228,320}},                                                 color={0,127,
          255},
      pattern=LinePattern.Dot));
  connect(senRelPre.port_a, lob.ports[1]) annotation (Line(points={{-208,320},{
          -136,320},{-136,126},{-89,126}},
                                      color={0,127,255},
      pattern=LinePattern.Dot));
  connect(multiplex6_1.y, TRooAir1)  annotation (Line(points={{361,110},{410,110}}, color={0,0,127},
      pattern=LinePattern.Dash));

  connect(temDin.T, multiplex6_1.u1[1]) annotation (Line(
      points={{312,180},{330,180},{330,118.5},{338.8,118.5}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temSta.T, multiplex6_1.u2[1]) annotation (Line(
      points={{312,140},{326,140},{326,115.1},{338.8,115.1}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temLob.T, multiplex6_1.u3[1]) annotation (Line(
      points={{312,100},{322,100},{322,112},{330,112},{330,111.7},{338.8,111.7}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(temEqu.T, multiplex6_1.u4[1]) annotation (Line(
      points={{312,60},{324,60},{324,108},{332,108},{332,108.3},{338.8,108.3}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(temSto.T, multiplex6_1.u5[1]) annotation (Line(
      points={{312,20},{328,20},{328,104.9},{338.8,104.9}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temRes.T, multiplex6_1.u6[1]) annotation (Line(
      points={{312,-20},{334,-20},{334,101.5},{338.8,101.5}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(qGaiOffWes, offWes.qGai_flow) annotation (Line(
      points={{-420,260},{-360,260},{-360,96},{-307.6,96}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(qGaiOffNor, offNor.qGai_flow) annotation (Line(
      points={{-420,220},{-300,220},{-300,336},{-95.6,336}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(qGaiConEas, conEas.qGai_flow) annotation (Line(
      points={{-420,190},{-366,190},{-366,52},{130,52},{130,122},{144.4,122}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(qGaiOffSou, sou.qGai_flow) annotation (Line(
      points={{-420,150},{-380,150},{-380,-56},{-95.6,-56}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(qGaiCor, cor.qGai_flow) annotation (Line(
      points={{-420,110},{-342,110},{-342,238},{-95.6,238}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(qGaiDin, din.qGai_flow) annotation (Line(
      points={{-420,70},{-334,70},{-334,174},{-195.6,174}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(qGaiSta, sta.qGai_flow) annotation (Line(
      points={{-420,40},{-214,40},{-214,84},{-195.6,84}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(qGaiLob, lob.qGai_flow) annotation (Line(
      points={{-420,10},{-122,10},{-122,144},{-95.6,144}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(qGaiEqu, equ.qGai_flow) annotation (Line(
      points={{-420,-20},{-38,-20},{-38,186},{-15.6,186}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(qGaiSto, sto.qGai_flow) annotation (Line(
      points={{-420,-50},{-114,-50},{-114,84},{-15.6,84}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(qGaiRes, res.qGai_flow) annotation (Line(
      points={{-420,-80},{-162,-80},{-162,-92},{34,-92},{34,124},{44.4,124}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(offWes.heaPorAir, temOffWes.port) annotation (Line(
      points={{-287,88},{-286,88},{-286,404},{260,404},{260,380},{292,380}},
      color={191,0,0},
      pattern=LinePattern.Dot));
  connect(offNor.heaPorAir, temOffNor.port) annotation (Line(
      points={{-75,328},{260,328},{260,340},{292,340}},
      color={191,0,0},
      pattern=LinePattern.Dot));
  connect(conEas.heaPorAir, temConEas.port) annotation (Line(
      points={{165,114},{164,114},{164,300},{292,300}},
      color={191,0,0},
      pattern=LinePattern.Dot));
  connect(sou.heaPorAir, temOffSou.port) annotation (Line(
      points={{-75,-64},{260,-64},{260,260},{292,260}},
      color={191,0,0},
      pattern=LinePattern.Dot));
  connect(cor.heaPorAir, temCor.port) annotation (Line(
      points={{-75,230},{92,230},{92,232},{260,232},{260,220},{292,220}},
      color={191,0,0},
      pattern=LinePattern.Dot));
  connect(din.heaPorAir, temDin.port) annotation (Line(
      points={{-175,166},{-146,166},{-146,256},{260,256},{260,180},{292,180}},
      color={191,0,0},
      pattern=LinePattern.Dot));
  connect(sta.heaPorAir, temSta.port) annotation (Line(
      points={{-175,76},{-146,76},{-146,256},{260,256},{260,140},{292,140}},
      color={191,0,0},
      pattern=LinePattern.Dot));
  connect(lob.heaPorAir, temLob.port) annotation (Line(
      points={{-75,136},{-48,136},{-48,18},{260,18},{260,100},{292,100}},
      color={191,0,0},
      pattern=LinePattern.Dot));
  connect(equ.heaPorAir, temEqu.port) annotation (Line(
      points={{5,178},{244,178},{244,60},{292,60}},
      color={191,0,0},
      pattern=LinePattern.Dot));
  connect(sto.heaPorAir, temSto.port) annotation (Line(
      points={{5,76},{260,76},{260,20},{292,20}},
      color={191,0,0},
      pattern=LinePattern.Dot));
  connect(res.heaPorAir, temRes.port) annotation (Line(
      points={{65,116},{106,116},{106,-20},{292,-20}},
      color={191,0,0},
      pattern=LinePattern.Dot));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-400,-100},
            {400,500}},
        initialScale=0.1)),     Icon(coordinateSystem(
          preserveAspectRatio=true), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<ul>
<li>
May 1, 2013, by Michael Wetter:<br/>
Declared the parameter record to be a parameter, as declaring its elements
to be parameters does not imply that the whole record has the variability of a parameter.
</li>
</ul>
</html>"));
end FloorElevenZone;
