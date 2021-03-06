within BestInClass.FiveZone;
model Guideline36
  "Variable air volume flow system with terminal reheat and five thermal zones"
  extends Modelica.Icons.Example;
  extends BestInClass.FiveZone.BaseClasses.PartialOpenLoop;

  parameter Modelica.SIunits.VolumeFlowRate VPriSysMax_flow=m_flow_nominal/1.2
    "Maximum expected system primary airflow rate at design stage";
  parameter Modelica.SIunits.VolumeFlowRate minZonPriFlo[numZon]={
      mCor_flow_nominal,mSou_flow_nominal,mEas_flow_nominal,mNor_flow_nominal,
      mWes_flow_nominal}/1.2 "Minimum expected zone primary flow rate";
  parameter Modelica.SIunits.Time samplePeriod=120
    "Sample period of component, set to the same value as the trim and respond that process yPreSetReq";
  parameter Modelica.SIunits.PressureDifference dpDisRetMax=40
    "Maximum return fan discharge static pressure setpoint";

  Buildings.Controls.OBC.ASHRAE.G36_PR1.TerminalUnits.Controller conVAVCor(
    V_flow_nominal=mCor_flow_nominal/1.2,
    AFlo=AFloCor,
    final samplePeriod=samplePeriod) "Controller for terminal unit corridor"
    annotation (Placement(transformation(extent={{530,32},{550,52}})));
  Buildings.Controls.OBC.ASHRAE.G36_PR1.TerminalUnits.Controller conVAVSou(
    V_flow_nominal=mSou_flow_nominal/1.2,
    AFlo=AFloSou,
    final samplePeriod=samplePeriod) "Controller for terminal unit south"
    annotation (Placement(transformation(extent={{700,30},{720,50}})));
  Buildings.Controls.OBC.ASHRAE.G36_PR1.TerminalUnits.Controller conVAVEas(
    V_flow_nominal=mEas_flow_nominal/1.2,
    AFlo=AFloEas,
    final samplePeriod=samplePeriod) "Controller for terminal unit east"
    annotation (Placement(transformation(extent={{880,30},{900,50}})));
  Buildings.Controls.OBC.ASHRAE.G36_PR1.TerminalUnits.Controller conVAVNor(
    V_flow_nominal=mNor_flow_nominal/1.2,
    AFlo=AFloNor,
    final samplePeriod=samplePeriod) "Controller for terminal unit north"
    annotation (Placement(transformation(extent={{1040,30},{1060,50}})));
  Buildings.Controls.OBC.ASHRAE.G36_PR1.TerminalUnits.Controller conVAVWes(
    V_flow_nominal=mWes_flow_nominal/1.2,
    AFlo=AFloWes,
    final samplePeriod=samplePeriod) "Controller for terminal unit west"
    annotation (Placement(transformation(extent={{1240,28},{1260,48}})));
  Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.Controller conAHU(
    numZon=numZon,
    VPriSysMax_flow=VPriSysMax_flow,
    minZonPriFlo=minZonPriFlo,
    AFlo=AFlo,
    yFanMin=yFanMin,
    pMaxSet=410) "AHU controller"
    annotation (Placement(transformation(extent={{384,362},{424,470}})));
  Buildings.Controls.OBC.ASHRAE.G36_PR1.TerminalUnits.ModeAndSetPoints TZonSet(
    TZonHeaOn=THeaOn,
    TZonHeaOff=THeaOff,
    TZonCooOff=TCooOff,
    numZon=numZon) "Zone temperature set points" annotation (Placement(
        transformation(rotation=0, extent={{60,300},{80,320}})));
  Modelica.Blocks.Routing.Multiplex5 TDis "Discharge air temperatures"
    annotation (Placement(transformation(extent={{220,280},{240,300}})));
  Modelica.Blocks.Routing.Multiplex5 VDis_flow
    "Air flow rate at the terminal boxes"
    annotation (Placement(transformation(extent={{220,240},{240,260}})));
  Buildings.Controls.OBC.CDL.Integers.MultiSum TZonResReq(nin=5)
    "Number of zone temperature requests"
    annotation (Placement(transformation(extent={{300,350},{320,370}})));
  Buildings.Controls.OBC.CDL.Integers.MultiSum PZonResReq(nin=5)
    "Number of zone pressure requests"
    annotation (Placement(transformation(extent={{300,320},{320,340}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant yOutDam(k=1)
    "Outdoor air damper control signal"
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));

  Buildings.Controls.OBC.CDL.Logical.Switch swiFreSta "Switch for freeze stat"
    annotation (Placement(transformation(extent={{60,-202},{80,-182}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant freStaSetPoi1(k=273.15
         + 3) "Freeze stat for heating coil"
    annotation (Placement(transformation(extent={{-40,-96},{-20,-76}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant yFreHeaCoi(final k=1)
    "Flow rate signal for heating coil when freeze stat is on"
    annotation (Placement(transformation(extent={{0,-192},{20,-172}})));
equation
  connect(fanSup.port_b, dpDisSupFan.port_a) annotation (Line(
      points={{320,-40},{320,0},{320,-10},{320,-10}},
      color={0,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dot));
  connect(conVAVCor.TZon, TRooAir.y5[1]) annotation (Line(
      points={{528,41},{520,41},{520,162},{511,162}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conVAVSou.TZon, TRooAir.y1[1]) annotation (Line(
      points={{698,39},{690,39},{690,40},{680,40},{680,178},{511,178}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y2[1], conVAVEas.TZon) annotation (Line(
      points={{511,174},{868,174},{868,39},{878,39}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y3[1], conVAVNor.TZon) annotation (Line(
      points={{511,170},{1028,170},{1028,39},{1038,39}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y4[1], conVAVWes.TZon) annotation (Line(
      points={{511,166},{1220,166},{1220,37},{1238,37}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conVAVCor.TDis, TSupCor.T) annotation (Line(points={{528,37},{522,37},
          {522,40},{514,40},{514,92},{569,92}}, color={0,0,127}));
  connect(TSupSou.T, conVAVSou.TDis) annotation (Line(points={{749,92},{688,92},
          {688,35},{698,35}}, color={0,0,127}));
  connect(TSupEas.T, conVAVEas.TDis) annotation (Line(points={{929,90},{872,90},
          {872,35},{878,35}}, color={0,0,127}));
  connect(TSupNor.T, conVAVNor.TDis) annotation (Line(points={{1089,94},{1032,
          94},{1032,35},{1038,35}}, color={0,0,127}));
  connect(TSupWes.T, conVAVWes.TDis) annotation (Line(points={{1289,90},{1228,
          90},{1228,33},{1238,33}}, color={0,0,127}));
  connect(cor.yVAV, conVAVCor.yDam) annotation (Line(points={{566,50},{556,50},
          {556,48},{552,48}},color={0,0,127}));
  connect(cor.yVal, conVAVCor.yVal) annotation (Line(points={{566,34},{560,34},
          {560,43},{552,43}},color={0,0,127}));
  connect(conVAVSou.yDam, sou.yVAV) annotation (Line(points={{722,46},{730,46},
          {730,48},{746,48}},color={0,0,127}));
  connect(conVAVSou.yVal, sou.yVal) annotation (Line(points={{722,41},{732.5,41},
          {732.5,32},{746,32}}, color={0,0,127}));
  connect(conVAVEas.yVal, eas.yVal) annotation (Line(points={{902,41},{912.5,41},
          {912.5,32},{926,32}}, color={0,0,127}));
  connect(conVAVEas.yDam, eas.yVAV) annotation (Line(points={{902,46},{910,46},
          {910,48},{926,48}},color={0,0,127}));
  connect(conVAVNor.yDam, nor.yVAV) annotation (Line(points={{1062,46},{1072.5,
          46},{1072.5,48},{1086,48}}, color={0,0,127}));
  connect(conVAVNor.yVal, nor.yVal) annotation (Line(points={{1062,41},{1072.5,
          41},{1072.5,32},{1086,32}}, color={0,0,127}));

  connect(conVAVCor.TZonHeaSet, TZonSet.TZonHeaSet[1]) annotation (Line(points={{528,51},
          {480,51},{480,310},{82,310}},           color={0,0,127}));
  connect(conVAVCor.TZonCooSet, TZonSet.TZonCooSet[1]) annotation (Line(points={{528,49},
          {480,49},{480,314},{82,314}},           color={0,0,127}));
  connect(conVAVSou.TZonHeaSet, TZonSet.TZonHeaSet[2]) annotation (Line(points={{698,49},
          {660,49},{660,310},{82,310}},           color={0,0,127}));
  connect(conVAVSou.TZonCooSet, TZonSet.TZonCooSet[2]) annotation (Line(points={{698,47},
          {660,47},{660,314},{82,314}},           color={0,0,127}));
  connect(conVAVEas.TZonHeaSet, TZonSet.TZonHeaSet[3]) annotation (Line(points={{878,49},
          {850,49},{850,310},{82,310}},           color={0,0,127}));
  connect(conVAVEas.TZonCooSet, TZonSet.TZonCooSet[3]) annotation (Line(points={{878,47},
          {850,47},{850,314},{82,314}},           color={0,0,127}));
  connect(conVAVNor.TZonHeaSet, TZonSet.TZonHeaSet[4]) annotation (Line(points={{1038,49},
          {1020,49},{1020,310},{82,310}},            color={0,0,127}));
  connect(conVAVNor.TZonCooSet, TZonSet.TZonCooSet[4]) annotation (Line(points={{1038,47},
          {1020,47},{1020,314},{82,314}},            color={0,0,127}));
  connect(conVAVWes.TZonHeaSet, TZonSet.TZonHeaSet[5]) annotation (Line(points={{1238,47},
          {1202,47},{1202,310},{82,310}},            color={0,0,127}));
  connect(conVAVWes.TZonCooSet, TZonSet.TZonCooSet[5]) annotation (Line(points={{1238,45},
          {1202,45},{1202,314},{82,314}},            color={0,0,127}));
  connect(conVAVWes.yVal, wes.yVal) annotation (Line(points={{1262,39},{1272.5,
          39},{1272.5,32},{1286,32}}, color={0,0,127}));
  connect(wes.yVAV, conVAVWes.yDam) annotation (Line(points={{1286,48},{1274,48},
          {1274,44},{1262,44}}, color={0,0,127}));
  connect(TZonSet.uOcc, occSch.occupied) annotation (Line(points={{58,314.025},
          {-92,314.025},{-92,300},{-240,300},{-240,-216},{-297,-216}},color={
          255,0,255}));
  connect(occSch.tNexOcc, TZonSet.tNexOcc) annotation (Line(points={{-297,-204},
          {-254,-204},{-254,318},{58,318}}, color={0,0,127}));
  connect(TZonSet.TZon, flo.TRooAir) annotation (Line(points={{58,316.025},{46,
          316.025},{46,628},{1164,628},{1164,491.333},{1094.14,491.333}}, color=
         {0,0,127}));
  connect(conAHU.TZonHeaSet, TZonSet.TZonHeaSet[1]) annotation (Line(points={{382,
          468.071},{110,468.071},{110,310},{82,310}},
                                                  color={0,0,127}));
  connect(conAHU.TZonCooSet, TZonSet.TZonCooSet[1]) annotation (Line(points={{382,
          462.286},{120,462.286},{120,314},{82,314}},
                                                  color={0,0,127}));
  connect(conAHU.TZon, flo.TRooAir) annotation (Line(points={{382,429.5},{280,
          429.5},{280,622},{1164,622},{1164,491.333},{1094.14,491.333}},
        color={0,0,127}));
  connect(conAHU.TOut, TOut.y) annotation (Line(points={{382,450.714},{-266,
          450.714},{-266,180},{-279,180}}, color={0,0,127}));
  connect(TRet.T, conAHU.TOutCut) annotation (Line(points={{100,151},{100,
          414.071},{382,414.071}},     color={0,0,127}));
  connect(conAHU.TSup, TSup.T) annotation (Line(points={{382,419.857},{152,
          419.857},{152,-20},{340,-20},{340,-29}}, color={0,0,127}));
  connect(dpDisSupFan.p_rel, conAHU.ducStaPre) annotation (Line(points={{311,0},
          {160,0},{160,439.143},{382,439.143}},     color={0,0,127}));
  connect(conAHU.uOpeMod, TZonSet.yOpeMod) annotation (Line(points={{382,
          385.143},{130,385.143},{130,304},{82,304}}, color={255,127,0}));
  connect(conAHU.TDis, TDis.y) annotation (Line(points={{382,425.643},{252,
          425.643},{252,290},{241,290}}, color={0,0,127}));
  connect(conAHU.VDis_flow, VDis_flow.y) annotation (Line(points={{382,444.929},
          {260,444.929},{260,250},{241,250}},          color={0,0,127}));
  connect(conVAVCor.uOpeMod, TZonSet.yOpeMod) annotation (Line(points={{528,33},
          {520,33},{520,16},{420,16},{420,200},{130,200},{130,304},{82,304}},
        color={255,127,0}));
  connect(conVAVSou.uOpeMod, TZonSet.yOpeMod) annotation (Line(points={{698,31},
          {690,31},{690,16},{420,16},{420,200},{130,200},{130,304},{82,304}},
        color={255,127,0}));
  connect(conVAVEas.uOpeMod, TZonSet.yOpeMod) annotation (Line(points={{878,31},
          {868,31},{868,16},{420,16},{420,200},{130,200},{130,304},{82,304}},
        color={255,127,0}));
  connect(conVAVNor.uOpeMod, TZonSet.yOpeMod) annotation (Line(points={{1038,31},
          {1032,31},{1032,16},{420,16},{420,200},{130,200},{130,304},{82,304}},
        color={255,127,0}));
  connect(conVAVWes.uOpeMod, TZonSet.yOpeMod) annotation (Line(points={{1238,29},
          {1228,29},{1228,16},{420,16},{420,200},{130,200},{130,304},{82,304}},
        color={255,127,0}));
  connect(conAHU.uZonTemResReq, TZonResReq.y) annotation (Line(points={{382,
          379.357},{352,379.357},{352,360},{322,360}},   color={255,127,0}));
  connect(conVAVCor.yZonTemResReq, TZonResReq.u[1]) annotation (Line(points={{552,38},
          {554,38},{554,220},{280,220},{280,365.6},{298,365.6}},         color=
          {255,127,0}));
  connect(conVAVSou.yZonTemResReq, TZonResReq.u[2]) annotation (Line(points={{722,36},
          {726,36},{726,220},{280,220},{280,362.8},{298,362.8}},         color=
          {255,127,0}));
  connect(conVAVEas.yZonTemResReq, TZonResReq.u[3]) annotation (Line(points={{902,36},
          {904,36},{904,220},{280,220},{280,360},{298,360}},         color={255,
          127,0}));
  connect(conVAVNor.yZonTemResReq, TZonResReq.u[4]) annotation (Line(points={{1062,36},
          {1064,36},{1064,220},{280,220},{280,357.2},{298,357.2}},
        color={255,127,0}));
  connect(conVAVWes.yZonTemResReq, TZonResReq.u[5]) annotation (Line(points={{1262,34},
          {1266,34},{1266,220},{280,220},{280,354.4},{298,354.4}},
        color={255,127,0}));
  connect(conVAVCor.yZonPreResReq, PZonResReq.u[1]) annotation (Line(points={{552,34},
          {558,34},{558,214},{288,214},{288,335.6},{298,335.6}},         color=
          {255,127,0}));
  connect(conVAVSou.yZonPreResReq, PZonResReq.u[2]) annotation (Line(points={{722,32},
          {728,32},{728,214},{288,214},{288,332.8},{298,332.8}},         color=
          {255,127,0}));
  connect(conVAVEas.yZonPreResReq, PZonResReq.u[3]) annotation (Line(points={{902,32},
          {906,32},{906,214},{288,214},{288,330},{298,330}},         color={255,
          127,0}));
  connect(conVAVNor.yZonPreResReq, PZonResReq.u[4]) annotation (Line(points={{1062,32},
          {1066,32},{1066,214},{288,214},{288,327.2},{298,327.2}},
        color={255,127,0}));
  connect(conVAVWes.yZonPreResReq, PZonResReq.u[5]) annotation (Line(points={{1262,30},
          {1268,30},{1268,214},{288,214},{288,324.4},{298,324.4}},
        color={255,127,0}));
  connect(conAHU.uZonPreResReq, PZonResReq.y) annotation (Line(points={{382,
          373.571},{360,373.571},{360,330},{322,330}},   color={255,127,0}));
  connect(VSupCor_flow.V_flow, VDis_flow.u1[1]) annotation (Line(points={{569,
          130},{472,130},{472,206},{180,206},{180,260},{218,260}}, color={0,0,
          127}));
  connect(VSupSou_flow.V_flow, VDis_flow.u2[1]) annotation (Line(points={{749,
          130},{742,130},{742,206},{180,206},{180,255},{218,255}}, color={0,0,
          127}));
  connect(VSupEas_flow.V_flow, VDis_flow.u3[1]) annotation (Line(points={{929,
          128},{914,128},{914,206},{180,206},{180,250},{218,250}}, color={0,0,
          127}));
  connect(VSupNor_flow.V_flow, VDis_flow.u4[1]) annotation (Line(points={{1089,
          132},{1080,132},{1080,206},{180,206},{180,245},{218,245}}, color={0,0,
          127}));
  connect(VSupWes_flow.V_flow, VDis_flow.u5[1]) annotation (Line(points={{1289,
          128},{1284,128},{1284,206},{180,206},{180,240},{218,240}}, color={0,0,
          127}));
  connect(TSupCor.T, TDis.u1[1]) annotation (Line(points={{569,92},{466,92},{
          466,210},{176,210},{176,300},{218,300}}, color={0,0,127}));
  connect(TSupSou.T, TDis.u2[1]) annotation (Line(points={{749,92},{720,92},{
          720,92},{688,92},{688,210},{176,210},{176,295},{218,295}}, color={0,0,
          127}));
  connect(TSupEas.T, TDis.u3[1]) annotation (Line(points={{929,90},{872,90},{
          872,210},{176,210},{176,290},{218,290}}, color={0,0,127}));
  connect(TSupNor.T, TDis.u4[1]) annotation (Line(points={{1089,94},{1032,94},{
          1032,210},{176,210},{176,285},{218,285}}, color={0,0,127}));
  connect(TSupWes.T, TDis.u5[1]) annotation (Line(points={{1289,90},{1228,90},{
          1228,210},{176,210},{176,280},{218,280}}, color={0,0,127}));
  connect(conAHU.yOutDamPos, eco.yOut) annotation (Line(points={{426,389},{450,
          389},{450,36},{-10,36},{-10,-34}},                   color={0,0,127}));
  connect(conVAVCor.VDis_flow, VSupCor_flow.V_flow) annotation (Line(points={{528,39},
          {522,39},{522,130},{569,130}}, color={0,0,127}));
  connect(VSupSou_flow.V_flow, conVAVSou.VDis_flow) annotation (Line(points={{749,130},
          {690,130},{690,37},{698,37}},      color={0,0,127}));
  connect(VSupEas_flow.V_flow, conVAVEas.VDis_flow) annotation (Line(points={{929,128},
          {874,128},{874,37},{878,37}},      color={0,0,127}));
  connect(VSupNor_flow.V_flow, conVAVNor.VDis_flow) annotation (Line(points={{1089,
          132},{1034,132},{1034,37},{1038,37}}, color={0,0,127}));
  connect(VSupWes_flow.V_flow, conVAVWes.VDis_flow) annotation (Line(points={{1289,
          128},{1230,128},{1230,35},{1238,35}}, color={0,0,127}));
  connect(TSup.T, conVAVCor.TSupAHU) annotation (Line(points={{340,-29},{340,
          -20},{514,-20},{514,35},{528,35}},
                                        color={0,0,127}));
  connect(TSup.T, conVAVSou.TSupAHU) annotation (Line(points={{340,-29},{340,
          -20},{686,-20},{686,33},{698,33}},
                                        color={0,0,127}));
  connect(TSup.T, conVAVEas.TSupAHU) annotation (Line(points={{340,-29},{340,
          -20},{864,-20},{864,33},{878,33}},
                                        color={0,0,127}));
  connect(TSup.T, conVAVNor.TSupAHU) annotation (Line(points={{340,-29},{340,
          -20},{1028,-20},{1028,33},{1038,33}},
                                           color={0,0,127}));
  connect(TSup.T, conVAVWes.TSupAHU) annotation (Line(points={{340,-29},{340,
          -20},{1224,-20},{1224,31},{1238,31}},
                                           color={0,0,127}));
  connect(VOut1.V_flow, conAHU.VOut_flow) annotation (Line(points={{-61,-20.9},
          {-61,396.714},{382,396.714}},    color={0,0,127}));
  connect(fanSup.y, conAHU.ySupFanSpe) annotation (Line(points={{310,-28},{310,
          -14},{460,-14},{460,441.071},{426,441.071}},     color={0,0,127}));
  connect(conAHU.yCoo, gaiCooCoi.u) annotation (Line(points={{426,416},{446,416},
          {446,-274},{88,-274},{88,-248},{98,-248}},              color={0,0,
          127}));
  connect(conAHU.TMix, TMix.T) annotation (Line(points={{382,390.929},{40,
          390.929},{40,-29}},
                    color={0,0,127}));
  connect(conAHU.yRetDamPos, eco.yRet) annotation (Line(points={{426,408.286},{
          436,408.286},{436,40},{-16.8,40},{-16.8,-34}},           color={0,0,
          127}));
  connect(yOutDam.y, eco.yExh)
    annotation (Line(points={{-18,-10},{-3,-10},{-3,-34}}, color={0,0,127}));
  connect(conAHU.yHea, swiFreSta.u3) annotation (Line(points={{426,425.643},{
          458,425.643},{458,-280},{48,-280},{48,-200},{58,-200}},  color={0,0,
          127}));
  connect(swiFreSta.y, gaiHeaCoi.u) annotation (Line(points={{82,-192},{88,-192},
          {88,-210},{98,-210}}, color={0,0,127}));
  connect(freSta.y, swiFreSta.u2) annotation (Line(points={{22,-92},{40,-92},{
          40,-192},{58,-192}}, color={255,0,255}));
  connect(yFreHeaCoi.y, swiFreSta.u1) annotation (Line(points={{22,-182},{40,
          -182},{40,-184},{58,-184}},
                                color={0,0,127}));
  connect(cor.yDam_actual, conVAVCor.uDam) annotation (Line(points={{612,42},{
          620,42},{620,18},{524,18},{524,36.1},{529.3,36.1}}, color={0,0,127}));
  connect(sou.yDam_actual, conVAVSou.uDam) annotation (Line(points={{792,40},{
          800,40},{800,18},{694,18},{694,34.1},{699.3,34.1}}, color={0,0,127}));
  connect(eas.yDam_actual, conVAVEas.uDam) annotation (Line(points={{972,40},{
          980,40},{980,18},{876,18},{876,34.1},{879.3,34.1}}, color={0,0,127}));
  connect(nor.yDam_actual, conVAVNor.uDam) annotation (Line(points={{1132,40},{
          1140,40},{1140,18},{1036,18},{1036,34.1},{1039.3,34.1}}, color={0,0,
          127}));
  connect(wes.yDam_actual, conVAVWes.uDam) annotation (Line(points={{1332,40},{
          1340,40},{1340,16},{1236,16},{1236,32.1},{1239.3,32.1}}, color={0,0,
          127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-380,-320},{1400,
            640}})),
    Documentation(info="<html>
<p>
This model consist of an HVAC system, a building envelope model and a model
for air flow through building leakage and through open doors.
</p>
<p>
The HVAC system is a variable air volume (VAV) flow system with economizer
and a heating and cooling coil in the air handler unit. There is also a
reheat coil and an air damper in each of the five zone inlet branches.
</p>
<p>
See the model
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.PartialOpenLoop\">
Buildings.Examples.VAVReheat.BaseClasses.PartialOpenLoop</a>
for a description of the HVAC system and the building envelope.
</p>
<p>
The control is based on ASHRAE Guideline 36, and implemented
using the sequences from the library
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36_PR1\">
Buildings.Controls.OBC.ASHRAE.G36_PR1</a> for
multi-zone VAV systems with economizer. The schematic diagram of the HVAC and control
sequence is shown in the figure below.
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/VAVReheat/vavControlSchematics.png\" border=\"1\"/>
</p>
<p>
A similar model but with a different control sequence can be found in
<a href=\"modelica://Buildings.Examples.VAVReheat.ASHRAE2006\">
Buildings.Examples.VAVReheat.ASHRAE2006</a>.
Note that this model, because of the frequent time sampling,
has longer computing time than
<a href=\"modelica://Buildings.Examples.VAVReheat.ASHRAE2006\">
Buildings.Examples.VAVReheat.ASHRAE2006</a>.
The reason is that the time integrator cannot make large steps
because it needs to set a time step each time the control samples
its input.
</p>
</html>", revisions="<html>
<ul>
<li>
May 19, 2016, by Michael Wetter:<br/>
Changed chilled water supply temperature to <i>6&circ;C</i>.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/509\">#509</a>.
</li>
<li>
April 26, 2016, by Michael Wetter:<br/>
Changed controller for freeze protection as the old implementation closed
the outdoor air damper during summer.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/511\">#511</a>.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
September 24, 2015 by Michael Wetter:<br/>
Set default temperature for medium to avoid conflicting
start values for alias variables of the temperature
of the building and the ambient air.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/426\">issue 426</a>.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Examples/VAVReheat/Guideline36.mos"
        "Simulate and plot"),
    experiment(StopTime=172800, Tolerance=1e-06));
end Guideline36;
