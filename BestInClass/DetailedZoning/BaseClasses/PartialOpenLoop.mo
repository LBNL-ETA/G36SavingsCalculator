within BestInClass.DetailedZoning.BaseClasses;
partial model PartialOpenLoop

  parameter Real yFanMin = 0.1
    "Minimum fan speed";
  parameter Modelica.SIunits.Temperature THeaOn=293.15
    "Heating setpoint during on";
  parameter Modelica.SIunits.Temperature THeaOff=285.15
    "Heating setpoint during off";
  parameter Modelica.SIunits.Temperature TCooOn=297.15
    "Cooling setpoint during on";
  parameter Modelica.SIunits.Temperature TCooOff=303.15
    "Cooling setpoint during off";
  parameter Modelica.SIunits.PressureDifference dpBuiStaSet(displayUnit="Pa")=12
    "Building static pressure";

  FloorDetailed Building(
    idfFile=par.idfFile,
    weaFile=par.weaFile,
    m_flow_zone=par.m_flow_zone,
    m_flow_sys=par.m_flow_sys)
    "Thermal zone models of building with VAV boxes"
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weather(filNam=
        Modelica.Utilities.Files.loadResource(par.weaFile)) "Weather data"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Buildings.Controls.SetPoints.OccupancySchedule occupancy(occupancy=3600*par.occupancyTable,
      period=365*24*3600)
    "Occupancy schedule"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Buildings.Examples.VAVReheat.Controls.FanVFD
    fanVFD(xSet_nominal(
    displayUnit="Pa")=410,
    r_N_min=yFanMin)
    "Controller for supply fan"
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  AirHandlingUnit AHU(
    m_flow_nominal=par.m_flow_sys,
    THeaOn=THeaOn,
    THeaOff=THeaOff,
    TCooOn=TCooOn,
    TCooOff=TCooOff,
    dpBuiStaSet=dpBuiStaSet) "Air handing system for VAV"
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));

  Results res(
  final A=1660.75,
  PFan=AHU.fanSup.P + 0,
  PHeaAHU=AHU.heaCoi.Q2_flow,
  PHeaReh=
       Building.zoneVAV1.VAVbox.terHea.Q1_flow +
       Building.zoneVAV2.VAVbox.terHea.Q1_flow +
       Building.zoneVAV3.VAVbox.terHea.Q1_flow +
       Building.zoneVAV4.VAVbox.terHea.Q1_flow +
       Building.zoneVAV5.VAVbox.terHea.Q1_flow +
       Building.zoneVAV6.VAVbox.terHea.Q1_flow +
       Building.zoneVAV7.VAVbox.terHea.Q1_flow +
       Building.zoneVAV8.VAVbox.terHea.Q1_flow +
       Building.zoneVAV9.VAVbox.terHea.Q1_flow +
       Building.zoneVAV10.VAVbox.terHea.Q1_flow +
       Building.zoneVAV11.VAVbox.terHea.Q1_flow +
       Building.zoneVAV12.VAVbox.terHea.Q1_flow +
       Building.zoneVAV13.VAVbox.terHea.Q1_flow +
       Building.zoneVAV14.VAVbox.terHea.Q1_flow +
       Building.zoneVAV15.VAVbox.terHea.Q1_flow +
       Building.zoneVAV16.VAVbox.terHea.Q1_flow +
       Building.zoneVAV17.VAVbox.terHea.Q1_flow +
       Building.zoneVAV18.VAVbox.terHea.Q1_flow +
       Building.zoneVAV19.VAVbox.terHea.Q1_flow +
       Building.zoneVAV20.VAVbox.terHea.Q1_flow +
       Building.zoneVAV21.VAVbox.terHea.Q1_flow,
  PCooSen=AHU.cooCoi.QSen2_flow,
  PCooLat=AHU.cooCoi.QLat2_flow,
   T1=Building.zoneVAV1.zon.TAir,
   T2=Building.zoneVAV2.zon.TAir,
   T3=Building.zoneVAV3.zon.TAir,
   T4=Building.zoneVAV4.zon.TAir,
   T5=Building.zoneVAV5.zon.TAir,
   T6=Building.zoneVAV6.zon.TAir,
   T7=Building.zoneVAV7.zon.TAir,
   T8=Building.zoneVAV8.zon.TAir,
   T9=Building.zoneVAV9.zon.TAir,
   T10=Building.zoneVAV10.zon.TAir,
   T11=Building.zoneVAV11.zon.TAir,
   T12=Building.zoneVAV12.zon.TAir,
   T13=Building.zoneVAV13.zon.TAir,
   T14=Building.zoneVAV14.zon.TAir,
   T15=Building.zoneVAV15.zon.TAir,
   T16=Building.zoneVAV16.zon.TAir,
   T17=Building.zoneVAV17.zon.TAir,
   T18=Building.zoneVAV18.zon.TAir,
   T19=Building.zoneVAV19.zon.TAir,
   T20=Building.zoneVAV20.zon.TAir,
   T21=Building.zoneVAV21.zon.TAir,
   TSetHea=Building.zoneVAV1.TRooHeaSet,
   TSetCoo=Building.zoneVAV1.TRooCooSet)
  "Results of the simulation";

  InternalGains internalGains(
    kLig=par.kLig,
    kEqu=par.kEqu,
    peoFile=par.peoFile,
    ligFile=par.ligFile,
    equFile=par.equFile)
    "Internal gains including people, lighting and equipment"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));

  Parameters par(
    idfFile="modelica://BestInClass/Resources/idf/MediumOfficeDetailed_2004_la.idf",
    weaFile="modelica://BestInClass/Resources/weather/USA_CA_Los.Angeles.Intl.AP.722950_TMY3.mos",
    peoFile="modelica://BestInClass/Resources/intGai/people_low.dat",
    ligFile="modelica://BestInClass/Resources/intGai/lights_low.dat",
    equFile="modelica://BestInClass/Resources/intGai/equipment_low.dat",
    TSupSetCoo=285.15,
    pSetCon(displayUnit="Pa") = 410,
    minAirFra,
    TOutLow=289.15,
    TOutHigh=294.15,
    TSupSetCooLow=285.15,
    TSupSetCooHigh=291.15,
    pSetMin(displayUnit="Pa") = 50,
    pSetMax(displayUnit="Pa") = 410,
    kLig=1,
    kEqu=1,
    occupancyTable={32.0,42.0,56.0,66.0,80.0,90.0,152.0,162.0,176.0,186.0,200.0,
        210.0,224.0,234.0,248.0,258.0,320.0,330.0,344.0,354.0,368.0,378.0,392.0,
        402.0,416.0,426.0,512.0,522.0,536.0,546.0,560.0,570.0,584.0,594.0,656.0,
        666.0,680.0,690.0,704.0,714.0,728.0,738.0,752.0,762.0,824.0,834.0,848.0,
        858.0,872.0,882.0,896.0,906.0,920.0,930.0,992.0,1002.0,1016.0,1026.0,
        1040.0,1050.0,1064.0,1074.0,1088.0,1098.0,1184.0,1194.0,1208.0,1218.0,
        1232.0,1242.0,1256.0,1266.0,1328.0,1338.0,1352.0,1362.0,1376.0,1386.0,
        1400.0,1410.0,1424.0,1434.0,1496.0,1506.0,1520.0,1530.0,1544.0,1554.0,
        1568.0,1578.0,1592.0,1602.0,1664.0,1674.0,1688.0,1698.0,1712.0,1722.0,
        1736.0,1746.0,1760.0,1770.0,1832.0,1842.0,1856.0,1866.0,1880.0,1890.0,
        1904.0,1914.0,1928.0,1938.0,2000.0,2010.0,2024.0,2034.0,2048.0,2058.0,
        2072.0,2082.0,2096.0,2106.0,2168.0,2178.0,2192.0,2202.0,2216.0,2226.0,
        2240.0,2250.0,2264.0,2274.0,2336.0,2346.0,2360.0,2370.0,2384.0,2394.0,
        2408.0,2418.0,2432.0,2442.0,2504.0,2514.0,2528.0,2538.0,2552.0,2562.0,
        2576.0,2586.0,2600.0,2610.0,2672.0,2682.0,2696.0,2706.0,2720.0,2730.0,
        2744.0,2754.0,2768.0,2778.0,2840.0,2850.0,2864.0,2874.0,2888.0,2898.0,
        2912.0,2922.0,2936.0,2946.0,3008.0,3018.0,3032.0,3042.0,3056.0,3066.0,
        3080.0,3090.0,3104.0,3114.0,3176.0,3186.0,3200.0,3210.0,3224.0,3234.0,
        3248.0,3258.0,3272.0,3282.0,3344.0,3354.0,3368.0,3378.0,3392.0,3402.0,
        3416.0,3426.0,3440.0,3450.0,3536.0,3546.0,3560.0,3570.0,3584.0,3594.0,
        3608.0,3618.0,3680.0,3690.0,3704.0,3714.0,3728.0,3738.0,3752.0,3762.0,
        3776.0,3786.0,3848.0,3858.0,3872.0,3882.0,3896.0,3906.0,3920.0,3930.0,
        3944.0,3954.0,4016.0,4026.0,4040.0,4050.0,4064.0,4074.0,4088.0,4098.0,
        4112.0,4122.0,4184.0,4194.0,4208.0,4218.0,4232.0,4242.0,4256.0,4266.0,
        4280.0,4290.0,4352.0,4362.0,4376.0,4386.0,4400.0,4410.0,4448.0,4458.0,
        4520.0,4530.0,4544.0,4554.0,4568.0,4578.0,4592.0,4602.0,4616.0,4626.0,
        4688.0,4698.0,4712.0,4722.0,4736.0,4746.0,4760.0,4770.0,4784.0,4794.0,
        4856.0,4866.0,4880.0,4890.0,4904.0,4914.0,4928.0,4938.0,4952.0,4962.0,
        5024.0,5034.0,5048.0,5058.0,5072.0,5082.0,5096.0,5106.0,5120.0,5130.0,
        5192.0,5202.0,5216.0,5226.0,5240.0,5250.0,5264.0,5274.0,5288.0,5298.0,
        5360.0,5370.0,5384.0,5394.0,5408.0,5418.0,5432.0,5442.0,5456.0,5466.0,
        5528.0,5538.0,5552.0,5562.0,5576.0,5586.0,5600.0,5610.0,5624.0,5634.0,
        5696.0,5706.0,5720.0,5730.0,5744.0,5754.0,5768.0,5778.0,5792.0,5802.0,
        5888.0,5898.0,5912.0,5922.0,5936.0,5946.0,5960.0,5970.0,6032.0,6042.0,
        6056.0,6066.0,6080.0,6090.0,6104.0,6114.0,6128.0,6138.0,6200.0,6210.0,
        6224.0,6234.0,6248.0,6258.0,6272.0,6282.0,6296.0,6306.0,6368.0,6378.0,
        6392.0,6402.0,6416.0,6426.0,6440.0,6450.0,6464.0,6474.0,6536.0,6546.0,
        6560.0,6570.0,6584.0,6594.0,6608.0,6618.0,6632.0,6642.0,6704.0,6714.0,
        6728.0,6738.0,6752.0,6762.0,6776.0,6786.0,6800.0,6810.0,6896.0,6906.0,
        6920.0,6930.0,6944.0,6954.0,6968.0,6978.0,7040.0,7050.0,7064.0,7074.0,
        7088.0,7098.0,7112.0,7122.0,7136.0,7146.0,7208.0,7218.0,7232.0,7242.0,
        7256.0,7266.0,7280.0,7290.0,7304.0,7314.0,7376.0,7386.0,7400.0,7410.0,
        7424.0,7434.0,7448.0,7458.0,7472.0,7482.0,7568.0,7578.0,7592.0,7602.0,
        7616.0,7626.0,7640.0,7650.0,7712.0,7722.0,7736.0,7746.0,7760.0,7770.0,
        7784.0,7794.0,7808.0,7818.0,7880.0,7890.0,7904.0,7914.0,7928.0,7938.0,
        7976.0,7986.0,8048.0,8058.0,8072.0,8082.0,8096.0,8106.0,8120.0,8130.0,
        8144.0,8154.0,8216.0,8226.0,8240.0,8250.0,8264.0,8274.0,8288.0,8298.0,
        8312.0,8322.0,8384.0,8394.0,8408.0,8418.0,8432.0,8442.0,8456.0,8466.0,
        8480.0,8490.0,8552.0,8562.0,8576.0,8586.0,8624.0,8634.0,8648.0,8658.0,
        8720.0,8730.0,8744.0,8754.0},
    m_flow_zone=1.2*{0.061560,0.056151,0.056083,0.026633,0.336799,0.323095,
        0.202564,0.200068,0.066315,0.763101,0.735590,0.121420,0.160094,0.108582,
        0.480082,0.523129,0.499773,0.728862,0.109132,0.054565,0.056081},
    m_flow_sys=1.2*5.1039)
    "Parameters for parametric studies"
    annotation (Placement(transformation(extent={{60,72},{80,92}})));

