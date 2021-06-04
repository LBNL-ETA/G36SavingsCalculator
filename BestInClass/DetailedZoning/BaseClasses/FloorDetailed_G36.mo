within BestInClass.DetailedZoning.BaseClasses;
model FloorDetailed_G36
  "Model of a floor of the building with detailed zoning for G36"

  parameter String idfFile=idfFile;
  parameter String weaFile=weaFile;
  parameter Modelica.SIunits.MassFlowRate m_flow_zone[:]
    "Nominal mass flowrate of each zone";
  parameter Modelica.SIunits.MassFlowRate m_flow_sys
    "Nominal mass flowrate of the system";
  parameter Modelica.SIunits.VolumeFlowRate VPriSysMax_flow=m_flow_sys/1.2
    "Maximum expected system primary airflow rate at design stage";
  parameter Modelica.SIunits.VolumeFlowRate minZonPriFlo[numZon]={
    zoneVAV1.conVAVRoo.VDisSetMin_flow,zoneVAV2.conVAVRoo.VDisSetMin_flow,zoneVAV3.conVAVRoo.VDisSetMin_flow,
    zoneVAV4.conVAVRoo.VDisSetMin_flow,zoneVAV5.conVAVRoo.VDisSetMin_flow,zoneVAV6.conVAVRoo.VDisSetMin_flow,
    zoneVAV7.conVAVRoo.VDisSetMin_flow,zoneVAV8.conVAVRoo.VDisSetMin_flow,zoneVAV9.conVAVRoo.VDisSetMin_flow,
    zoneVAV10.conVAVRoo.VDisSetMin_flow,zoneVAV11.conVAVRoo.VDisSetMin_flow,zoneVAV12.conVAVRoo.VDisSetMin_flow,
    zoneVAV13.conVAVRoo.VDisSetMin_flow,zoneVAV14.conVAVRoo.VDisSetMin_flow,zoneVAV15.conVAVRoo.VDisSetMin_flow,
    zoneVAV16.conVAVRoo.VDisSetMin_flow,zoneVAV17.conVAVRoo.VDisSetMin_flow,zoneVAV18.conVAVRoo.VDisSetMin_flow,
    zoneVAV19.conVAVRoo.VDisSetMin_flow,zoneVAV20.conVAVRoo.VDisSetMin_flow,zoneVAV21.conVAVRoo.VDisSetMin_flow}
    "Minimum expected zone primary flow rate";
  parameter Integer numZon = 21 "Number of zones";

  parameter Modelica.SIunits.VolumeFlowRate VDisSetMin_flow[numZon];

  parameter Modelica.SIunits.Volume Vzone1=99.26;
  parameter Modelica.SIunits.Volume Vzone2=88.4;
  parameter Modelica.SIunits.Volume Vzone3=88.4;
  parameter Modelica.SIunits.Volume Vzone4=36.33;
  parameter Modelica.SIunits.Volume Vzone5=118.25;
  parameter Modelica.SIunits.Volume Vzone6=118.25;
  parameter Modelica.SIunits.Volume Vzone7=204.21;
  parameter Modelica.SIunits.Volume Vzone8=204.21;
  parameter Modelica.SIunits.Volume Vzone9=62.94;
  parameter Modelica.SIunits.Volume Vzone10=345.09;
  parameter Modelica.SIunits.Volume Vzone11=345.09;
  parameter Modelica.SIunits.Volume Vzone12=115.56;
  parameter Modelica.SIunits.Volume Vzone13=168.51;
  parameter Modelica.SIunits.Volume Vzone14=136.63;
  parameter Modelica.SIunits.Volume Vzone15=483.66;
  parameter Modelica.SIunits.Volume Vzone16=494.9;
  parameter Modelica.SIunits.Volume Vzone17=532.47;
  parameter Modelica.SIunits.Volume Vzone18=581.35;
  parameter Modelica.SIunits.Volume Vzone19=163.79;
  parameter Modelica.SIunits.Volume Vzone20=84.23;
  parameter Modelica.SIunits.Volume Vzone21=84.23;

  parameter Modelica.SIunits.MassFlowRate m_flow_zone1=m_flow_zone[1];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone2=m_flow_zone[2];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone3=m_flow_zone[3];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone4=m_flow_zone[4];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone5=m_flow_zone[5];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone6=m_flow_zone[6];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone7=m_flow_zone[7];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone8=m_flow_zone[8];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone9=m_flow_zone[9];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone10=m_flow_zone[10];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone11=m_flow_zone[11];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone12=m_flow_zone[12];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone13=m_flow_zone[13];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone14=m_flow_zone[14];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone15=m_flow_zone[15];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone16=m_flow_zone[16];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone17=m_flow_zone[17];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone18=m_flow_zone[18];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone19=m_flow_zone[19];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone20=m_flow_zone[20];
  parameter Modelica.SIunits.MassFlowRate m_flow_zone21=m_flow_zone[21];

  parameter Modelica.SIunits.Area Azone1=36.19;
  parameter Modelica.SIunits.Area Azone2=32.22;
  parameter Modelica.SIunits.Area Azone3=32.22;
  parameter Modelica.SIunits.Area Azone4=13.24;
  parameter Modelica.SIunits.Area Azone5=43.11;
  parameter Modelica.SIunits.Area Azone6=43.11;
  parameter Modelica.SIunits.Area Azone7=74.44;
  parameter Modelica.SIunits.Area Azone8=74.44;
  parameter Modelica.SIunits.Area Azone9=22.94;
  parameter Modelica.SIunits.Area Azone10=125.8;
  parameter Modelica.SIunits.Area Azone11=125.8;
  parameter Modelica.SIunits.Area Azone12=42.13;
  parameter Modelica.SIunits.Area Azone13=61.43;
  parameter Modelica.SIunits.Area Azone14=49.81;
  parameter Modelica.SIunits.Area Azone15=176.31;
  parameter Modelica.SIunits.Area Azone16=180.41;
  parameter Modelica.SIunits.Area Azone17=194.1;
  parameter Modelica.SIunits.Area Azone18=211.92;
  parameter Modelica.SIunits.Area Azone19=59.71;
  parameter Modelica.SIunits.Area Azone20=30.71;
  parameter Modelica.SIunits.Area Azone21=30.71;

  parameter Modelica.SIunits.Area AFlo[numZon]={
      Azone1,Azone2,Azone3,Azone4,Azone5,Azone6,Azone7,
      Azone8,Azone9,Azone10,Azone11,Azone12,Azone13,Azone14,
      Azone15,Azone16,Azone17,Azone18,Azone19,Azone20,Azone21}
    "Floor area of each zone";

  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone1=
     m_flow_sys-m_flow_zone1;
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone2=
     m_flow_sys-(m_flow_zone1+m_flow_zone2);
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone3=
     m_flow_sys-(m_flow_zone1+m_flow_zone2+m_flow_zone3);
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone4=
     m_flow_sys-(m_flow_zone1+m_flow_zone2+m_flow_zone3+m_flow_zone4);
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone5=
     m_flow_sys-(m_flow_zone1+m_flow_zone2+m_flow_zone3+m_flow_zone4+m_flow_zone5);
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone6=
     m_flow_sys-(m_flow_zone1+m_flow_zone2+m_flow_zone3+m_flow_zone4+m_flow_zone5+m_flow_zone6);
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone7=
     m_flow_sys-(m_flow_zone1+m_flow_zone2+m_flow_zone3+m_flow_zone4+m_flow_zone5+m_flow_zone6+m_flow_zone7);
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone8=
     m_flow_sys-(m_flow_zone1+m_flow_zone2+m_flow_zone3+m_flow_zone4+m_flow_zone5+m_flow_zone6+m_flow_zone7+m_flow_zone8);
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone9=
     m_flow_sys-(m_flow_zone1+m_flow_zone2+m_flow_zone3+m_flow_zone4+m_flow_zone5+m_flow_zone6+m_flow_zone7+m_flow_zone8+m_flow_zone9);
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone10=
     m_flow_sys-(m_flow_zone1+m_flow_zone2+m_flow_zone3+m_flow_zone4+m_flow_zone5+m_flow_zone6+m_flow_zone7+m_flow_zone8+m_flow_zone9+m_flow_zone10);
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone11=
     m_flow_zone12+m_flow_zone13+m_flow_zone14+m_flow_zone15+m_flow_zone16+m_flow_zone16+m_flow_zone17+m_flow_zone18+m_flow_zone19+m_flow_zone20+m_flow_zone21;
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone12=
     m_flow_zone13+m_flow_zone14+m_flow_zone15+m_flow_zone16+m_flow_zone16+m_flow_zone17+m_flow_zone18+m_flow_zone19+m_flow_zone20+m_flow_zone21;
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone13=
     m_flow_zone14+m_flow_zone15+m_flow_zone16+m_flow_zone16+m_flow_zone17+m_flow_zone18+m_flow_zone19+m_flow_zone20+m_flow_zone21;
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone14=
     m_flow_zone15+m_flow_zone16+m_flow_zone16+m_flow_zone17+m_flow_zone18+m_flow_zone19+m_flow_zone20+m_flow_zone21;
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone15=
     m_flow_zone16+m_flow_zone16+m_flow_zone17+m_flow_zone18+m_flow_zone19+m_flow_zone20+m_flow_zone21;
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone16=
     m_flow_zone16+m_flow_zone17+m_flow_zone18+m_flow_zone19+m_flow_zone20+m_flow_zone21;
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone17=
     m_flow_zone18+m_flow_zone19+m_flow_zone20+m_flow_zone21;
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone18=
     m_flow_zone19+m_flow_zone20+m_flow_zone21;
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone19=
     m_flow_zone20+m_flow_zone21;
  parameter Modelica.SIunits.MassFlowRate mSpl_flow_zone20=
     m_flow_zone21;

  package MediumA = Buildings.Media.Air "Medium air";
  parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal";
  parameter Boolean sampleModel = false
    "Set to true to time-sample the model, which can give shorter simulation time if there is already time sampling in the system model"
    annotation (
      Evaluate=true,
      Dialog(tab="Experimental (may be changed in future releases)"));

  Modelica.Blocks.Interfaces.RealInput TRooHeaSet(unit="K",displayUnit="degC")
    "Room heating setpoint" annotation (Placement(transformation(extent={{-412,24},
            {-380,56}}),     iconTransformation(extent={{-120,20},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput TRooCooSet(unit="K",displayUnit="degC")
    "Room cooling setpoint" annotation (Placement(transformation(extent={{-412,-36},
            {-380,-4}}),      iconTransformation(extent={{-120,-10},{-100,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a supplyAir(redeclare final package
      Medium = MediumA) "Supply air"
    annotation (Placement(transformation(extent={{-390,70},{-370,90}}),
        iconTransformation(extent={{-110,70},{-90,90}})));
  Modelica.Fluid.Interfaces.FluidPort_b returnAir(redeclare final package
      Medium = MediumA) "Return air"
    annotation (Placement(transformation(extent={{-390,-130},{-370,-110}}),
        iconTransformation(extent={{-110,-92},{-90,-72}})));
  inner Buildings.ThermalZones.EnergyPlus.Building building(idfName=
        Modelica.Utilities.Files.loadResource(idfFile), weaName=
        Modelica.Utilities.Files.loadResource(weaFile))
    annotation (Placement(transformation(extent={{-320,70},{-300,90}})));
  ZoneVAV_G36 zoneVAV1(
    zoneName="ActiveStorage_Mid_1 ZN",
    mSpl_flow_nominal=mSpl_flow_zone1,
    mRoo_flow_nominal=m_flow_zone1,
    VDisSetMin_flow=VDisSetMin_flow[1],
    VRoo=Vzone1,
    AFlo=Azone1,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-340,0},{-320,20}})));
  ZoneVAV_G36 zoneVAV2(
    zoneName="ActiveStorage_Mid_2 ZN",
    mSpl_flow_nominal=mSpl_flow_zone2,
    mRoo_flow_nominal=m_flow_zone2,
    VDisSetMin_flow=VDisSetMin_flow[2],
    VRoo=Vzone2,
    AFlo=Azone2,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-300,0},{-280,20}})));

  ZoneVAV_G36 zoneVAV3(
    zoneName="ActiveStorage_Mid_3 ZN",
    mSpl_flow_nominal=mSpl_flow_zone3,
    mRoo_flow_nominal=m_flow_zone3,
    VDisSetMin_flow=VDisSetMin_flow[3],
    VRoo=Vzone3,
    AFlo=Azone3,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-260,0},{-240,20}})));

  ZoneVAV_G36 zoneVAV4(
    zoneName="ActiveStorage_Mid_4 ZN",
    mSpl_flow_nominal=mSpl_flow_zone4,
    mRoo_flow_nominal=m_flow_zone4,
    VDisSetMin_flow=VDisSetMin_flow[4],
    VRoo=Vzone4,
    AFlo=Azone4,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-220,0},{-200,20}})));

  ZoneVAV_G36 zoneVAV5(
    zoneName="ConfRoom_Mid_1 ZN",
    mRoo_flow_nominal=m_flow_zone5,
    mSpl_flow_nominal=mSpl_flow_zone5,
    VDisSetMin_flow=VDisSetMin_flow[5],
    VRoo=Vzone5,
    AFlo=Azone5,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-180,0},{-160,20}})));

  ZoneVAV_G36 zoneVAV6(
    zoneName="ConfRoom_Mid_2 ZN",
    mRoo_flow_nominal=m_flow_zone6,
    mSpl_flow_nominal=mSpl_flow_zone6,
    VDisSetMin_flow=VDisSetMin_flow[6],
    VRoo=Vzone6,
    AFlo=Azone6,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));

  ZoneVAV_G36 zoneVAV7(
    zoneName="Corridor_Mid_1 ZN",
    mRoo_flow_nominal=m_flow_zone7,
    mSpl_flow_nominal=mSpl_flow_zone7,
    VDisSetMin_flow=VDisSetMin_flow[7],
    VRoo=Vzone7,
    AFlo=Azone7,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));

  ZoneVAV_G36 zoneVAV8(
    zoneName="Corridor_Mid_2 ZN",
    mRoo_flow_nominal=m_flow_zone8,
    mSpl_flow_nominal=mSpl_flow_zone8,
    VDisSetMin_flow=VDisSetMin_flow[8],
    VRoo=Vzone8,
    AFlo=Azone8,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));

  ZoneVAV_G36 zoneVAV9(
    zoneName="Dining_Mid ZN",
    mRoo_flow_nominal=m_flow_zone9,
    mSpl_flow_nominal=mSpl_flow_zone9,
    VDisSetMin_flow=VDisSetMin_flow[9],
    VRoo=Vzone9,
    AFlo=Azone9,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));

  ZoneVAV_G36 zoneVAV10(
    zoneName="EnclosedOffice_Mid_1 ZN",
    mRoo_flow_nominal=m_flow_zone10,
    mSpl_flow_nominal=mSpl_flow_zone10,
    VDisSetMin_flow=VDisSetMin_flow[10],
    VRoo=Vzone10,
    AFlo=Azone10,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));

  ZoneVAV_G36 zoneVAV11(
    zoneName="EnclosedOffice_Mid_2 ZN",
    mRoo_flow_nominal=m_flow_zone11,
    mSpl_flow_nominal=mSpl_flow_zone11,
    VDisSetMin_flow=VDisSetMin_flow[11],
    VRoo=Vzone11,
    AFlo=Azone11,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{60,0},{80,20}})));

  ZoneVAV_G36 zoneVAV12(
    zoneName="EnclosedOffice_Mid_3 ZN",
    mRoo_flow_nominal=m_flow_zone12,
    mSpl_flow_nominal=mSpl_flow_zone12,
    VDisSetMin_flow=VDisSetMin_flow[12],
    VRoo=Vzone12,
    AFlo=Azone12,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{100,0},{120,20}})));

  ZoneVAV_G36 zoneVAV13(
    zoneName="Lobby_Mid ZN",
    mRoo_flow_nominal=m_flow_zone13,
    mSpl_flow_nominal=mSpl_flow_zone13,
    VDisSetMin_flow=VDisSetMin_flow[13],
    VRoo=Vzone13,
    AFlo=Azone13,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{140,0},{160,20}})));

  ZoneVAV_G36 zoneVAV14(
    zoneName="Mechanical_Mid ZN",
    mRoo_flow_nominal=m_flow_zone14,
    mSpl_flow_nominal=mSpl_flow_zone14,
    VDisSetMin_flow=VDisSetMin_flow[14],
    VRoo=Vzone14,
    AFlo=Azone14,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{180,0},{200,20}})));

  ZoneVAV_G36 zoneVAV15(
    zoneName="OpenOffice_Mid_1 ZN",
    mRoo_flow_nominal=m_flow_zone15,
    mSpl_flow_nominal=mSpl_flow_zone15,
    VDisSetMin_flow=VDisSetMin_flow[15],
    VRoo=Vzone15,
    AFlo=Azone15,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{220,0},{240,20}})));

  ZoneVAV_G36 zoneVAV16(
    zoneName="OpenOffice_Mid_2 ZN",
    mRoo_flow_nominal=m_flow_zone16,
    mSpl_flow_nominal=mSpl_flow_zone16,
    VDisSetMin_flow=VDisSetMin_flow[16],
    VRoo=Vzone16,
    AFlo=Azone16,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{260,0},{280,20}})));

  ZoneVAV_G36 zoneVAV17(
    zoneName="OpenOffice_Mid_3 ZN",
    mRoo_flow_nominal=m_flow_zone17,
    mSpl_flow_nominal=mSpl_flow_zone17,
    VDisSetMin_flow=VDisSetMin_flow[17],
    VRoo=Vzone17,
    AFlo=Azone17,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{300,0},{320,20}})));

  ZoneVAV_G36 zoneVAV18(
    zoneName="OpenOffice_Mid_4 ZN",
    mRoo_flow_nominal=m_flow_zone18,
    mSpl_flow_nominal=mSpl_flow_zone18,
    VDisSetMin_flow=VDisSetMin_flow[18],
    VRoo=Vzone18,
    AFlo=Azone18,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{340,0},{360,20}})));

  ZoneVAV_G36 zoneVAV19(
    zoneName="Restroom_Mid ZN",
    mRoo_flow_nominal=m_flow_zone19,
    mSpl_flow_nominal=mSpl_flow_zone19,
    VDisSetMin_flow=VDisSetMin_flow[19],
    VRoo=Vzone19,
    AFlo=Azone19,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{380,0},{400,20}})));

  ZoneVAV_G36 zoneVAV20(
    zoneName="Stair_Mid_1 ZN",
    mRoo_flow_nominal=m_flow_zone20,
    mSpl_flow_nominal=mSpl_flow_zone20,
    VDisSetMin_flow=VDisSetMin_flow[20],
    VRoo=Vzone20,
    AFlo=Azone20,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{420,0},{440,20}})));

  ZoneVAVLast_G36 zoneVAV21(
    zoneName="Stair_Mid_2 ZN",
    mRoo_flow_nominal=m_flow_zone21,
    VDisSetMin_flow=VDisSetMin_flow[21],
    VRoo=Vzone21,
    AFlo=Azone21,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{460,0},{480,20}})));

  Modelica.Blocks.Interfaces.RealInput TSupAHU "Supply air temperature"
    annotation (Placement(transformation(extent={{-412,-64},{-380,-32}}),
        iconTransformation(extent={{-120,-40},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uOpeMod
    "Zone operation mode"
    annotation (Placement(transformation(extent={{-412,-96},{-380,-64}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yZonTemResReq[numZon]
    "Zone cooling supply air temperature reset request"
    annotation (Placement(transformation(extent={{540,-86},{560,-66}}),
        iconTransformation(extent={{100,-46},{140,-6}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yZonPreResReq[numZon]
    "Zone static pressure reset requests"
    annotation (Placement(transformation(extent={{540,-130},{560,-110}}),
        iconTransformation(extent={{100,-70},{140,-30}})));
  Modelica.Blocks.Interfaces.RealOutput TRooAir[numZon] "Zone air temperature"
    annotation (Placement(transformation(extent={{540,70},{560,90}}),
        iconTransformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput VDis[numZon] "Discharge air flow"
    annotation (Placement(transformation(extent={{540,8},{560,28}}),
        iconTransformation(extent={{100,14},{120,34}})));
  Modelica.Blocks.Interfaces.RealOutput TDis[numZon] "Discharge air temperature"
    annotation (Placement(transformation(extent={{540,-46},{560,-26}}),
        iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput qGaiFlo[3,21](unit="W/m2")
    "Internal heat gains" annotation (Placement(transformation(extent={{-412,44},
            {-380,76}}), iconTransformation(extent={{-120,50},{-100,70}})));
equation

  connect(TRooHeaSet, zoneVAV1.TRooHeaSet) annotation (Line(
      points={{-396,40},{-362,40},{-362,15},{-341,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(TRooCooSet, zoneVAV1.TRooCooSet) annotation (Line(
      points={{-396,-20},{-368,-20},{-368,12},{-341,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{-396,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV3.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{-261,15},{-268,15},{-268,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV4.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{-221,15},{-226,15},{-226,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV5.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{-181,15},{-186,15},{-186,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV6.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{-141,15},{-144,15},{-144,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV7.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{-101,15},{-106,15},{-106,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV8.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{-61,15},{-68,15},{-68,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV9.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{-21,15},{-26,15},{-26,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV10.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{19,15},{16,15},{16,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV11.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{59,15},{50,15},{50,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV12.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{99,15},{92,15},{92,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV13.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{139,15},{132,15},{132,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV14.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{179,15},{172,15},{172,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV15.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{219,15},{214,15},{214,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV16.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{259,15},{252,15},{252,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV17.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{299,15},{294,15},{294,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV18.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{339,15},{334,15},{334,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV19.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{379,15},{374,15},{374,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV20.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{419,15},{412,15},{412,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV21.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(
      points={{459,14},{452,14},{452,40},{-308,40},{-308,15},{-301,15}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(TRooCooSet, zoneVAV2.TRooCooSet) annotation (Line(
      points={{-396,-20},{-310,-20},{-310,12},{-301,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(TRooCooSet, zoneVAV3.TRooCooSet) annotation (Line(
      points={{-396,-20},{-272,-20},{-272,12},{-261,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{-396,-20},
          {450,-20},{450,12},{459,12}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV4.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{-221,12},{-228,12},{-228,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV5.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{-181,12},{-188,12},{-188,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV6.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{-141,12},{-148,12},{-148,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV7.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{-101,12},{-108,12},{-108,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV8.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{-61,12},{-68,12},{-68,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV9.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{-21,12},{-28,12},{-28,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV10.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{19,12},{12,12},{12,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV11.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{59,12},{52,12},{52,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV12.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{99,12},{92,12},{92,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV13.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{139,12},{132,12},{132,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV14.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{179,12},{172,12},{172,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV15.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{219,12},{212,12},{212,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV16.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{259,12},{252,12},{252,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV17.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{299,12},{292,12},{292,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV18.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{339,12},{332,12},{332,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV19.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{379,12},{372,12},{372,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV20.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(
      points={{419,12},{412,12},{412,-20},{450,-20},{450,12},{459,12}},
      color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV1.returnAir1, zoneVAV2.supplyAir1)
    annotation (Line(points={{-320,18},{-300,18}}, color={0,127,255}));
  connect(zoneVAV1.supplyAir, zoneVAV2.returnAir)
    annotation (Line(points={{-320,2},{-300,2}}, color={0,127,255}));
  connect(zoneVAV2.returnAir1, zoneVAV3.supplyAir1)
    annotation (Line(points={{-280,18},{-260,18}}, color={0,127,255}));
  connect(zoneVAV2.supplyAir, zoneVAV3.returnAir)
    annotation (Line(points={{-280,2},{-260,2}}, color={0,127,255}));
  connect(zoneVAV3.returnAir1, zoneVAV4.supplyAir1)
    annotation (Line(points={{-240,18},{-220,18}}, color={0,127,255}));
  connect(zoneVAV3.supplyAir, zoneVAV4.returnAir)
    annotation (Line(points={{-240,2},{-220,2}}, color={0,127,255}));
  connect(zoneVAV4.returnAir1, zoneVAV5.supplyAir1)
    annotation (Line(points={{-200,18},{-180,18}}, color={0,127,255}));
  connect(zoneVAV4.supplyAir, zoneVAV5.returnAir)
    annotation (Line(points={{-200,2},{-180,2}}, color={0,127,255}));
  connect(zoneVAV5.returnAir1, zoneVAV6.supplyAir1)
    annotation (Line(points={{-160,18},{-140,18}}, color={0,127,255}));
  connect(zoneVAV5.supplyAir, zoneVAV6.returnAir)
    annotation (Line(points={{-160,2},{-140,2}}, color={0,127,255}));
  connect(zoneVAV6.returnAir1, zoneVAV7.supplyAir1)
    annotation (Line(points={{-120,18},{-100,18}}, color={0,127,255}));
  connect(zoneVAV6.supplyAir, zoneVAV7.returnAir)
    annotation (Line(points={{-120,2},{-100,2}}, color={0,127,255}));
  connect(zoneVAV7.returnAir1, zoneVAV8.supplyAir1)
    annotation (Line(points={{-80,18},{-60,18}}, color={0,127,255}));
  connect(zoneVAV7.supplyAir, zoneVAV8.returnAir)
    annotation (Line(points={{-80,2},{-60,2}}, color={0,127,255}));
  connect(zoneVAV8.returnAir1, zoneVAV9.supplyAir1)
    annotation (Line(points={{-40,18},{-20,18}}, color={0,127,255}));
  connect(zoneVAV8.supplyAir, zoneVAV9.returnAir)
    annotation (Line(points={{-40,2},{-20,2}}, color={0,127,255}));
  connect(zoneVAV9.returnAir1, zoneVAV10.supplyAir1)
    annotation (Line(points={{0,18},{20,18}}, color={0,127,255}));
  connect(zoneVAV9.supplyAir, zoneVAV10.returnAir)
    annotation (Line(points={{0,2},{20,2}}, color={0,127,255}));
  connect(zoneVAV10.returnAir1, zoneVAV11.supplyAir1)
    annotation (Line(points={{40,18},{60,18}}, color={0,127,255}));
  connect(zoneVAV10.supplyAir, zoneVAV11.returnAir)
    annotation (Line(points={{40,2},{60,2}}, color={0,127,255}));
  connect(zoneVAV11.returnAir1, zoneVAV12.supplyAir1)
    annotation (Line(points={{80,18},{100,18}}, color={0,127,255}));
  connect(zoneVAV11.supplyAir, zoneVAV12.returnAir)
    annotation (Line(points={{80,2},{100,2}}, color={0,127,255}));
  connect(zoneVAV12.returnAir1, zoneVAV13.supplyAir1)
    annotation (Line(points={{120,18},{140,18}}, color={0,127,255}));
  connect(zoneVAV12.supplyAir, zoneVAV13.returnAir)
    annotation (Line(points={{120,2},{140,2}}, color={0,127,255}));
  connect(zoneVAV13.returnAir1, zoneVAV14.supplyAir1)
    annotation (Line(points={{160,18},{180,18}}, color={0,127,255}));
  connect(zoneVAV13.supplyAir, zoneVAV14.returnAir)
    annotation (Line(points={{160,2},{180,2}}, color={0,127,255}));
  connect(zoneVAV14.returnAir1, zoneVAV15.supplyAir1)
    annotation (Line(points={{200,18},{220,18}}, color={0,127,255}));
  connect(zoneVAV14.supplyAir, zoneVAV15.returnAir)
    annotation (Line(points={{200,2},{220,2}}, color={0,127,255}));
  connect(zoneVAV15.returnAir1, zoneVAV16.supplyAir1)
    annotation (Line(points={{240,18},{260,18}}, color={0,127,255}));
  connect(zoneVAV15.supplyAir, zoneVAV16.returnAir)
    annotation (Line(points={{240,2},{260,2}}, color={0,127,255}));
  connect(zoneVAV16.returnAir1, zoneVAV17.supplyAir1)
    annotation (Line(points={{280,18},{300,18}}, color={0,127,255}));
  connect(zoneVAV16.supplyAir, zoneVAV17.returnAir)
    annotation (Line(points={{280,2},{300,2}}, color={0,127,255}));
  connect(zoneVAV17.returnAir1, zoneVAV18.supplyAir1)
    annotation (Line(points={{320,18},{340,18}}, color={0,127,255}));
  connect(zoneVAV17.supplyAir, zoneVAV18.returnAir)
    annotation (Line(points={{320,2},{340,2}}, color={0,127,255}));
  connect(zoneVAV18.returnAir1, zoneVAV19.supplyAir1)
    annotation (Line(points={{360,18},{380,18}}, color={0,127,255}));
  connect(zoneVAV18.supplyAir, zoneVAV19.returnAir)
    annotation (Line(points={{360,2},{380,2}}, color={0,127,255}));
  connect(zoneVAV19.returnAir1, zoneVAV20.supplyAir1)
    annotation (Line(points={{400,18},{420,18}}, color={0,127,255}));
  connect(zoneVAV19.supplyAir, zoneVAV20.returnAir)
    annotation (Line(points={{400,2},{420,2}}, color={0,127,255}));
  connect(zoneVAV20.returnAir1, zoneVAV21.supplyAir1)
    annotation (Line(points={{440,18},{460,18}}, color={0,127,255}));
  connect(zoneVAV20.supplyAir, zoneVAV21.returnAir)
    annotation (Line(points={{440,2},{460,2}}, color={0,127,255}));
  connect(supplyAir, zoneVAV1.supplyAir1) annotation (Line(points={{-380,80},{-352,
          80},{-352,18},{-340,18}}, color={0,127,255}));
  connect(returnAir, zoneVAV1.returnAir) annotation (Line(points={{-380,-120},{-352,
          -120},{-352,2},{-340,2}}, color={0,127,255}));
  connect(TSupAHU, zoneVAV1.TSupAHU) annotation (Line(points={{-396,-48},{-360,-48},
          {-360,8},{-341,8}}, color={0,0,127}));
  connect(TSupAHU, zoneVAV2.TSupAHU) annotation (Line(
      points={{-396,-48},{-306,-48},{-306,8},{-301,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{-396,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV3.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{-261,8},{-266,8},{-266,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV4.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{-221,8},{-226,8},{-226,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV5.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{-181,8},{-186,8},{-186,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV6.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{-141,8},{-146,8},{-146,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV7.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{-101,8},{-106,8},{-106,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV8.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{-61,8},{-66,8},{-66,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV9.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{-21,8},{-26,8},{-26,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV10.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{19,8},{14,8},{14,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV11.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{59,8},{54,8},{54,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV12.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{99,8},{94,8},{94,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV13.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{139,8},{134,8},{134,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV14.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{179,8},{174,8},{174,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV15.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{219,8},{214,8},{214,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV16.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{259,8},{254,8},{254,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV17.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{299,8},{294,8},{294,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV18.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{339,8},{334,8},{334,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV19.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{379,8},{374,8},{374,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV20.TSupAHU, zoneVAV21.TSupAHU) annotation (Line(
      points={{419,8},{414,8},{414,-48},{454,-48},{454,8},{459,8}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{-396,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV20.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{418,5},{416,5},{416,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV19.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{378,5},{376,5},{376,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV18.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{338,5},{336,5},{336,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV17.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{298,5},{296,5},{296,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV16.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{258,5},{256,5},{256,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV15.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{218,5},{216,5},{216,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV14.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{178,5},{176,5},{176,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV13.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{138,5},{136,5},{136,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV12.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{98,5},{96,5},{96,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV11.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{58,5},{56,5},{56,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV10.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{18,5},{16,5},{16,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV9.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{-22,5},{-24,5},{-24,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV8.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{-62,5},{-64,5},{-64,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV7.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{-102,5},{-104,5},{-104,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV6.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{-142,5},{-144,5},{-144,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV5.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{-182,5},{-184,5},{-184,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV4.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{-222,5},{-224,5},{-224,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV3.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{-262,5},{-264,5},{-264,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV2.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{-302,5},{-304,5},{-304,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV1.uOpeMod, zoneVAV21.uOpeMod) annotation (Line(
      points={{-342,5},{-346,5},{-346,-80},{456,-80},{456,5},{458,5}},
      color={255,127,0},
      pattern=LinePattern.Dot));
  connect(zoneVAV1.TRooAir, TRooAir[1]);
  connect(zoneVAV2.TRooAir, TRooAir[2]);
  connect(zoneVAV3.TRooAir, TRooAir[3]);
  connect(zoneVAV4.TRooAir, TRooAir[4]);
  connect(zoneVAV5.TRooAir, TRooAir[5]);
  connect(zoneVAV6.TRooAir, TRooAir[6]);
  connect(zoneVAV20.TRooAir, TRooAir[7]);
  connect(zoneVAV8.TRooAir, TRooAir[8]);
  connect(zoneVAV9.TRooAir, TRooAir[9]);
  connect(zoneVAV10.TRooAir, TRooAir[10]);
  connect(zoneVAV11.TRooAir, TRooAir[11]);
  connect(zoneVAV12.TRooAir, TRooAir[12]);
  connect(zoneVAV13.TRooAir, TRooAir[13]);
  connect(zoneVAV14.TRooAir, TRooAir[14]);
  connect(zoneVAV15.TRooAir, TRooAir[15]);
  connect(zoneVAV16.TRooAir, TRooAir[16]);
  connect(zoneVAV17.TRooAir, TRooAir[17]);
  connect(zoneVAV18.TRooAir, TRooAir[18]);
  connect(zoneVAV19.TRooAir, TRooAir[19]);
  connect(zoneVAV20.TRooAir, TRooAir[20]);
  connect(zoneVAV21.TRooAir, TRooAir[21]);
  connect(zoneVAV1.VDis,VDis[1]);
  connect(zoneVAV2.VDis,VDis[2]);
  connect(zoneVAV3.VDis,VDis[3]);
  connect(zoneVAV4.VDis,VDis[4]);
  connect(zoneVAV5.VDis,VDis[5]);
  connect(zoneVAV6.VDis,VDis[6]);
  connect(zoneVAV20.VDis, VDis[7]);
  connect(zoneVAV8.VDis,VDis[8]);
  connect(zoneVAV9.VDis,VDis[9]);
  connect(zoneVAV10.VDis,VDis[10]);
  connect(zoneVAV11.VDis,VDis[11]);
  connect(zoneVAV12.VDis,VDis[12]);
  connect(zoneVAV13.VDis,VDis[13]);
  connect(zoneVAV14.VDis,VDis[14]);
  connect(zoneVAV15.VDis,VDis[15]);
  connect(zoneVAV16.VDis,VDis[16]);
  connect(zoneVAV17.VDis,VDis[17]);
  connect(zoneVAV18.VDis,VDis[18]);
  connect(zoneVAV19.VDis,VDis[19]);
  connect(zoneVAV20.VDis,VDis[20]);
  connect(zoneVAV21.VDis,VDis[21]);
  connect(zoneVAV1.TDis,TDis[1]);
  connect(zoneVAV2.TDis,TDis[2]);
  connect(zoneVAV3.TDis,TDis[3]);
  connect(zoneVAV4.TDis,TDis[4]);
  connect(zoneVAV5.TDis,TDis[5]);
  connect(zoneVAV6.TDis,TDis[6]);
  connect(zoneVAV20.TDis, TDis[7]);
  connect(zoneVAV8.TDis,TDis[8]);
  connect(zoneVAV9.TDis,TDis[9]);
  connect(zoneVAV10.TDis,TDis[10]);
  connect(zoneVAV11.TDis,TDis[11]);
  connect(zoneVAV12.TDis,TDis[12]);
  connect(zoneVAV13.TDis,TDis[13]);
  connect(zoneVAV14.TDis,TDis[14]);
  connect(zoneVAV15.TDis,TDis[15]);
  connect(zoneVAV16.TDis,TDis[16]);
  connect(zoneVAV17.TDis,TDis[17]);
  connect(zoneVAV18.TDis,TDis[18]);
  connect(zoneVAV19.TDis,TDis[19]);
  connect(zoneVAV20.TDis,TDis[20]);
  connect(zoneVAV21.TDis,TDis[21]);
  connect(zoneVAV1.yZonPreResReq, yZonPreResReq[1]);
  connect(zoneVAV2.yZonPreResReq, yZonPreResReq[2]);
  connect(zoneVAV3.yZonPreResReq, yZonPreResReq[3]);
  connect(zoneVAV4.yZonPreResReq, yZonPreResReq[4]);
  connect(zoneVAV5.yZonPreResReq, yZonPreResReq[5]);
  connect(zoneVAV6.yZonPreResReq, yZonPreResReq[6]);
  connect(zoneVAV20.yZonPreResReq, yZonPreResReq[7]);
  connect(zoneVAV8.yZonPreResReq, yZonPreResReq[8]);
  connect(zoneVAV9.yZonPreResReq, yZonPreResReq[9]);
  connect(zoneVAV10.yZonPreResReq, yZonPreResReq[10]);
  connect(zoneVAV11.yZonPreResReq, yZonPreResReq[11]);
  connect(zoneVAV12.yZonPreResReq, yZonPreResReq[12]);
  connect(zoneVAV13.yZonPreResReq, yZonPreResReq[13]);
  connect(zoneVAV14.yZonPreResReq, yZonPreResReq[14]);
  connect(zoneVAV15.yZonPreResReq, yZonPreResReq[15]);
  connect(zoneVAV16.yZonPreResReq, yZonPreResReq[16]);
  connect(zoneVAV17.yZonPreResReq, yZonPreResReq[17]);
  connect(zoneVAV18.yZonPreResReq, yZonPreResReq[18]);
  connect(zoneVAV19.yZonPreResReq, yZonPreResReq[19]);
  connect(zoneVAV20.yZonPreResReq, yZonPreResReq[20]);
  connect(zoneVAV21.yZonPreResReq, yZonPreResReq[21]);
  connect(zoneVAV1.yZonTemResReq, yZonTemResReq[1]);
  connect(zoneVAV2.yZonTemResReq, yZonTemResReq[2]);
  connect(zoneVAV3.yZonTemResReq, yZonTemResReq[3]);
  connect(zoneVAV4.yZonTemResReq, yZonTemResReq[4]);
  connect(zoneVAV5.yZonTemResReq, yZonTemResReq[5]);
  connect(zoneVAV6.yZonTemResReq, yZonTemResReq[6]);
  connect(zoneVAV20.yZonTemResReq, yZonTemResReq[7]);
  connect(zoneVAV8.yZonTemResReq, yZonTemResReq[8]);
  connect(zoneVAV9.yZonTemResReq, yZonTemResReq[9]);
  connect(zoneVAV10.yZonTemResReq, yZonTemResReq[10]);
  connect(zoneVAV11.yZonTemResReq, yZonTemResReq[11]);
  connect(zoneVAV12.yZonTemResReq, yZonTemResReq[12]);
  connect(zoneVAV13.yZonTemResReq, yZonTemResReq[13]);
  connect(zoneVAV14.yZonTemResReq, yZonTemResReq[14]);
  connect(zoneVAV15.yZonTemResReq, yZonTemResReq[15]);
  connect(zoneVAV16.yZonTemResReq, yZonTemResReq[16]);
  connect(zoneVAV17.yZonTemResReq, yZonTemResReq[17]);
  connect(zoneVAV18.yZonTemResReq, yZonTemResReq[18]);
  connect(zoneVAV19.yZonTemResReq, yZonTemResReq[19]);
  connect(zoneVAV20.yZonTemResReq, yZonTemResReq[20]);
  connect(zoneVAV21.yZonTemResReq, yZonTemResReq[21]);
  connect(qGaiFlo[:, 1], zoneVAV1.qGai_flow);
  connect(qGaiFlo[:, 2], zoneVAV2.qGai_flow);
  connect(qGaiFlo[:, 3], zoneVAV3.qGai_flow);
  connect(qGaiFlo[:, 4], zoneVAV4.qGai_flow);
  connect(qGaiFlo[:, 5], zoneVAV5.qGai_flow);
  connect(qGaiFlo[:, 6], zoneVAV6.qGai_flow);
  connect(qGaiFlo[:, 7], zoneVAV7.qGai_flow);
  connect(qGaiFlo[:, 8], zoneVAV8.qGai_flow);
  connect(qGaiFlo[:, 9], zoneVAV9.qGai_flow);
  connect(qGaiFlo[:, 10], zoneVAV10.qGai_flow);
  connect(qGaiFlo[:, 11], zoneVAV11.qGai_flow);
  connect(qGaiFlo[:, 12], zoneVAV12.qGai_flow);
  connect(qGaiFlo[:, 13], zoneVAV13.qGai_flow);
  connect(qGaiFlo[:, 14], zoneVAV14.qGai_flow);
  connect(qGaiFlo[:, 15], zoneVAV15.qGai_flow);
  connect(qGaiFlo[:, 16], zoneVAV16.qGai_flow);
  connect(qGaiFlo[:, 17], zoneVAV17.qGai_flow);
  connect(qGaiFlo[:, 18], zoneVAV18.qGai_flow);
  connect(qGaiFlo[:, 19], zoneVAV19.qGai_flow);
  connect(qGaiFlo[:, 20], zoneVAV20.qGai_flow);
  connect(qGaiFlo[:, 21], zoneVAV21.qGai_flow);

  annotation (
  defaultComponentName="Building",
  Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-380,-140},
            {540,100}})),       Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                                     graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Polygon(
        points={{-2,92},{-80,50},{78,50},{-2,92}},
        lineColor={95,95,95},
        smooth=Smooth.None,
        fillPattern=FillPattern.Solid,
        fillColor={95,95,95}),
      Rectangle(
        extent={{-66,50},{62,-52}},
        lineColor={150,150,150},
        fillPattern=FillPattern.Solid,
        fillColor={150,150,150}),
      Rectangle(
        extent={{-44,8},{-16,36}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-44,-34},{-16,-6}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{16,-34},{44,-6}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{16,8},{44,36}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
          Bitmap(extent={{-54,-146},{84,-8}},
          fileName="modelica://Buildings/Resources/Images/ThermalZones/EnergyPlus/spawn_icon_darkbluetxmedres.png",
          visible=not usePrecompiledFMU),
                                        Text(
        extent={{-148,146},{152,106}},
        textString="%name",
        lineColor={0,0,255})}),
    Documentation(revisions="<html>
<ul>
<li>
March 17, 2020, by Kun Zhang:<br/>
First implementation.
</li>
</ul>
</html>"));
end FloorDetailed_G36;
