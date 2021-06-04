within BestInClass.ThermalZones;
model ThermalZoneModified "Model to connect to an EnergyPlus thermal zone"
  extends Buildings.ThermalZones.EnergyPlus.BaseClasses.PartialEnergyPlusObject;

  parameter String zoneName "Name of the thermal zone as specified in the EnergyPlus input";
  parameter Integer nPorts=0 "Number of fluid ports (equals to 2 for one inlet and one outlet)" annotation (Evaluate=true,
      Dialog(
      connectorSizing=true,
      tab="General",
      group="Ports"));

  ////////////////////////////////////////////////////////////////////////////
  // Media declaration. This is identical to
  // Buildings.Fluid.Interfaces.LumpedVolumeDeclarations, except
  // that the comments have been changed to avoid a confusion about
  // what energyDynamics refers to.
  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);

  // Ports
  parameter Boolean use_C_flow=false
    "Set to true to enable input connector for trace substance that is connected to room air"
    annotation (Dialog(group="Ports"));

  // Initialization
  parameter Medium.AbsolutePressure p_start = Medium.p_default
    "Start value of zone air pressure"
    annotation(Dialog(tab = "Initialization"));
  parameter Medium.Temperature T_start=Medium.T_default
    "Start value of zone air temperature"
    annotation(Dialog(tab = "Initialization"));
  parameter Medium.MassFraction X_start[Medium.nX](
       quantity=Medium.substanceNames) = Medium.X_default
    "Start value of zone air mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
  parameter Medium.ExtraProperty C_start[Medium.nC](
       quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
    "Start value of zone air trace substances"
    annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));
  parameter Medium.ExtraProperty C_nominal[Medium.nC](
       quantity=Medium.extraPropertiesNames) = fill(1E-2, Medium.nC)
    "Nominal value of zone air trace substances. (Set to typical order of magnitude.)"
   annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));
  parameter Modelica.SIunits.Volume V;
  parameter Modelica.SIunits.Area AFlo;
  // final parameter Modelica.SIunits.Volume V = fmuZon.V "Zone volume";
  // final parameter Modelica.SIunits.Area AFlo = fmuZon.AFlo "Floor area";
  final parameter Real mSenFac(min=1)=fmuZon.mSenFac
    "Factor for scaling the sensible thermal mass of the zone air volume"
    annotation(Dialog(tab="Dynamics", group="Zone air"));
  //final parameter Real mSenFac = 5

  Modelica.Blocks.Interfaces.RealInput qGai_flow[3](each unit="W/m2")
    "Radiant, convective and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-240,80},{-200,120}})));

  Modelica.Blocks.Interfaces.RealInput[Medium.nC] C_flow if use_C_flow
    "Trace substance mass flow rate added to the medium"
    annotation (Placement(transformation(extent={{-240,-140},{-200,-100}}),
        iconTransformation(extent={{-240,-120},{-200,-80}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAir
    "Heat port to air volume" annotation (Placement(transformation(extent={{-10,-10},
            {10,10}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[nPorts](
      redeclare each package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(
        extent={{40,-10},{-40,10}},
        rotation=180,
        origin={0,-170}), iconTransformation(
        extent={{40,-10},{-40,10}},
        rotation=180,
        origin={0,-192})));
  Modelica.Blocks.Interfaces.RealOutput TAir(
    final unit="K",
    displayUnit="degC")
    "Air temperature of the zone"
    annotation (Placement(transformation(extent={{200,-10},{220,10}}),
        iconTransformation(extent={{200,128},{220,148}})));
  Modelica.Blocks.Interfaces.RealOutput TRad(
    final unit="K",
    displayUnit="degC")
    "Radiative temperature of the zone" annotation (Placement(transformation(
          extent={{200,-50},{220,-30}}), iconTransformation(extent={{200,90},{
            220,110}})));

  Buildings.ThermalZones.EnergyPlus.BaseClasses.FMUZoneAdapter fmuZon(
    final buildingsLibraryRoot=Buildings.ThermalZones.EnergyPlus.BaseClasses.buildingsLibraryRoot,
    final modelicaNameBuilding=modelicaNameBuilding,
    final modelicaNameThermalZone=modelicaNameThermalZone,
    final idfName=idfName,
    final weaName=epWeaName,
    final zoneName=zoneName,
    final nFluPor=nPorts,
    final usePrecompiledFMU=usePrecompiledFMU,
    final fmuName=fmuName,
    final verbosity=verbosity) "FMU zone adapter"
    annotation (Placement(transformation(extent={{80,100},{100,120}})));

protected
  constant String modelicaNameThermalZone = getInstanceName()
    "Name of this instance"
    annotation(HideResult=true);

  constant Modelica.SIunits.SpecificEnergy h_fg=
    Medium.enthalpyOfCondensingGas(273.15+37) "Latent heat of water vapor";

  final parameter Modelica.SIunits.MassFlowRate m_flow_nominal=
    V*3/3600 "Nominal mass flow rate (used for regularization)";

  Buildings.Fluid.Interfaces.ConservationEquation vol(
    redeclare final package Medium = Medium,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final p_start=p_start,
    final T_start=T_start,
    final X_start=X_start,
    final C_start=C_start,
    final C_nominal=C_nominal,
    final mSenFac=mSenFac,
    final use_mWat_flow=Medium.nXi > 0,
    final use_C_flow=use_C_flow,
    final fluidVolume=V,
    final nPorts=nPorts) "Air volume of the thermal zone"
    annotation (Placement(transformation(extent={{-10,-66},{10,-46}})));
  Buildings.ThermalZones.Detailed.BaseClasses.HeatGain heaGai(
    final AFlo=AFlo)
    "Model to convert internal heat gains"
    annotation (Placement(transformation(extent={{-180,90},{-160,110}})));
  Modelica.Blocks.Math.Gain mWat_flow(
    final k(unit="kg/J") = 1/h_fg,
    u(final unit="W"),
    y(final unit="kg/s")) "Water flow rate due to latent heat gain"
    annotation (Placement(transformation(extent={{-82,-32},{-62,-12}})));

  Modelica.Blocks.Math.Add QConLat_flow(final k1=1, final k2=1)
    "Total latent heat gains of the zone"
    annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
  Modelica.Blocks.Math.Add QGaiSenLat_flow(final k1=1, final k2=1)
    "Sensible and latent heat gains of the zone"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Math.Add QConTot_flow(final k1=1, final k2=1)
    "Total convective sensible heat gains of the zone"
    annotation (Placement(transformation(extent={{-120,52},{-100,72}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow conQCon_flow
    "Converter for convective heat flow rate"
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));

//  Modelica.Blocks.Sources.RealExpression mIn_flow[nPorts](
//    final y={ports[i].m_flow for i in 1:nPorts}) if nPorts > 0
//    "Inlet mass flow rates"
//    annotation (Placement(transformation(extent={{70,140},{90,160}})));

  final parameter String substanceName = "CO2" "Name of trace substance";

  final parameter Modelica.SIunits.MolarMass MM=
    Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
    "Molar mass of the trace substance";
  final parameter Real s[:]= {
    if ( Modelica.Utilities.Strings.isEqual(string1=Medium.extraPropertiesNames[i],
                                            string2=substanceName,
                                            caseSensitive=false))
    then 1 else 0 for i in 1:Medium.nC}
    "Vector with zero everywhere except where CO2 is";

  Modelica.Blocks.Math.Gain gaiCO2(
    u(final unit="W"),
    k=3.82E-8
      *Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
      /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM) if
       use_C_flow
    "CO2 emission in kg/s per Watt heat released by people"
    annotation (Placement(transformation(extent={{-160,-150},{-140,-130}})));

  Modelica.Blocks.Math.Add CTot_flow[Medium.nC](
    each final k1=1,
    each final k2=1) if use_C_flow
    "Total trace substance flow rate"
    annotation (Placement(transformation(extent={{-60,-136},{-40,-116}})));

  Buildings.Fluid.Sensors.MassFlowRate senMasFlo[nPorts](
    redeclare each final package Medium = Medium,
    each final allowFlowReversal=true) "Mass flow rate sensor" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={0,-100})));

  Modelica.Blocks.Math.MatrixGain matrixGain(final K=s) if
       use_C_flow
    "Gain to convert CO2 emission from scalar to vector"
    annotation (Placement(transformation(extent={{-120,-150},{-100,-130}})));

  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heaFloSen
    "Heat flow sensor"
    annotation (Placement(transformation(extent={{-32,-10},{-52,10}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature preTem
    "Port temperature"
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Sources.RealExpression TFlu(y=Medium.temperature_phX(
        p=vol.medium.p,
        h=vol.hOut,
        X=cat(
          1,
          vol.XiOut,
          {1 - sum(vol.XiOut)}))) "Air temperature of control volume"
    annotation (Placement(transformation(extent={{-160,-10},{-140,10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem[nPorts](redeclare each
      final package Medium = Medium, each final m_flow_nominal=m_flow_nominal)
                                              "Supply air temperature sensor" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-140})));
initial equation
  assert(idfName <> "", "Must provide the name of the fmu file.");
  assert(zoneName <> "", "Must provide the name of the zone.");
 // assert(nPorts >= 2, "The zone must have at least one air inlet and outlet.");

equation
  connect(heaGai.qGai_flow, qGai_flow) annotation (Line(points={{-182,100},{-220,
          100}},                            color={0,0,127}));
  connect(fmuZon.TRad, TRad) annotation (Line(points={{101,116},{126,116},{126,-40},
          {210,-40}}, color={0,0,127}));
  connect(heaGai.QRad_flow, fmuZon.QGaiRad_flow)
    annotation (Line(points={{-158,106},{-40,106},{-40,102},{78,102}},
                                                   color={0,0,127}));
  connect(heaGai.QCon_flow, QConTot_flow.u1) annotation (Line(points={{-158,100},
          {-132,100},{-132,68},{-122,68}}, color={0,0,127}));
  connect(fmuZon.QCon_flow, QConTot_flow.u2) annotation (Line(points={{101,112},
          {120,112},{120,88},{-128,88},{-128,56},{-122,56}}, color={0,0,127}));
  connect(heaGai.QLat_flow, QConLat_flow.u1) annotation (Line(points={{-158,94},
          {-142,94},{-142,36},{-122,36}}, color={0,0,127}));
  connect(fmuZon.QLat_flow, QConLat_flow.u2) annotation (Line(points={{101,108},
          {114,108},{114,84},{-146,84},{-146,24},{-122,24}}, color={0,0,127}));
  connect(QGaiSenLat_flow.u1, QConTot_flow.y) annotation (Line(points={{-82,46},
          {-90,46},{-90,62},{-99,62}}, color={0,0,127}));
  connect(QGaiSenLat_flow.u2, QConLat_flow.y) annotation (Line(points={{-82,34},
          {-90,34},{-90,30},{-99,30}}, color={0,0,127}));
  connect(QGaiSenLat_flow.y, conQCon_flow.Q_flow)
    annotation (Line(points={{-59,40},{-40,40}}, color={0,0,127}));
  connect(conQCon_flow.port, heaPorAir)
    annotation (Line(points={{-20,40},{0,40},{0,0}}, color={191,0,0}));
  connect(QConLat_flow.y, mWat_flow.u) annotation (Line(points={{-99,30},{-90,30},
          {-90,-22},{-84,-22}},
                            color={0,0,127}));
  connect(mWat_flow.y, vol.mWat_flow) annotation (Line(points={{-61,-22},{-50,-22},
          {-50,-54},{-12,-54}}, color={0,0,127}));
  connect(fmuZon.QPeo_flow, gaiCO2.u) annotation (Line(points={{101,104},{108,104},
          {108,-190},{-172,-190},{-172,-140},{-162,-140}},      color={0,0,127}));
  connect(CTot_flow.y, vol.C_flow) annotation (Line(points={{-39,-126},{-26,-126},
          {-26,-60},{-12,-60}}, color={0,0,127}));
  connect(C_flow, CTot_flow.u1) annotation (Line(points={{-220,-120},{-62,-120}},
                                   color={0,0,127}));
  for i in 1:nPorts loop
    connect(fmuZon.m_flow[i], senMasFlo[i].m_flow) annotation (Line(points={{78,110},
            {66,110},{66,-100},{11,-100}},
                                     color={0,0,127}));
    connect(senMasFlo[i].port_b, vol.ports[i]) annotation (Line(points={{
            4.44089e-16,-90},{0,-90},{0,-66}},
                                      color={0,127,255}));
    connect(fmuZon.TInlet[i], senTem[i].T) annotation (Line(points={{78,106},{
            70,106},{70,-140},{11,-140}},
                              color={0,0,127}));
    connect(senMasFlo[i].port_a, senTem[i].port_b)  annotation (Line(points={{0,-110},
            {0,-130}},                                                                           color={0,127,255}));
    connect(senTem[i].port_a, ports[i])  annotation (Line(points={{0,-150},{0,
            -170}},                                                                   color={0,127,255}));
  end for;
  connect(matrixGain.u[1], gaiCO2.y)
    annotation (Line(points={{-122,-140},{-139,-140}}, color={0,0,127}));
  connect(matrixGain.y, CTot_flow.u2) annotation (Line(points={{-99,-140},{-80,-140},
          {-80,-132},{-62,-132}}, color={0,0,127}));
  connect(TFlu.y, preTem.T)
    annotation (Line(points={{-139,0},{-122,0}}, color={0,0,127}));
  connect(heaFloSen.port_b,preTem. port)
    annotation (Line(points={{-52,0},{-100,0}},           color={191,0,0}));
  connect(heaFloSen.port_a, heaPorAir)
    annotation (Line(points={{-32,0},{0,0}}, color={191,0,0}));
  connect(TFlu.y, fmuZon.T) annotation (Line(points={{-139,0},{-132,0},{-132,16},
          {60,16},{60,118},{78,118}}, color={0,0,127}));
  connect(TFlu.y, TAir) annotation (Line(points={{-139,0},{-132,0},{-132,16},{180,
          16},{180,0},{210,0}}, color={0,0,127}));
  connect(heaFloSen.Q_flow, vol.Q_flow)
    annotation (Line(points={{-42,-10},{-42,-50},{-12,-50}}, color={0,0,127}));
  connect(vol.XiOut[1], fmuZon.X_w) annotation (Line(points={{0,-45},{0,-20},{56,
          -20},{56,114},{78,114}}, color={0,0,127}));
  annotation (
  defaultComponentName="zon",
   Icon(coordinateSystem(preserveAspectRatio=false,
   extent={{-200,-200},{200,200}}),
                         graphics={
        Rectangle(
          extent={{-200,-200},{200,200}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-172,178},{180,-182}},
          pattern=LinePattern.None,
          lineColor={117,148,176},
          fillColor={170,213,255},
          fillPattern=FillPattern.Sphere),
        Bitmap(extent={{62,-190},{164,-88}},
          fileName="modelica://Buildings/Resources/Images/Fluid/FMI/FMI_icon.png",
          visible=usePrecompiledFMU),
        Text(
          extent={{-144,162},{-40,132}},
          lineColor={0,0,0},
          textString="%idfName",
          visible=not usePrecompiledFMU),
        Text(
          extent={{-142,130},{-38,100}},
          lineColor={0,0,0},
          textString="%zoneName"),
        Rectangle(
          extent={{180,70},{200,-70}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{118,116},{168,88}},
          lineColor={0,0,0},
          fillColor={61,61,61},
          fillPattern=FillPattern.Solid,
          textString="TRad"),
        Text(
          extent={{-60,12},{-22,-10}},
          lineColor={0,0,0},
          fillColor={61,61,61},
          fillPattern=FillPattern.Solid,
          textString="air"),
        Rectangle(
          extent={{186,70},{194,-70}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-220,118},{-144,86}},
          lineColor={0,0,0},
          textString="q"),
        Text(
          extent={{-188,-94},{-112,-126}},
          lineColor={0,0,127},
          textString="C_flow",
          visible=use_C_flow),
        Text(
          extent={{116,154},{166,126}},
          lineColor={0,0,0},
          fillColor={61,61,61},
          fillPattern=FillPattern.Solid,
          textString="TAir"),
        Text(
          extent={{-58,244},{56,204}},
          lineColor={0,0,255},
          textString="%name")}),
   Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}})),
    Documentation(info="<html>
<p>
Model for a thermal zone that is implemented in EnergyPlus.
</p>
<p>
This model instantiates the FMU with the name <code>idfName</code> and
connects to the thermal zone with name <code>zoneName</code>.
If the FMU is already instantiated by another instance of this model,
it will use the already instantiated FMU. Hence, for each thermal zone
in an EnergyPlus FMU, one instance of this model needs to be used.
</p>
<p>
If there are two instances that declare the same
<code>idfName</code> and the same <code>zoneName</code>,
the simulation will stop with an error.
</p>
<h4>Main Equations</h4>
<p>
This model computes in Modelica the air energy, mass and species
balance. The convective heat transfer with the building fabric,
the long-wave and the short-wave radiation are computed by EnergyPlus.
</p>
<h5>Heat and mass balance</h5>
<p>
The zone uses a volume of air that is fully mixed. The size of this volume,
and its floor area, which is used to scale the heat gains <code>q_flow</code>,
are obtained from the EnergyPlus model.
By default, the air uses a dynamic balance. With the parameter
<code>energyBalance</code>, the type of energy balance can be configured.
The parameter <code>mSenFac</code> is used to increase the sensible heat capacity
of the zone air. By default, <code>mSenFac=1</code>. Higher values can be
used to approximate the sensible heat capacity of furnitures.
The latent heat capacity is not affected by this parameter.
</p>

<h5>Contaminant balance</h5>
<p>
The model has a parameter <code>use_C_flow</code>. If set to <code>true</code>,
then an input connector <code>C_flow</code> is enabled, which allows adding trace substances
to the room air. Note that this requires a medium model that has trace substances enabled.
</p>
<h5>Heat gains and CO2 added by people</h5>
<p>
If the EnergyPlus model computes internal heat gains
such as from people or equipment, then their sensible convective
and latent heat gains are added to the the room model.
Similarly, if people are modeled in EnergyPlus (using the
EnergyPlus <code>People</code> object), <i>and</i> if the
Modelica <code>Medium</code> contains CO2 (e.g., if
<code>Medium.nC &gt; 0</code> and
there is a <code>Medium.substanceName = \"CO2\"</code>),
then the CO2 emitted by the people is added to this volume.
However, the \"Generic Contaminant\" modeled in EnergyPlus is not
added to the air volume. (Because EnergyPlus does not declare the
name of the species or its molar mass and hence it cannot be matched
to species in Modelica or converted to emitted mass flow rate.)
</p>
</html>", revisions="<html>
<ul>
<li>
November 22, 2019, by Michael Wetter:<br/>
Replaced volume with dynamic balance.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1657\">issue 1657</a>.
</li>
<li>
April 04, 2018, by Thierry S. Nouidui:<br/>
Added additional parameters for parametrizing
the EnergyPlus model.
</li>
<li>
March 21, 2018, by Thierry S. Nouidui:<br/>
Revised implementation for efficiency.
</li>
<li>
February 14, 2018, by Michael Wetter:<br/>
First implementation for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1129\">issue 1129</a>.
</li>
</ul>
</html>"));
end ThermalZoneModified;