protected
  model Results "Model to store the results of the simulation"
    parameter Modelica.SIunits.Area A "Floor area";
    input Modelica.SIunits.Power PFan "Fan power";
    input Modelica.SIunits.Power PHeaAHU "AHU heating coil power";
    input Modelica.SIunits.Power PHeaReh "Reheat coil power";
    //input Modelica.SIunits.Power PHea "Total heating power";
    input Modelica.SIunits.Power PCooSen "Sensible cooling power";
    input Modelica.SIunits.Power PCooLat "Latent cooling power";
    //input Modelica.SIunits.Power PCoo "Total cooling power";
     input Modelica.SIunits.Temperature T1;
     input Modelica.SIunits.Temperature T2;
     input Modelica.SIunits.Temperature T3;
     input Modelica.SIunits.Temperature T4;
     input Modelica.SIunits.Temperature T5;
     input Modelica.SIunits.Temperature T6;
     input Modelica.SIunits.Temperature T7;
     input Modelica.SIunits.Temperature T8;
     input Modelica.SIunits.Temperature T9;
     input Modelica.SIunits.Temperature T10;
     input Modelica.SIunits.Temperature T11;
     input Modelica.SIunits.Temperature T12;
     input Modelica.SIunits.Temperature T13;
     input Modelica.SIunits.Temperature T14;
     input Modelica.SIunits.Temperature T15;
     input Modelica.SIunits.Temperature T16;
     input Modelica.SIunits.Temperature T17;
     input Modelica.SIunits.Temperature T18;
     input Modelica.SIunits.Temperature T19;
     input Modelica.SIunits.Temperature T20;
     input Modelica.SIunits.Temperature T21;
     input Modelica.SIunits.Temperature TSetHea;
     input Modelica.SIunits.Temperature TSetCoo;
     Real ErrCooling1, ErrCooling2, ErrCooling3, ErrCooling4, ErrCooling5,
          ErrCooling6, ErrCooling7, ErrCooling8, ErrCooling9, ErrCooling10,
          ErrCooling11, ErrCooling12, ErrCooling13, ErrCooling14, ErrCooling15,
          ErrCooling16, ErrCooling17, ErrCooling18, ErrCooling19, ErrCooling20,
          ErrCooling21, ErrCooling;
     Real ErrHeating1, ErrHeating2, ErrHeating3, ErrHeating4, ErrHeating5,
          ErrHeating6, ErrHeating7, ErrHeating8, ErrHeating9, ErrHeating10,
          ErrHeating11, ErrHeating12, ErrHeating13, ErrHeating14, ErrHeating15,
          ErrHeating16, ErrHeating17, ErrHeating18, ErrHeating19, ErrHeating20,
          ErrHeating21, ErrHeating;

    Real EFan(
      unit="J/m2",
      start=0,
      nominal=1E5,
      fixed=true) "Fan energy";
    Real EHeaAHU(
      unit="J/m2",
      start=0,
      nominal=1E5,
      fixed=true) "AHU heating energy";
    Real EHeaReh(
      unit="J/m2",
      start=0,
      nominal=1E5,
      fixed=true) "Reheat heating energy";
    Real EHea(
      unit="J/m2",
      start=0,
      nominal=1E5,
      fixed=true) "Heating energy";
    Real ECooSen(
      unit="J/m2",
      start=0,
      nominal=1E5,
      fixed=true) "Sensible cooling energy";
    Real ECooLat(
      unit="J/m2",
      start=0,
      nominal=1E5,
      fixed=true) "Latent cooling energy";
    Real ECoo(unit="J/m2") "Total cooling energy";

    Real DiscomfortCooling(start=0,fixed=true) "Discomfort in cooling mode";
    Real DiscomfortHeating(start=0,fixed=true) "Discomfort in heating mode";

  equation

    A*der(EFan) = PFan;
    A*der(EHeaAHU) = PHeaAHU;
    A*der(EHeaReh) = PHeaReh;
    EHea = EHeaAHU+EHeaReh;
    A*der(ECooSen) = PCooSen;
    A*der(ECooLat) = PCooLat;
    ECoo = ECooSen+ECooLat;

    ErrCooling1 = if T1<=TSetCoo then 0 else T1-TSetCoo;
    ErrCooling2 = if T2<=TSetCoo then 0 else T2-TSetCoo;
    ErrCooling3 = if T3<=TSetCoo then 0 else T3-TSetCoo;
    ErrCooling4 = if T4<=TSetCoo then 0 else T4-TSetCoo;
    ErrCooling5 = if T5<=TSetCoo then 0 else T5-TSetCoo;
    ErrCooling6 = if T6<=TSetCoo then 0 else T6-TSetCoo;
    ErrCooling7 = if T7<=TSetCoo then 0 else T7-TSetCoo;
    ErrCooling8 = if T8<=TSetCoo then 0 else T8-TSetCoo;
    ErrCooling9 = if T9<=TSetCoo then 0 else T9-TSetCoo;
    ErrCooling10 = if T10<=TSetCoo then 0 else T10-TSetCoo;
    ErrCooling11 = if T11<=TSetCoo then 0 else T11-TSetCoo;
    ErrCooling12 = if T12<=TSetCoo then 0 else T12-TSetCoo;
    ErrCooling13 = if T13<=TSetCoo then 0 else T13-TSetCoo;
    ErrCooling14 = if T14<=TSetCoo then 0 else T14-TSetCoo;
    ErrCooling15 = if T15<=TSetCoo then 0 else T15-TSetCoo;
    ErrCooling16 = if T16<=TSetCoo then 0 else T16-TSetCoo;
    ErrCooling17 = if T17<=TSetCoo then 0 else T17-TSetCoo;
    ErrCooling18 = if T18<=TSetCoo then 0 else T18-TSetCoo;
    ErrCooling19 = if T19<=TSetCoo then 0 else T19-TSetCoo;
    ErrCooling20 = if T20<=TSetCoo then 0 else T20-TSetCoo;
    ErrCooling21 = if T21<=TSetCoo then 0 else T21-TSetCoo;
    ErrCooling = (ErrCooling1+ErrCooling2+ErrCooling3+ErrCooling4+ErrCooling5+ErrCooling6+ErrCooling7+
                 ErrCooling8+ErrCooling9+ErrCooling10+ErrCooling11+ErrCooling12+ErrCooling13+ErrCooling14+
                 ErrCooling15+ErrCooling16+ErrCooling17+ErrCooling18+ErrCooling19+ErrCooling20+ErrCooling21)/3600;
    der(DiscomfortCooling)=ErrCooling;

    ErrHeating1 = if T1>=TSetHea then 0 else TSetHea-T1;
    ErrHeating2 = if T2>=TSetHea then 0 else TSetHea-T2;
    ErrHeating3 = if T3>=TSetHea then 0 else TSetHea-T3;
    ErrHeating4 = if T4>=TSetHea then 0 else TSetHea-T4;
    ErrHeating5 = if T5>=TSetHea then 0 else TSetHea-T5;
    ErrHeating6 = if T6>=TSetHea then 0 else TSetHea-T6;
    ErrHeating7 = if T7>=TSetHea then 0 else TSetHea-T7;
    ErrHeating8 = if T8>=TSetHea then 0 else TSetHea-T8;
    ErrHeating9 = if T9>=TSetHea then 0 else TSetHea-T9;
    ErrHeating10 = if T10>=TSetHea then 0 else TSetHea-T10;
    ErrHeating11 = if T11>=TSetHea then 0 else TSetHea-T11;
    ErrHeating12 = if T12>=TSetHea then 0 else TSetHea-T12;
    ErrHeating13 = if T13>=TSetHea then 0 else TSetHea-T13;
    ErrHeating14 = if T14>=TSetHea then 0 else TSetHea-T14;
    ErrHeating15 = if T15>=TSetHea then 0 else TSetHea-T15;
    ErrHeating16 = if T16>=TSetHea then 0 else TSetHea-T16;
    ErrHeating17 = if T17>=TSetHea then 0 else TSetHea-T17;
    ErrHeating18 = if T18>=TSetHea then 0 else TSetHea-T18;
    ErrHeating19 = if T19>=TSetHea then 0 else TSetHea-T19;
    ErrHeating20 = if T20>=TSetHea then 0 else TSetHea-T20;
    ErrHeating21 = if T21>=TSetHea then 0 else TSetHea-T21;
    ErrHeating = (ErrHeating1+ErrHeating2+ErrHeating3+ErrHeating4+ErrHeating5+ErrHeating6+ErrHeating7+
                 ErrHeating8+ErrHeating9+ErrHeating10+ErrHeating11+ErrHeating12+ErrHeating13+ErrHeating14+
                 ErrHeating15+ErrHeating16+ErrHeating17+ErrHeating18+ErrHeating19+ErrHeating20+ErrHeating21)/3600;
    der(DiscomfortHeating)=ErrHeating;

  end Results;
