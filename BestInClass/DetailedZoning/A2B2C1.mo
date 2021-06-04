within BestInClass.DetailedZoning;
model A2B2C1
  extends Modelica.Icons.Example;
  extends BaseClasses.PartialOpenLoop(par(
      minAirFra=0.3,
      TSupSetCoo=285.15,
      TOutLow=289.15,
      TOutHigh=294.15,
      TSupSetCooLow=285.15,
      TSupSetCooHigh=291.15));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant minAirFra(k=par.minAirFra)
    "Minimum zone airflow fraction"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Controls.SupAirTemp TSupSetCoo(
    TOutLow=par.TOutLow,
    TOutHigh=par.TOutHigh,
    TSupSetCooLow=par.TSupSetCooLow,
    TSupSetCooHigh=par.TSupSetCooHigh)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-36,44},{-24,56}}), iconTransformation(extent=
           {{-174,26},{-154,46}})));
  Buildings.Examples.VAVReheat.Controls.DuctStaticPressureSetpoint
                                      pSetDuc(
    pMax=par.pSetMax,
    nin=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    pMin=par.pSetMin)
             "Duct static pressure setpoint"
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));

equation
  connect(pSetDuc.TOut, TSupSetCoo.TOut) annotation (Line(points={{-82,-2},{-88,
          -2},{-88,-39},{-81,-39}}, color={0,0,127}));
  connect(TSupSetCoo.TSet, AHU.TSupSetCoo) annotation (Line(points={{-59,-40},
          {10,-40},{10,-7},{19,-7}}, color={0,0,127}));
  connect(minAirFra.y,Building.minAirFra)  annotation (Line(points={{-58,-70},{
          56,-70},{56,-15},{59,-15}}, color={0,0,127}));
  connect(pSetDuc.y,fanVFD.u)     annotation (Line(points={{-59,-10},{-22,-10}},
                                                                               color={0,0,127}));
  connect(weaBus.TDryBul, pSetDuc.TOut) annotation (Line(
      points={{-30,50},{-30,36},{-88,36},{-88,-2},{-82,-2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weather.weaBus, weaBus) annotation (Line(
      points={{-60,50},{-30,50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, AHU.weaBus) annotation (Line(
      points={{-30,50},{21.6,50},{21.6,-2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(pSetDuc.u[1], Building.yVAVMax) annotation (Line(points={{-82,-10},{-86,
          -10},{-86,8},{86,8},{86,-6},{81,-6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=600,
      __Dymola_Algorithm="Dassl"));
end A2B2C1;
