within BestInClass.DetailedZoning.BaseClasses;
model FloorDetailed "Model of a floor of the building with detailed zoning"

  parameter String idfFile=idfFile;
  parameter String weaFile=weaFile;
  parameter Modelica.SIunits.MassFlowRate m_flow_zone[:]
    "Nominal mass flowrate of each zone";
  parameter Modelica.SIunits.MassFlowRate m_flow_sys
    "Nominal mass flowrate of the system";

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
  parameter Boolean sampleModel = true
    "Set to true to time-sample the model, which can give shorter simulation time if there is already time sampling in the system model"
    annotation (
      Evaluate=true,
      Dialog(tab="Experimental (may be changed in future releases)"));

  Modelica.Blocks.Interfaces.RealOutput TRooAve(
    each unit="K", each displayUnit="degC") "Mean room air temperatures" annotation (Placement(
        transformation(extent={{540,-88},{560,-68}}), iconTransformation(extent={{100,-10},
            {120,10}})));
  Modelica.Blocks.Interfaces.RealOutput TRooMin(each unit="K", each displayUnit=
       "degC") "Minimum room air temperatures" annotation (Placement(
        transformation(extent={{540,-118},{560,-98}}), iconTransformation(
          extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealInput TRooHeaSet(unit="K",displayUnit="degC")
    "Room heating setpoint" annotation (Placement(transformation(extent={{-412,12},
            {-380,44}}),     iconTransformation(extent={{-120,10},{-100,30}})));
  Modelica.Blocks.Interfaces.RealInput TRooCooSet(unit="K",displayUnit="degC")
    "Room cooling setpoint" annotation (Placement(transformation(extent={{-412,-36},
            {-380,-4}}),      iconTransformation(extent={{-120,-30},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput minAirFra
    "Minimum zone airflow fraction"
    annotation (Placement(transformation(extent={{-412,-76},{-380,-44}}),
        iconTransformation(extent={{-120,-60},{-100,-40}})));
  Buildings.Utilities.Math.Min min(nin=21) "Computes lowest room temperature"
    annotation (Placement(transformation(extent={{500,-118},{520,-98}})));
  Buildings.Utilities.Math.Average ave(nin=21)
    "Compute average of room temperatures"
    annotation (Placement(transformation(extent={{500,-88},{520,-68}})));
  Modelica.Fluid.Interfaces.FluidPort_a supplyAir(redeclare final package
      Medium = MediumA) "Supply air"
    annotation (Placement(transformation(extent={{-390,70},{-370,90}}),
        iconTransformation(extent={{-110,70},{-90,90}})));
  Modelica.Fluid.Interfaces.FluidPort_b returnAir(redeclare final package
      Medium = MediumA) "Return air"
    annotation (Placement(transformation(extent={{-390,-130},{-370,-110}}),
        iconTransformation(extent={{-110,-92},{-90,-72}})));
  inner Buildings.ThermalZones.EnergyPlus.Building building(
    idfName=Modelica.Utilities.Files.loadResource(idfFile),
    weaName=Modelica.Utilities.Files.loadResource(weaFile))
    annotation (Placement(transformation(extent={{-320,70},{-300,90}})));
  DetailedZoning.BaseClasses.ZoneVAV zoneVAV1(
    zoneName="ActiveStorage_Mid_1 ZN",
    mSpl_flow_nominal=mSpl_flow_zone1,
    mRoo_flow_nominal=m_flow_zone1,
    VRoo=Vzone1,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-340,0},{-320,20}})));
  DetailedZoning.BaseClasses.ZoneVAV zoneVAV2(
    zoneName="ActiveStorage_Mid_2 ZN",
    mSpl_flow_nominal=mSpl_flow_zone2,
    mRoo_flow_nominal=m_flow_zone2,
    VRoo=Vzone2,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-300,0},{-280,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV3(
    zoneName="ActiveStorage_Mid_3 ZN",
    mSpl_flow_nominal=mSpl_flow_zone3,
    mRoo_flow_nominal=m_flow_zone3,
    VRoo=Vzone3,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-260,0},{-240,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV4(
    zoneName="ActiveStorage_Mid_4 ZN",
    mSpl_flow_nominal=mSpl_flow_zone4,
    mRoo_flow_nominal=m_flow_zone4,
    VRoo=Vzone4,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-220,0},{-200,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV5(
    zoneName="ConfRoom_Mid_1 ZN",
    mRoo_flow_nominal=m_flow_zone5,
    mSpl_flow_nominal=mSpl_flow_zone5,
    VRoo=Vzone5,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-180,0},{-160,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV6(
    zoneName="ConfRoom_Mid_2 ZN",
    mRoo_flow_nominal=m_flow_zone6,
    mSpl_flow_nominal=mSpl_flow_zone6,
    VRoo=Vzone6,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV7(
    zoneName="Corridor_Mid_1 ZN",
    mRoo_flow_nominal=m_flow_zone7,
    mSpl_flow_nominal=mSpl_flow_zone7,
    VRoo=Vzone7,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV8(
    zoneName="Corridor_Mid_2 ZN",
    mRoo_flow_nominal=m_flow_zone8,
    mSpl_flow_nominal=mSpl_flow_zone8,
    VRoo=Vzone8,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV9(
    zoneName="Dining_Mid ZN",
    mRoo_flow_nominal=m_flow_zone9,
    mSpl_flow_nominal=mSpl_flow_zone9,
    VRoo=Vzone9,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV10(
    zoneName="EnclosedOffice_Mid_1 ZN",
    mRoo_flow_nominal=m_flow_zone10,
    mSpl_flow_nominal=mSpl_flow_zone10,
    VRoo=Vzone10,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV11(
    zoneName="EnclosedOffice_Mid_2 ZN",
    mRoo_flow_nominal=m_flow_zone11,
    mSpl_flow_nominal=mSpl_flow_zone11,
    VRoo=Vzone11,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{60,0},{80,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV12(
    zoneName="EnclosedOffice_Mid_3 ZN",
    mRoo_flow_nominal=m_flow_zone12,
    mSpl_flow_nominal=mSpl_flow_zone12,
    VRoo=Vzone12,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{100,0},{120,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV13(
    zoneName="Lobby_Mid ZN",
    mRoo_flow_nominal=m_flow_zone13,
    mSpl_flow_nominal=mSpl_flow_zone13,
    VRoo=Vzone13,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{140,0},{160,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV14(
    zoneName="Mechanical_Mid ZN",
    mRoo_flow_nominal=m_flow_zone14,
    mSpl_flow_nominal=mSpl_flow_zone14,
    VRoo=Vzone14,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{180,0},{200,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV15(
    zoneName="OpenOffice_Mid_1 ZN",
    mRoo_flow_nominal=m_flow_zone15,
    mSpl_flow_nominal=mSpl_flow_zone15,
    VRoo=Vzone15,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{220,0},{240,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV16(
    zoneName="OpenOffice_Mid_2 ZN",
    mRoo_flow_nominal=m_flow_zone16,
    mSpl_flow_nominal=mSpl_flow_zone16,
    VRoo=Vzone16,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{260,0},{280,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV17(
    zoneName="OpenOffice_Mid_3 ZN",
    mRoo_flow_nominal=m_flow_zone17,
    mSpl_flow_nominal=mSpl_flow_zone17,
    VRoo=Vzone17,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{300,0},{320,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV18(
    zoneName="OpenOffice_Mid_4 ZN",
    mRoo_flow_nominal=m_flow_zone18,
    mSpl_flow_nominal=mSpl_flow_zone18,
    VRoo=Vzone18,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{340,0},{360,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV19(
    zoneName="Restroom_Mid ZN",
    mRoo_flow_nominal=m_flow_zone19,
    mSpl_flow_nominal=mSpl_flow_zone19,
    VRoo=Vzone19,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{380,0},{400,20}})));

  DetailedZoning.BaseClasses.ZoneVAV zoneVAV20(
    zoneName="Stair_Mid_1 ZN",
    mRoo_flow_nominal=m_flow_zone20,
    mSpl_flow_nominal=mSpl_flow_zone20,
    VRoo=Vzone20,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{420,0},{440,20}})));

  DetailedZoning.BaseClasses.ZoneVAVLast zoneVAV21(
    zoneName="Stair_Mid_2 ZN",
    mRoo_flow_nominal=m_flow_zone21,
    VRoo=Vzone21,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{460,0},{480,20}})));

  Buildings.Utilities.Math.Max max(nin=21)
    annotation (Placement(transformation(extent={{500,44},{520,64}})));
  Modelica.Blocks.Interfaces.RealOutput yVAVMax
    "Max static pressure of vav boxes" annotation (Placement(transformation(
          extent={{540,50},{560,70}}), iconTransformation(extent={{100,30},{120,
            50}})));
  Modelica.Blocks.Interfaces.RealInput qGaiFlo[3,21](unit="W/m2")
    "Internal heat gains" annotation (Placement(transformation(extent={{-412,44},
            {-380,76}}), iconTransformation(extent={{-120,40},{-100,60}})));
equation

  connect(min.y, TRooMin)   annotation (Line(points={{521,-108},{550,-108}}, color={0,0,127}));
  connect(ave.y, TRooAve) annotation (Line(points={{521,-78},{550,-78}},
                      color={0,0,127}));
  connect(TRooHeaSet, zoneVAV1.TRooHeaSet) annotation (Line(points={{-396,28},{
          -362,28},{-362,12},{-341,12}},
                                    color={0,0,127},
      pattern=LinePattern.Dot));
  connect(TRooCooSet, zoneVAV1.TRooCooSet) annotation (Line(points={{-396,-20},{
          -368,-20},{-368,9},{-341,9}},   color={0,0,127},
      pattern=LinePattern.Dot));
  connect(minAirFra,zoneVAV1.minAirFra)  annotation (Line(points={{-396,-60},{
          -362,-60},{-362,6},{-341,6}},color={0,0,127},
      pattern=LinePattern.Dot));
  connect(TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{-396,28},{
          -308,28},{-308,12},{-301,12}},
                                    color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV3.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{-261,12},
          {-268,12},{-268,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV4.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{-221,12},
          {-226,12},{-226,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV5.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{-181,12},
          {-186,12},{-186,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV6.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{-141,12},
          {-144,12},{-144,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV7.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{-101,12},
          {-106,12},{-106,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV8.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{-61,12},
          {-68,12},{-68,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV9.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{-21,12},
          {-26,12},{-26,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV10.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{19,12},
          {16,12},{16,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV11.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{59,12},
          {50,12},{50,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV12.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{99,12},
          {92,12},{92,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV13.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{139,12},
          {132,12},{132,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV14.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{179,12},
          {172,12},{172,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV15.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{219,12},
          {214,12},{214,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV16.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{259,12},
          {252,12},{252,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV17.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{299,12},
          {294,12},{294,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV18.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{339,12},
          {334,12},{334,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV19.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{379,12},
          {374,12},{374,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV20.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{419,12},
          {412,12},{412,40},{-308,40},{-308,12},{-301,12}},     color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV21.TRooHeaSet, zoneVAV2.TRooHeaSet) annotation (Line(points={{459,12},
          {452,12},{452,40},{-308,40},{-308,12},{-301,12}},          color={0,0,127},
      pattern=LinePattern.Dot));

  connect(TRooCooSet, zoneVAV2.TRooCooSet) annotation (Line(points={{-396,-20},{
          -310,-20},{-310,9},{-301,9}},   color={0,0,127},
      pattern=LinePattern.Dot));
  connect(TRooCooSet, zoneVAV3.TRooCooSet) annotation (Line(points={{-396,-20},{
          -272,-20},{-272,9},{-261,9}},   color={0,0,127},
      pattern=LinePattern.Dot));
  connect(minAirFra,zoneVAV2.minAirFra)  annotation (Line(points={{-396,-60},{
          -308,-60},{-308,6},{-301,6}},color={0,0,127},
      pattern=LinePattern.Dot));
  connect(TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{-396,-20},
          {450,-20},{450,9},{459,9}},   color={0,0,127},
      pattern=LinePattern.Dot));
  connect(minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{-396,-60},{
          452,-60},{452,6.2},{459,6.2}},  color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV4.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{-221,9},
          {-228,9},{-228,-20},{450,-20},{450,9},{459,9}},              color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV5.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{-181,9},
          {-188,9},{-188,-20},{450,-20},{450,9},{459,9}},              color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV6.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{-141,9},
          {-148,9},{-148,-20},{450,-20},{450,9},{459,9}},              color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV7.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{-101,9},
          {-108,9},{-108,-20},{450,-20},{450,9},{459,9}},              color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV8.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{-61,9},
          {-68,9},{-68,-20},{450,-20},{450,9},{459,9}},             color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV9.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{-21,9},
          {-28,9},{-28,-20},{450,-20},{450,9},{459,9}},             color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV10.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{19,9},{
          12,9},{12,-20},{450,-20},{450,9},{459,9}},             color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV11.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{59,9},{
          52,9},{52,-20},{450,-20},{450,9},{459,9}},             color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV12.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{99,9},{
          92,9},{92,-20},{450,-20},{450,9},{459,9}},             color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV13.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{139,9},
          {132,9},{132,-20},{450,-20},{450,9},{459,9}},             color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV14.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{179,9},
          {172,9},{172,-20},{450,-20},{450,9},{459,9}},             color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV15.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{219,9},
          {212,9},{212,-20},{450,-20},{450,9},{459,9}},             color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV16.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{259,9},
          {252,9},{252,-20},{450,-20},{450,9},{459,9}},             color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV17.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{299,9},
          {292,9},{292,-20},{450,-20},{450,9},{459,9}},             color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV18.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{339,9},
          {332,9},{332,-20},{450,-20},{450,9},{459,9}},             color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV19.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{379,9},
          {372,9},{372,-20},{450,-20},{450,9},{459,9}},             color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV20.TRooCooSet, zoneVAV21.TRooCooSet) annotation (Line(points={{419,9},
          {412,9},{412,-20},{450,-20},{450,9},{459,9}},             color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV20.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{419,6},
          {414,6},{414,-60},{452,-60},{452,6.2},{459,6.2}},            color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV19.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{379,6},
          {374,6},{374,-60},{452,-60},{452,6.2},{459,6.2}},            color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV18.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{339,6},
          {334,6},{334,-60},{452,-60},{452,6.2},{459,6.2}},            color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV17.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{299,6},
          {294,6},{294,-60},{452,-60},{452,6.2},{459,6.2}},            color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV16.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{259,6},
          {254,6},{254,-60},{452,-60},{452,6.2},{459,6.2}},            color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV15.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{219,6},
          {216,6},{216,-60},{452,-60},{452,6.2},{459,6.2}},            color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV14.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{179,6},
          {174,6},{174,-60},{452,-60},{452,6.2},{459,6.2}},            color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV13.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{139,6},
          {134,6},{134,-60},{452,-60},{452,6.2},{459,6.2}},            color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV12.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{99,6},{
          94,6},{94,-60},{452,-60},{452,6.2},{459,6.2}},            color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV11.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{59,6},{
          56,6},{56,-60},{452,-60},{452,6.2},{459,6.2}},            color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV10.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{19,6},{
          16,6},{16,-60},{452,-60},{452,6.2},{459,6.2}},            color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV9.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{-21,6},
          {-24,6},{-24,-60},{452,-60},{452,6.2},{459,6.2}},        color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV8.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{-61,6},
          {-64,6},{-64,-60},{452,-60},{452,6.2},{459,6.2}},        color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV7.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{-101,6},
          {-106,6},{-106,-60},{452,-60},{452,6.2},{459,6.2}},        color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV6.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{-141,6},
          {-146,6},{-146,-60},{452,-60},{452,6.2},{459,6.2}},        color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV5.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{-181,6},
          {-186,6},{-186,-60},{452,-60},{452,6.2},{459,6.2}},        color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV4.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{-221,6},
          {-226,6},{-226,-60},{452,-60},{452,6.2},{459,6.2}},        color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV3.minAirFra, zoneVAV21.minAirFra) annotation (Line(points={{-261,6},
          {-268,6},{-268,-60},{452,-60},{452,6.2},{459,6.2}},        color={0,0,127},
      pattern=LinePattern.Dot));

  connect(zoneVAV1.TAir, min.u[1]) annotation (
          Line(points={{-319,13},{-314,13},{-314,-110},{498,-110},{498,-109.905}},
          color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV2.TAir, min.u[2]) annotation (
      Line(points={{-279,13},{-276,13},{-276,-110},{498,-110},{498,-109.714}},
                                                  color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV3.TAir, min.u[3]) annotation (Line(points={{-239,13},{-232,13},
          {-232,-109.524},{498,-109.524}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV4.TAir, min.u[4]) annotation (Line(points={{-199,13},{-194,13},
          {-194,-109.333},{498,-109.333}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV5.TAir, min.u[5]) annotation (Line(points={{-159,13},{-152,13},
          {-152,-109.143},{498,-109.143}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV6.TAir, min.u[6]) annotation (Line(points={{-119,13},{-112,13},
          {-112,-108.952},{498,-108.952}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV7.TAir, min.u[7]) annotation (Line(points={{-79,13},{-72,13},{
          -72,-108.762},{498,-108.762}},
                                     color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV8.TAir, min.u[8]) annotation (Line(points={{-39,13},{-32,13},{
          -32,-108.571},{498,-108.571}},
                                     color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV9.TAir, min.u[9]) annotation (Line(points={{1,13},{8,13},{8,
          -108.381},{498,-108.381}},
                           color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV10.TAir, min.u[10]) annotation (Line(points={{41,13},{48,13},{
          48,-108},{498,-108},{498,-108.19}},
                                           color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV11.TAir, min.u[11]) annotation (Line(points={{81,13},{88,13},{88,
          -108},{498,-108}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV12.TAir, min.u[12]) annotation (Line(points={{121,13},{126,13},
          {126,-107.81},{498,-107.81}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV13.TAir, min.u[13]) annotation (Line(points={{161,13},{166,13},
          {166,-107.619},{498,-107.619}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV14.TAir, min.u[14]) annotation (Line(points={{201,13},{208,13},
          {208,-107.429},{498,-107.429}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV15.TAir, min.u[15]) annotation (Line(points={{241,13},{248,13},
          {248,-108},{498,-108},{498,-107.238}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV16.TAir, min.u[16]) annotation (Line(points={{281,13},{286,13},
          {286,-107.048},{498,-107.048}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV17.TAir, min.u[17]) annotation (Line(points={{321,13},{324,13},
          {324,-106.857},{498,-106.857}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV18.TAir, min.u[18]) annotation (Line(points={{361,13},{366,13},
          {366,-106.667},{498,-106.667}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV19.TAir, min.u[19]) annotation (Line(points={{401,13},{408,13},
          {408,-106.476},{498,-106.476}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV20.TAir, min.u[20]) annotation (Line(points={{441,13},{446,13},
          {446,-106.286},{498,-106.286}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV21.TAir, min.u[21]) annotation (Line(points={{481,13},{486,13},
          {486,-106},{498,-106},{498,-106.095}}, color={0,0,127},
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
  connect(zoneVAV8.supplyAir, zoneVAV9.returnAir) annotation (Line(points={{-40,2},
          {-20,2}},                    color={0,127,255}));
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
  connect(zoneVAV1.TAir, ave.u[1]) annotation (Line(points={{-319,13},{-314,13},
          {-314,-79.9048},{498,-79.9048}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV2.TAir, ave.u[2]) annotation (Line(points={{-279,13},{-276,13},
          {-276,-79.7143},{498,-79.7143}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV3.TAir, ave.u[3]) annotation (Line(points={{-239,13},{-232,13},
          {-232,-79.5238},{498,-79.5238}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV4.TAir, ave.u[4]) annotation (Line(points={{-199,13},{-194,13},
          {-194,-79.3333},{498,-79.3333}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV5.TAir, ave.u[5]) annotation (Line(points={{-159,13},{-152,13},
          {-152,-79.1429},{498,-79.1429}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV6.TAir, ave.u[6]) annotation (Line(points={{-119,13},{-112,13},
          {-112,-78.9524},{498,-78.9524}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV7.TAir, ave.u[7]) annotation (Line(points={{-79,13},{-72,13},{-72,
          -78.7619},{498,-78.7619}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV8.TAir, ave.u[8]) annotation (Line(points={{-39,13},{-32,13},{
          -32,-78},{498,-78},{498,-78.5714}},
                                          color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV9.TAir, ave.u[9]) annotation (Line(points={{1,13},{8,13},{8,
          -78.381},{498,-78.381}},
                          color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV10.TAir, ave.u[10]) annotation (Line(points={{41,13},{48,13},{
          48,-78.1905},{498,-78.1905}},
                                     color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV11.TAir, ave.u[11]) annotation (Line(points={{81,13},{88,13},{88,
          -78},{498,-78}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV12.TAir, ave.u[12]) annotation (Line(points={{121,13},{126,13},
          {126,-77.8095},{498,-77.8095}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV13.TAir, ave.u[13]) annotation (Line(points={{161,13},{166,13},
          {166,-77.619},{498,-77.619}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV14.TAir, ave.u[14]) annotation (Line(points={{201,13},{208,13},
          {208,-77.4286},{498,-77.4286}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV15.TAir, ave.u[15]) annotation (Line(points={{241,13},{248,13},
          {248,-77.2381},{498,-77.2381}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV16.TAir, ave.u[16]) annotation (Line(points={{281,13},{286,13},
          {286,-77.0476},{498,-77.0476}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV17.TAir, ave.u[17]) annotation (Line(points={{321,13},{324,13},
          {324,-76.8571},{498,-76.8571}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV18.TAir, ave.u[18]) annotation (Line(points={{361,13},{366,13},
          {366,-76.6667},{498,-76.6667}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV19.TAir, ave.u[19]) annotation (Line(points={{401,13},{408,13},
          {408,-76.4762},{498,-76.4762}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV20.TAir, ave.u[20]) annotation (Line(points={{441,13},{446,13},
          {446,-76.2857},{498,-76.2857}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV21.TAir, ave.u[21]) annotation (Line(points={{481,13},{486,13},
          {486,-76.0952},{498,-76.0952}}, color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV1.yVavAct, max.u[1]) annotation (Line(points={{-319,7},{-312,7},
          {-312,54},{448,54},{448,52.0952},{498,52.0952}},
                                         color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV2.yVavAct, max.u[2]) annotation (Line(points={{-279,7},{-274,7},
          {-274,54},{450,54},{450,52.2857},{498,52.2857}},
                                         color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV3.yVavAct, max.u[3]) annotation (Line(points={{-239,7},{-228,7},
          {-228,54},{496,54},{496,52.4762},{498,52.4762}},
                                         color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV4.yVavAct, max.u[4]) annotation (Line(points={{-199,7},{-192,7},
          {-192,54},{498,54},{498,52.6667}},
                                         color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV5.yVavAct, max.u[5]) annotation (Line(points={{-159,7},{-156,7},
          {-156,54},{418,54},{418,52.8571},{498,52.8571}},
                                         color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV6.yVavAct, max.u[6]) annotation (Line(points={{-119,7},{-114,7},
          {-114,54},{496,54},{496,53.0476},{498,53.0476}},
                                         color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV7.yVavAct, max.u[7]) annotation (Line(points={{-79,7},{-74,7},
          {-74,54},{428,54},{428,53.2381},{498,53.2381}},
                                       color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV8.yVavAct, max.u[8]) annotation (Line(points={{-39,7},{-34,7},
          {-34,54},{432,54},{432,53.4286},{498,53.4286}},
                                       color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV9.yVavAct, max.u[9]) annotation (Line(points={{1,7},{6,7},{6,
          54},{376,54},{376,53.619},{498,53.619}},
                         color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV10.yVavAct, max.u[10]) annotation (Line(points={{41,7},{46,7},
          {46,54},{386,54},{386,53.8095},{498,53.8095}},
                                      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV11.yVavAct, max.u[11]) annotation (Line(points={{81,7},{86,7},
          {86,54},{498,54}},color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV12.yVavAct, max.u[12]) annotation (Line(points={{121,7},{128,7},
          {128,54},{406,54},{406,54.1905},{498,54.1905}},
                                        color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV13.yVavAct, max.u[13]) annotation (Line(points={{161,7},{168,7},
          {168,54},{334,54},{334,54.381},{498,54.381}},
                                      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV14.yVavAct, max.u[14]) annotation (Line(points={{201,7},{206,7},
          {206,54},{352,54},{352,54.5714},{498,54.5714}},
                                        color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV15.yVavAct, max.u[15]) annotation (Line(points={{241,7},{244,7},
          {244,54},{436,54},{436,54.7619},{498,54.7619}},
                                        color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV16.yVavAct, max.u[16]) annotation (Line(points={{281,7},{288,7},
          {288,54},{446,54},{446,54.9524},{498,54.9524}},
                                        color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV17.yVavAct, max.u[17]) annotation (Line(
      points={{321,7},{326,7},{326,54},{412,54},{412,55.1429},{498,55.1429}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV18.yVavAct, max.u[18]) annotation (Line(
      points={{361,7},{368,7},{368,54},{498,54},{498,55.3333}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV19.yVavAct, max.u[19]) annotation (Line(
      points={{401,7},{406,7},{406,54},{488,54},{488,55.5238},{498,55.5238}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV20.yVavAct, max.u[20]) annotation (Line(
      points={{441,7},{448,7},{448,54},{496,54},{496,55.7143},{498,55.7143}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(zoneVAV21.yVavAct, max.u[21]) annotation (Line(
      points={{481,7},{490,7},{490,56},{498,56},{498,55.9048}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(supplyAir, zoneVAV1.supplyAir1) annotation (Line(points={{-380,80},{
          -352,80},{-352,18},{-340,18}}, color={0,127,255}));
  connect(returnAir, zoneVAV1.returnAir) annotation (Line(points={{-380,-120},{
          -352,-120},{-352,2},{-340,2}}, color={0,127,255}));
  connect(qGaiFlo[:, 1], zoneVAV1.qGai_flow) annotation (Line(points={{-396,60},
          {-356,60},{-356,15},{-341,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 2], zoneVAV2.qGai_flow) annotation (Line(points={{-396,60},
          {-304,60},{-304,15},{-301,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 3], zoneVAV3.qGai_flow) annotation (Line(points={{-396,60},
          {-264,60},{-264,15},{-261,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 4], zoneVAV4.qGai_flow) annotation (Line(points={{-396,60},
          {-224,60},{-224,15},{-221,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 5], zoneVAV5.qGai_flow) annotation (Line(points={{-396,60},
          {-188,60},{-188,15},{-181,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 6], zoneVAV6.qGai_flow) annotation (Line(points={{-396,60},
          {-150,60},{-150,15},{-141,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 7], zoneVAV7.qGai_flow) annotation (Line(points={{-396,60},
          {-108,60},{-108,15},{-101,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 8], zoneVAV8.qGai_flow) annotation (Line(points={{-396,60},
          {-66,60},{-66,15},{-61,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 9], zoneVAV9.qGai_flow) annotation (Line(points={{-396,60},
          {-24,60},{-24,15},{-21,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 10], zoneVAV10.qGai_flow) annotation (Line(points={{-396,
          60},{12,60},{12,15},{19,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 11], zoneVAV11.qGai_flow) annotation (Line(points={{-396,
          60},{54,60},{54,15},{59,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 12], zoneVAV12.qGai_flow) annotation (Line(points={{-396,
          60},{96,60},{96,15},{99,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 13], zoneVAV13.qGai_flow) annotation (Line(points={{-396,
          60},{134,60},{134,15},{139,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 14], zoneVAV14.qGai_flow) annotation (Line(points={{-396,
          60},{176,60},{176,15},{179,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 15], zoneVAV15.qGai_flow) annotation (Line(points={{-396,
          60},{216,60},{216,15},{219,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 16], zoneVAV16.qGai_flow) annotation (Line(points={{-396,
          60},{256,60},{256,15},{259,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 17], zoneVAV17.qGai_flow) annotation (Line(points={{-396,
          60},{296,60},{296,15},{299,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 18], zoneVAV18.qGai_flow) annotation (Line(points={{-396,
          60},{332,60},{332,15},{339,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 19], zoneVAV19.qGai_flow) annotation (Line(points={{-396,
          60},{372,60},{372,15},{379,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 20], zoneVAV20.qGai_flow) annotation (Line(points={{-396,
          60},{416,60},{416,15},{419,15}}, color={0,0,127}));
  connect(qGaiFlo[:, 21], zoneVAV21.qGai_flow) annotation (Line(points={{-396,
          60},{456,60},{456,15},{459,15}}, color={0,0,127}));
  connect(max.y, yVAVMax) annotation (Line(points={{521,54},{526,54},{526,60},{
          550,60}}, color={0,0,127}));
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
end FloorDetailed;