equation
  connect(occupancy.occupied, AHU.occupied) annotation (Line(points={{-59,14},{
          12,14},{12,-4},{19,-4}}, color={255,0,255}));
  connect(occupancy.tNexOcc, AHU.tNexOcc) annotation (Line(points={{-59,26},{14,
          26},{14,-1},{19,-1}}, color={0,0,127}));
  connect(Building.TRooMin, AHU.TRooMin) annotation (Line(
      points={{81,-14},{84,-14},{84,-24},{16,-24},{16,-19},{19,-19}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Building.TRooAve, AHU.TRooAve) annotation (Line(
      points={{81,-10},{86,-10},{86,-26},{14,-26},{14,-16},{19,-16}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(AHU.fanOn,fanVFD.uFan) annotation (Line(points={{41,-5},{44,-5},{44,6},
          {-26,6},{-26,-4},{-22,-4}},      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(AHU.dPFan,fanVFD.u_m) annotation (Line(points={{41,-8},{44,-8},{44,
          -30},{-10,-30},{-10,-22}},
                                  color={0,0,127},
      pattern=LinePattern.Dash));
  connect(AHU.TRooHeaSet,Building.TRooHeaSet) annotation (Line(points={{41,-12},
          {52,-12},{52,-8},{59,-8}},  color={0,0,127},
      pattern=LinePattern.Dash));
  connect(AHU.TRooCooSet,Building.TRooCooSet) annotation (Line(points={{41,-15},
          {54,-15},{54,-12},{59,-12}},color={0,0,127},
      pattern=LinePattern.Dash));
  connect(AHU.supplyAir, Building.returnAir) annotation (Line(points={{40,-18.2},
          {50,-18.2},{50,-18.2},{60,-18.2}}, color={0,127,255},
      thickness=0.5));
  connect(AHU.returnAir, Building.supplyAir)   annotation (Line(points={{40,-2},{60,-2}}, color={0,127,255},
      thickness=0.5));
  connect(internalGains.qGaiFlo, Building.qGaiFlo) annotation (Line(points={{
          -59,80},{52,80},{52,-5},{59,-5}}, color={0,0,127}));
  connect(fanVFD.y, AHU.uFan) annotation (Line(points={{1,-10},{10,-10},{10,-13},
          {19,-13}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialOpenLoop;
