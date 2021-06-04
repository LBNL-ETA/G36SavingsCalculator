within BestInClass.Controls;
block RoomVAV "Controller for room VAV box"
  extends Modelica.Blocks.Icons.Block;

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TRooHeaSet(
    final quantity="ThermodynamicTemperature",
    final unit = "K",
    displayUnit = "degC",
    min=0)
    "Setpoint temperature for room for heating"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
        iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TRooCooSet(
    final quantity="ThermodynamicTemperature",
    final unit = "K",
    displayUnit = "degC",
    min=0)
    "Setpoint temperature for room for cooling"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-140,20},{-100,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TRoo(
    final quantity="ThermodynamicTemperature",
    final unit = "K",
    displayUnit = "degC",
    min=0) "Measured room temperature"
    annotation (Placement(transformation(extent={{-140,-58},{-100,-18}}),
        iconTransformation(extent={{-140,-58},{-100,-18}})));

  Modelica.Blocks.Interfaces.RealOutput yVal "Signal for heating coil valve"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput yDam "Signal for VAV damper"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));

  Buildings.Controls.OBC.CDL.Continuous.LimPID conHea(
    yMax=1,
    xi_start=0.1,
    Td=60,
    yMin=0,
    k=2,
    Ti=900,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.P)
            "Controller for heating"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Buildings.Controls.Continuous.LimPID conCoo(
    yMax=1,
    Td=60,
    k=0.1,
    Ti=120,
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    reverseActing=not (true)) "Controller for cooling (acts on damper)"
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput PerFlo(final unit="1",
      min=0) "Minimum zone airflow" annotation (Placement(transformation(
          extent={{-140,-100},{-100,-60}}), iconTransformation(extent={{
            -140,-100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Continuous.Max max
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
protected
  parameter Real kDamHea = 0.5
    "Gain for VAV damper controller in heating mode";

equation
  connect(conHea.u_m, TRoo) annotation (Line(
      points={{-10,38},{-10,20},{-80,20},{-80,-38},{-120,-38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conCoo.u_m, TRoo) annotation (Line(
      points={{-10,-22},{-10,-38},{-120,-38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conHea.y,yVal)  annotation (Line(
      points={{2,50},{56,50},{56,40},{110,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conHea.u_s, TRooHeaSet) annotation (Line(points={{-22,50},{-72,50},{-72,
          80},{-120,80}}, color={0,0,127}));
  connect(TRooCooSet, conCoo.u_s) annotation (Line(points={{-120,40},{-50,40},{-50,
          -10},{-22,-10}}, color={0,0,127}));
  connect(max.y, yDam) annotation (Line(points={{42,-60},{70,-60},{70,-40},{110,
          -40}}, color={0,0,127}));
  connect(PerFlo, max.u2) annotation (Line(points={{-120,-80},{-52,-80},{-52,
          -66},{18,-66}}, color={0,0,127}));
  connect(conCoo.y, max.u1) annotation (Line(points={{1,-10},{10,-10},{10,-54},
          {18,-54}}, color={0,0,127}));
  annotation ( Icon(graphics={
        Text(
          extent={{-92,-16},{-44,-40}},
          lineColor={0,0,127},
          textString="TRoo"),
        Text(
          extent={{-92,-72},{-44,-96}},
          lineColor={0,0,127},
          textString="PerFlo"),
        Text(
          extent={{44,-34},{92,-58}},
          lineColor={0,0,127},
          textString="yHea"),
        Text(
          extent={{42,64},{90,40}},
          lineColor={0,0,127},
          textString="yDam"),
        Text(
          extent={{-90,100},{-42,76}},
          lineColor={0,0,127},
          textString="TRooHeaSet"),
        Text(
          extent={{-90,42},{-42,18}},
          lineColor={0,0,127},
          textString="TRooCooSet")}),
                                Documentation(info="<html>
<p>
Controller for terminal box of VAV system with reheat.
</p>
</html>", revisions="<html>
<ul>
<li>
September 20, 2017, by Michael Wetter:<br/>
Removed blocks with blocks from CDL package.
</li>
</ul>
</html>"));
end RoomVAV;
