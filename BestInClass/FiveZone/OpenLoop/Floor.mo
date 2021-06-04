within BestInClass.FiveZone.OpenLoop;
model Floor
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Air "Medium model";
  parameter Modelica.SIunits.Angle lat=41.98*3.14159/180 "Latitude";
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        "/home/kun/Documents/bic-savcal36/energyplus/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  ThermalZones.FloorNoGainNoInfiltrationNoWindow
                     floorNoGainNoInfiltrationNoWindow(
                           redeclare package Medium = Medium, lat=lat)
    annotation (Placement(transformation(extent={{-8,-8},{48,52}})));
equation
  connect(weaDat.weaBus, floorNoGainNoInfiltrationNoWindow.weaBus) annotation (
      Line(
      points={{-20,30},{29,30},{29,22}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=2592000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end Floor;
