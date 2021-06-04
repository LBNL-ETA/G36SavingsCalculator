within BestInClass.FiveZone;
model BICMid
  "Variable air volume flow system with terminal reheat and five thermal zones"
  extends Modelica.Icons.Example;
  extends BestInClass.FiveZone.BaseClasses.PartialOpenLoop(
                                                  heaCoi(show_T=true), cooCoi(
        show_T=true));

  Modelica.Blocks.Sources.Constant TSupSetHea(y(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC",
      min=0), k=273.15 + 10) "Supply air temperature setpoint for heating"
    annotation (Placement(transformation(extent={{-200,-170},{-180,-150}})));
  Controls.FanVFD conFanSup(xSet_nominal(displayUnit="Pa") = 410, r_N_min=
        yFanMin) "Controller for fan"
    annotation (Placement(transformation(extent={{240,-10},{260,10}})));
  Controls.ModeSelector modeSelector
    annotation (Placement(transformation(extent={{-200,-320},{-180,-300}})));
  Controls.ControlBus controlBus
    annotation (Placement(transformation(extent={{-250,-352},{-230,-332}})));

  Controls.Economizer conEco(
    dT=1,
    VOut_flow_min=0.3*m_flow_nominal/1.2,
    Ti=600,
    k=0.1) "Controller for economizer"
    annotation (Placement(transformation(extent={{-80,140},{-60,160}})));
  Controls.RoomTemperatureSetpoint TSetRoo(
    final THeaOn=THeaOn,
    final THeaOff=THeaOff,
    final TCooOn=TCooOn,
    final TCooOff=TCooOff)
    annotation (Placement(transformation(extent={{-300,-358},{-280,-338}})));
  Controls.CoolingCoilTemperatureSetpoint TSetCoo "Setpoint for cooling coil"
    annotation (Placement(transformation(extent={{-130,-220},{-110,-200}})));
  Controls.RoomVAV conVAVCor "Controller for terminal unit corridor"
    annotation (Placement(transformation(extent={{530,32},{550,52}})));
  Controls.RoomVAV conVAVSou "Controller for terminal unit south"
    annotation (Placement(transformation(extent={{700,30},{720,50}})));
  Controls.RoomVAV conVAVEas "Controller for terminal unit east"
    annotation (Placement(transformation(extent={{880,30},{900,50}})));
  Controls.RoomVAV conVAVNor "Controller for terminal unit north"
    annotation (Placement(transformation(extent={{1040,30},{1060,50}})));
  Controls.RoomVAV conVAVWes "Controller for terminal unit west"
    annotation (Placement(transformation(extent={{1240,28},{1260,48}})));
  Buildings.Controls.Continuous.LimPID heaCoiCon(
    yMax=1,
    yMin=0,
    Td=60,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.02,
    Ti=300)
           "Controller for heating coil"
    annotation (Placement(transformation(extent={{-80,-212},{-60,-192}})));
  Buildings.Controls.Continuous.LimPID cooCoiCon(
    Td=60,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=600,
    k=0.1,
    reverseActing=not (true)) "Controller for cooling coil"
    annotation (Placement(transformation(extent={{-80,-250},{-60,-230}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swiHeaCoi
    "Switch to switch off heating coil"
    annotation (Placement(transformation(extent={{60,-220},{80,-200}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swiCooCoi
    "Switch to switch off cooling coil"
    annotation (Placement(transformation(extent={{60,-258},{80,-238}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant coiOff(k=0)
    "Signal to switch water flow through coils off"
    annotation (Placement(transformation(extent={{-60,-172},{-40,-152}})));

  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{0,-180},{20,-160}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant FreAirPerCor(k=0.2)
    annotation (Placement(transformation(extent={{492,14},{512,34}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant FreAirPerSou(k=0.2)
    annotation (Placement(transformation(extent={{662,8},{682,28}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant FreAirPerEas(k=0.2)
    annotation (Placement(transformation(extent={{850,6},{870,26}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant FreAirPerNor(k=0.2)
    annotation (Placement(transformation(extent={{976,12},{996,32}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant FreAirPerWes(k=0.2)
    annotation (Placement(transformation(extent={{1170,20},{1190,40}})));
  Controls.SupAirTemp supAirTemp
    annotation (Placement(transformation(extent={{-200,-224},{-180,-204}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=cor.vav.y_actual)
    annotation (Placement(transformation(extent={{80,72},{100,92}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=sou.vav.y_actual)
    annotation (Placement(transformation(extent={{80,56},{100,76}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=eas.vav.y_actual)
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=nor.vav.y_actual)
    annotation (Placement(transformation(extent={{80,24},{100,44}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=wes.vav.y_actual)
    annotation (Placement(transformation(extent={{80,10},{100,30}})));
  Controls.DuctStaticPressureSetpoint pSetDuc(
    nin=5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    pMin=50) "Duct static pressure setpoint"
    annotation (Placement(transformation(extent={{160,-10},{180,10}})));
equation
  connect(TSupSetHea.y, heaCoiCon.u_s) annotation (Line(
      points={{-179,-160},{-96,-160},{-96,-202},{-82,-202}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(fanSup.port_b, dpDisSupFan.port_a) annotation (Line(
      points={{320,-40},{320,0},{320,-10},{320,-10}},
      color={0,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dot));
  connect(controlBus, modeSelector.cb) annotation (Line(
      points={{-240,-342},{-152,-342},{-152,-303.182},{-196.818,-303.182}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(min.y, controlBus.TRooMin) annotation (Line(
      points={{1221,450},{1400,450},{1400,-342},{-240,-342}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(ave.y, controlBus.TRooAve) annotation (Line(
      points={{1221,420},{1400,420},{1400,-342},{-240,-342}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TRet.T, conEco.TRet) annotation (Line(
      points={{100,151},{100,172},{-92,172},{-92,157.333},{-81.3333,157.333}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TMix.T, conEco.TMix) annotation (Line(
      points={{40,-29},{40,168},{-90,168},{-90,153.333},{-81.3333,153.333}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conEco.TSupHeaSet, TSupSetHea.y) annotation (Line(
      points={{-81.3333,145.333},{-156,145.333},{-156,-120},{-140,-120},{-140,
          -160},{-179,-160}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TSetRoo.controlBus, controlBus) annotation (Line(
      points={{-288,-342},{-240,-342}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(dpDisSupFan.p_rel, conFanSup.u_m) annotation (Line(
      points={{311,4.44089e-16},{304,4.44089e-16},{304,-16},{250,-16},{250,-12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(TSetCoo.TSet, cooCoiCon.u_s) annotation (Line(
      points={{-109,-210},{-96,-210},{-96,-240},{-82,-240}},
      color={0,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TSetCoo.TSet, conEco.TSupCooSet) annotation (Line(
      points={{-109,-210},{-100,-210},{-100,-114},{-150,-114},{-150,141.333},{
          -81.3333,141.333}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TSupSetHea.y, TSetCoo.TSetHea) annotation (Line(
      points={{-179,-160},{-140,-160},{-140,-206},{-132,-206}},
      color={0,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(modeSelector.cb, TSetCoo.controlBus) annotation (Line(
      points={{-196.818,-303.182},{-152,-303.182},{-152,-218},{-121.8,-218}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(conEco.VOut_flow, VOut1.V_flow) annotation (Line(
      points={{-81.3333,149.333},{-90,149.333},{-90,80},{-61,80},{-61,-20.9}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conEco.yOA, eco.yOut) annotation (Line(
      points={{-59.3333,152},{-10,152},{-10,-34}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(conVAVCor.TRoo, TRooAir.y5[1]) annotation (Line(
      points={{528,38.2},{520,38.2},{520,162},{511,162}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conVAVSou.TRoo, TRooAir.y1[1]) annotation (Line(
      points={{698,36.2},{690,36.2},{690,36},{680,36},{680,178},{511,178}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y2[1], conVAVEas.TRoo) annotation (Line(
      points={{511,174},{868,174},{868,36.2},{878,36.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y3[1], conVAVNor.TRoo) annotation (Line(
      points={{511,170},{1028,170},{1028,36.2},{1038,36.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TRooAir.y4[1], conVAVWes.TRoo) annotation (Line(
      points={{511,166},{1220,166},{1220,34.2},{1238,34.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cor.yVAV, conVAVCor.yDam) annotation (Line(points={{566,50},{556,
          50},{556,38},{551,38}},color={0,0,127}));
  connect(cor.yVal, conVAVCor.yVal) annotation (Line(points={{566,34},{560,
          34},{560,46},{551,46}},
                             color={0,0,127}));
  connect(conVAVSou.yDam, sou.yVAV) annotation (Line(points={{721,36},{730,
          36},{730,48},{746,48}},   color={0,0,127}));
  connect(conVAVSou.yVal, sou.yVal) annotation (Line(points={{721,44},{
          732.5,44},{732.5,32},{746,32}},
                                color={0,0,127}));
  connect(conVAVEas.yVal, eas.yVal) annotation (Line(points={{901,44},{
          912.5,44},{912.5,32},{926,32}},
                                color={0,0,127}));
  connect(conVAVEas.yDam, eas.yVAV) annotation (Line(points={{901,36},{910,
          36},{910,48},{926,48}},   color={0,0,127}));
  connect(conVAVNor.yDam, nor.yVAV) annotation (Line(points={{1061,36},{
          1072.5,36},{1072.5,48},{1086,48}},   color={0,0,127}));
  connect(conVAVNor.yVal, nor.yVal) annotation (Line(points={{1061,44},{
          1072.5,44},{1072.5,32},{1086,32}},
                                      color={0,0,127}));
  connect(conVAVCor.TRooHeaSet, controlBus.TRooSetHea) annotation (Line(points={{528,50},
          {480,50},{480,-342},{-240,-342}},          color={0,0,127}));
  connect(conVAVCor.TRooCooSet, controlBus.TRooSetCoo) annotation (Line(points={{528,46},
          {480,46},{480,-342},{-240,-342}},          color={0,0,127}));
  connect(conVAVSou.TRooHeaSet, controlBus.TRooSetHea) annotation (Line(points={{698,48},
          {660,48},{660,-342},{-240,-342}},          color={0,0,127}));
  connect(conVAVSou.TRooCooSet, controlBus.TRooSetCoo) annotation (Line(points={{698,44},
          {660,44},{660,-342},{-240,-342}},          color={0,0,127}));
  connect(conVAVEas.TRooHeaSet, controlBus.TRooSetHea) annotation (Line(points={{878,48},
          {842,48},{842,-342},{-240,-342}},          color={0,0,127}));
  connect(conVAVEas.TRooCooSet, controlBus.TRooSetCoo) annotation (Line(points={{878,44},
          {842,44},{842,-342},{-240,-342}},          color={0,0,127}));
  connect(conVAVNor.TRooHeaSet, controlBus.TRooSetHea) annotation (Line(points={{1038,48},
          {1020,48},{1020,-342},{-240,-342}},           color={0,0,127}));
  connect(conVAVNor.TRooCooSet, controlBus.TRooSetCoo) annotation (Line(points={{1038,44},
          {1020,44},{1020,-342},{-240,-342}},           color={0,0,127}));
  connect(conVAVWes.TRooHeaSet, controlBus.TRooSetHea) annotation (Line(points={{1238,46},
          {1202,46},{1202,-342},{-240,-342}},           color={0,0,127}));
  connect(conVAVWes.TRooCooSet, controlBus.TRooSetCoo) annotation (Line(points={{1238,42},
          {1202,42},{1202,-342},{-240,-342}},           color={0,0,127}));

  connect(conVAVWes.yVal, wes.yVal) annotation (Line(points={{1261,42},{
          1272.5,42},{1272.5,32},{1286,32}},
                                      color={0,0,127}));
  connect(wes.yVAV, conVAVWes.yDam) annotation (Line(points={{1286,48},{
          1274,48},{1274,34},{1261,34}},
                                    color={0,0,127}));
  connect(occSch.tNexOcc, controlBus.dTNexOcc) annotation (Line(
      points={{-297,-204},{-240,-204},{-240,-342}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(occSch.occupied, controlBus.occupied) annotation (Line(
      points={{-297,-216},{-240,-216},{-240,-342}},
      color={255,0,255},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TOut.y, controlBus.TOut) annotation (Line(points={{-279,180},{-240,180},
          {-240,-342}},                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(conEco.controlBus, controlBus) annotation (Line(
      points={{-76,150.667},{-76,120},{-240,120},{-240,-342}},
      color={255,204,51},
      thickness=0.5));
  connect(modeSelector.yFan, conFanSup.uFan) annotation (Line(points={{-179.545,
          -310},{260,-310},{260,-30},{226,-30},{226,6},{238,6}}, color={255,0,
          255}));
  connect(conFanSup.yFan, fanSup.y) annotation (Line(points={{261,0},{280,0},{
          280,-20},{310,-20},{310,-28}}, color={0,0,127}));
  connect(modeSelector.yFan, swiCooCoi.u2) annotation (Line(points={{-179.545,
          -310},{-20,-310},{-20,-248},{58,-248}},
                                              color={255,0,255}));
  connect(swiCooCoi.u1, cooCoiCon.y) annotation (Line(points={{58,-240},{-20,
          -240},{-59,-240}},      color={0,0,127}));
  connect(swiHeaCoi.u1, heaCoiCon.y)
    annotation (Line(points={{58,-202},{-59,-202}}, color={0,0,127}));
  connect(coiOff.y, swiCooCoi.u3) annotation (Line(points={{-38,-162},{-28,-162},
          {-28,-256},{58,-256}},
                              color={0,0,127}));
  connect(coiOff.y, swiHeaCoi.u3) annotation (Line(points={{-38,-162},{-28,-162},
          {-28,-218},{58,-218}},
                              color={0,0,127}));
  connect(TSup.T, cooCoiCon.u_m) annotation (Line(points={{340,-29},{340,-12},{
          372,-12},{372,-268},{-70,-268},{-70,-252}}, color={0,0,127}));
  connect(TSup.T, heaCoiCon.u_m) annotation (Line(points={{340,-29},{340,-12},{
          372,-12},{372,-268},{-88,-268},{-88,-222},{-70,-222},{-70,-214}},
        color={0,0,127}));
  connect(gaiHeaCoi.u, swiHeaCoi.y)
    annotation (Line(points={{98,-210},{82,-210},{82,-210}}, color={0,0,127}));
  connect(gaiCooCoi.u, swiCooCoi.y) annotation (Line(points={{98,-248},{88,-248},
          {88,-248},{82,-248}}, color={0,0,127}));
  connect(eco.yExh, conEco.yOA) annotation (Line(
      points={{-3,-34},{-2,-34},{-2,152},{-59.3333,152}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(eco.yRet, conEco.yRet) annotation (Line(
      points={{-16.8,-34},{-16.8,146.667},{-59.3333,146.667}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(freSta.y, or2.u1) annotation (Line(points={{22,-92},{22,-92},{40,-92},
          {40,-150},{-20,-150},{-20,-170},{-2,-170}},        color={255,0,255}));
  connect(or2.u2, modeSelector.yFan) annotation (Line(points={{-2,-178},{-20,
          -178},{-20,-310},{-179.545,-310}},
                                     color={255,0,255}));
  connect(or2.y, swiHeaCoi.u2) annotation (Line(points={{22,-170},{40,-170},{40,
          -190},{40,-190},{40,-210},{58,-210}}, color={255,0,255}));
  connect(conVAVCor.PerFlo, FreAirPerCor.y) annotation (Line(points={{528,34},{
          520,34},{520,24},{514,24}},  color={0,0,127}));
  connect(conVAVSou.PerFlo, FreAirPerSou.y) annotation (Line(points={{698,32},{
          690,32},{690,18},{684,18}},  color={0,0,127}));
  connect(conVAVEas.PerFlo, FreAirPerEas.y) annotation (Line(points={{878,32},{
          876,32},{876,16},{872,16}},  color={0,0,127}));
  connect(conVAVNor.PerFlo, FreAirPerNor.y) annotation (Line(points={{1038,32},
          {1018,32},{1018,22},{998,22}}, color={0,0,127}));
  connect(conVAVWes.PerFlo, FreAirPerWes.y)
    annotation (Line(points={{1238,30},{1192,30}}, color={0,0,127}));
  connect(TSetCoo.TCooOn, supAirTemp.TSet)
    annotation (Line(points={{-132,-214},{-179,-214}}, color={0,0,127}));
  connect(supAirTemp.TOut, TOut.y) annotation (Line(points={{-202,-214},{-214,
          -214},{-214,180},{-279,180}}, color={0,0,127}));
  connect(realExpression.y, pSetDuc.u[1]) annotation (Line(points={{101,82},{
          130,82},{130,-1.6},{158,-1.6}}, color={0,0,127}));
  connect(realExpression1.y, pSetDuc.u[2]) annotation (Line(points={{101,66},{
          128,66},{128,-0.8},{158,-0.8}}, color={0,0,127}));
  connect(realExpression2.y, pSetDuc.u[3]) annotation (Line(points={{101,50},{
          126,50},{126,0},{158,0}}, color={0,0,127}));
  connect(realExpression3.y, pSetDuc.u[4]) annotation (Line(points={{101,34},{
          124,34},{124,0.8},{158,0.8}}, color={0,0,127}));
  connect(realExpression4.y, pSetDuc.u[5]) annotation (Line(points={{101,20},{
          120,20},{120,1.6},{158,1.6}}, color={0,0,127}));
  connect(pSetDuc.y, conFanSup.u)
    annotation (Line(points={{181,0},{238,0}}, color={0,0,127}));
  connect(TOut.y, pSetDuc.TOut) annotation (Line(points={{-279,180},{-214,180},
          {-214,8},{158,8}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-380,-400},{1440,
            580}})),
    Documentation(info="<html>
<p>
This model consist of an HVAC system, a building envelope model and a model
for air flow through building leakage and through open doors.
</p>
<p>
The HVAC system is a variable air volume (VAV) flow system with economizer
and a heating and cooling coil in the air handler unit. There is also a
reheat coil and an air damper in each of the five zone inlet branches.
The figure below shows the schematic diagram of the HVAC system
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/VAVReheat/vavSchematics.png\" border=\"1\"/>
</p>
<p>
See the model
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.PartialOpenLoop\">
Buildings.Examples.VAVReheat.BaseClasses.PartialOpenLoop</a>
for a description of the HVAC system and the building envelope.
</p>
<p>
The control is an implementation of the control sequence
<i>VAV 2A2-21232</i> of the Sequences of Operation for
Common HVAC Systems (ASHRAE, 2006). In this control sequence, the
supply fan speed is regulated based on the duct static pressure.
The return fan controller tracks the supply fan air flow rate.
The duct static pressure is adjusted
so that at least one VAV damper is 90% open. The economizer dampers
are modulated to track the setpoint for the mixed air dry bulb temperature.
Priority is given to maintain a minimum outside air volume flow rate.
In each zone, the VAV damper is adjusted to meet the room temperature
setpoint for cooling, or fully opened during heating.
The room temperature setpoint for heating is tracked by varying
the water flow rate through the reheat coil. There is also a
finite state machine that transitions the mode of operation of
the HVAC system between the modes
<i>occupied</i>, <i>unoccupied off</i>, <i>unoccupied night set back</i>,
<i>unoccupied warm-up</i> and <i>unoccupied pre-cool</i>.
In the VAV model, all air flows are computed based on the
duct static pressure distribution and the performance curves of the fans.
Local loop control is implemented using proportional and proportional-integral
controllers, while the supervisory control is implemented
using a finite state machine.
</p>
<p>
A similar model but with a different control sequence can be found in
<a href=\"modelica://Buildings.Examples.VAVReheat.Guideline36\">
Buildings.Examples.VAVReheat.Guideline36</a>.
</p>
<h4>References</h4>
<p>
ASHRAE.
<i>Sequences of Operation for Common HVAC Systems</i>.
ASHRAE, Atlanta, GA, 2006.
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
          "modelica://Buildings/Resources/Scripts/Dymola/Examples/VAVReheat/ASHRAE2006.mos"
        "Simulate and plot"),
    experiment(StopTime=172800, Tolerance=1e-06));
end BICMid;
