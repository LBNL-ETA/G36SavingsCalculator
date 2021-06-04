within BestInClass.DetailedZoning.BaseClasses;
record Parameters "High-level parameters"
  extends Modelica.Icons.Record;

  parameter String idfFile "EnergyPlus IDF file";
  parameter String weaFile "Weather data";
  parameter String peoFile "People load schedule file";
  parameter String ligFile "Light load schedule file";
  parameter String equFile "Equipment load schedule file";
  parameter Real minAirFra "Minimum zone airflow fraction";
  parameter Modelica.SIunits.Temperature TSupSetCoo
    "Constant supply air temperature";
  parameter Modelica.SIunits.PressureDifference pSetCon
    "Constant static pressure";
  parameter Modelica.SIunits.Temperature TOutLow
    "Outdoor temperature at the low bound";
  parameter Modelica.SIunits.Temperature TOutHigh
    "Outdoor temperature at the high bound";
  parameter Modelica.SIunits.Temperature TSupSetCooLow
    "Cooling supply air temperature at the low bound";
  parameter Modelica.SIunits.Temperature TSupSetCooHigh
    "Cooling supply air temperature at the high bound";
  parameter Modelica.SIunits.PressureDifference pSetMin
    "Minimum static pressure";
  parameter Modelica.SIunits.PressureDifference pSetMax
    "Maximum static pressure";
  parameter Real kLig "Lighting design load";
  parameter Real kEqu "Equipment design load";
  parameter Real occupancyTable[:] "Occupancy table";
  parameter Real m_flow_zone[:] "Zone norminal flowrate";
  parameter Real m_flow_sys "AHU system norminal flowrate";

end Parameters;
