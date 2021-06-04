#!/usr/bin/env python
# coding: utf-8

import os
from buildingspy.io.outputfile import Reader
import matplotlib.pyplot as plt
import pandas as pd
import matplotlib.dates as mdates
import numpy as np


def save_plot(figure, case_name):
    """ Save the figure to a pdf and png file in the directory `img`
    """
    out_dir = "img"
    if not os.path.exists(out_dir):
        os.makedirs(out_dir)
    # figure.savefig(os.path.join(out_dir, '{}.pdf'.format(file_name)))
    figure.savefig(os.path.join(out_dir, '{}.png'.format(case_name)), dpi=300)
    plt.clf()

def get_results(case_name):
    """ Get the results for the case with name `case_name`
    """

    return Reader(case_name, "dymola")

def get_partial_results(case_name, list_of_variables):
    """ Get a dictionary with the variable names and the time series for `list_of_variables`
    """
    reader = get_results(case_name)
    d = dict()
    read_time = True
    for v in list_of_variables:
        if read_time:
            d['time'] = reader.values(v)[0]
            read_time = False
        d[v] = reader.values(v)[1]
    return d


COPc=3.2
COPh=4.0

def plot_energy(r_base, r_mid, r_g36):
    from buildingspy.io.outputfile import Reader
    import matplotlib.pyplot as plt

    plt.clf()

    # Conversion to kWh/m2
    conv = 1/3600./1000.
    results = [r_base, r_mid, r_g36]
    width = 0.5       # the width of the bars: can also be len(x) sequence

    hea    = [0., 0., 0.]
    cooSen = [0., 0., 0.]
    cooLat = [0., 0., 0.]
    fan    = [0., 0., 0.]
    cooLatBas = [0., 0., 0.]
    coo = [0, 0, 0]
    fanBas = [0., 0., 0.]

    idx = [0, 1, 2]
    for i in idx:
        res_dic = results[i]
        hea[i]    =  res_dic['res.EHea'][-1] * conv / COPh
        cooSen[i] = -res_dic['res.ECooSen'][-1] * conv / COPc
        cooLat[i] = -res_dic['res.ECooLat'][-1] * conv / COPc
        coo[i] = cooSen[i] + cooLat[i]
        fan[i]    =  res_dic['res.EFan'][-1] * conv
        cooLatBas[i] = hea[i] + cooSen[i]
        fanBas[i]    = cooLatBas[i] + cooLat[i]

    p1 = plt.bar(idx, hea, width, color='r')
    p2 = plt.bar(idx, cooSen, width, bottom=hea, color='g')
    p3 = plt.bar(idx, cooLat, width, bottom=cooLatBas, color='b')
    p4 = plt.bar(idx, fan,    width, bottom=fanBas, color='k')

    plt.ylabel('site electricity use [kWh/(m2  a)]')
    plt.xticks([0, 1, 2], ('base case', 'mid case', 'guideline 36'))
    plt.tick_params(axis=u'x', which=u'both',length=0)

    #plt.yticks(np.arange(0, 81, 10))
    plt.legend((p1[0], p2[0], p3[0], p4[0]),('heating', 'sensible cooling', 'latent cooling', 'fan'),loc='upper right')

    save_plot(plt, "energy")

    # Write result to console and file
    eSit = [0, 0, 0]
    for i in [0, 1, 2]:
        eSit[i] = hea[i]+cooSen[i]+cooLat[i]+fan[i]

    str = """.. table:: Heating, cooling, fan and total site energy, and savings of guideline 36 case versus reference cases.

   ===================================== ===================================== ====================================== ====================================== =====
   :math:`E_{{h}} \quad [kWh/(m^2\,a)]`    :math:`E_{{c}} \quad [kWh/(m^2\,a)]`    :math:`E_{{f}} \quad [kWh/(m^2\,a)]`     :math:`E_{{tot}} \quad [kWh/(m^2\,a)]`     [%]
   ===================================== ===================================== ====================================== ====================================== =====
   {:37.4} {:37.4}  {:37.4}  {:37.4}
   {:37.4} {:37.4}  {:37.4}  {:37.4}  {:4.3}
   {:37.4} {:37.4}  {:37.4}  {:37.4}  {:4.3}
   ===================================== ===================================== ====================================== ====================================== =====

  """.format(\
            hea[0], coo[0], fan[0], eSit[0],
            hea[1], coo[1], fan[1], eSit[1], (1-eSit[1]/eSit[0])*100.,
            hea[2], coo[2], fan[2], eSit[2], (1-eSit[2]/eSit[0])*100.)
    def save_rst(str, file_name):
        ''' Save the string `str` to the rst file `file_name.rst`
        '''
        print(str)
        with open(os.path.join("img", "{}.rst".format(file_name)), "w") as fil:
            fil.write(str)

    save_rst(str, "site_energy")

def get_plot_data(data, start_time, end_time):
    """
    Convert dictionary data to pandas and slice data for plotting
    """
    data = pd.DataFrame.from_dict(data)
    data.index = pd.to_datetime(data['time'], unit='s')
    data_plot = data.loc[start_time:end_time]

    return data_plot

def base_g36_ratio(base, g36, start_time, end_time, sample_rate):
    base_dur = get_plot_data(base, start_time, end_time, sample_rate)
    g36_dur = get_plot_data(g36, start_time, end_time, )
    Tbase = base_dur['zon.senTZon.T']
    Tg36 = g36_dur['zon.senTZon.T']
    Tout = g36_dur['weaBus.TDryBul']
    # sum of (Tg36-Tout) includes the time of cooling, which makes the ratio small
    ratio = np.sum(Tg36-Tbase)/np.sum(Tg36-Tout)*100
    print(ratio)

def plot_energy_month(base, g36):
    COP_h = 4.0 # heating equipment COP
    # Conversion to kWh/m2
    conv = 1/3600./1000/48.
    base = get_plot_data(base, '1970-01-01', '1970-12-31')
    g36 = get_plot_data(g36, '1970-01-01', '1970-12-31')
    # print(base['EHea.y']['1970-12-31'])
    year = '1970-'
    hour = ' 23:00'
    date = ['01-31','02-28','03-31','04-30','05-31','06-30','07-31','08-31','09-30','10-31','11-30','12-31']
    month = [year+d+hour for d in date]
    EHea = []
    ECoo = []
    EFan = []
    EPum = []
    for m in month:
        EHea.append(np.asscalar(base['res.EHea'][m].get_values()/COP_h*conv))
        ECoo.append(np.asscalar(base['res.ECoo'][m]*conv))
        EFan.append(np.asscalar(base['res.EFan'][m]*conv))
        #EPum.append(np.asscalar(base['res.EPum'][m]*conv))
    Heat = []
    Cool = []
    Fan = []
    #Pump = []
    fanBas = []
    #pumpBas = []
    for i in range(12):
        if i == 0:
            Heat.append(EHea[0])
            Cool.append(ECoo[0])
            Fan.append(EFan[0])
            #Pump.append(EPum[0])
        else:
            Heat.append(EHea[i] - EHea[i-1])
            Cool.append(ECoo[i] - ECoo[i-1])
            Fan.append(EFan[i] - EFan[i-1])
            #Pump.append(EPum[i] - EPum[i-1])
        fanBas.append(Heat[i]+Cool[i])
        #pumpBas.append(fanBas[i]+Pump[i])

    EHea_g36 = []
    ECoo_g36 = []
    EFan_g36 = []
    #EPum_g36 = []
    for m in month:
        EHea_g36.append(np.asscalar(g36['EHea.y'][m].get_values()/COP_h*conv))
        ECoo_g36.append(np.asscalar(g36['ECoo.y'][m]*conv))
        EFan_g36.append(np.asscalar(g36['EFan.y'][m]*conv))
        #EPum_g36.append(np.asscalar(g36['EPum.y'][m]*conv))
    Heat_g36 = []
    Cool_g36 = []
    Fan_g36 = []
    #Pump_g36 = []
    fanBas_g36 = []
    #pumpBas_g36 = []
    for i in range(12):
        if i == 0:
            Heat_g36.append(EHea_g36[0])
            Cool_g36.append(ECoo_g36[0])
            Fan_g36.append(EFan_g36[0])
            #Pump_g36.append(EPum_g36[0])
        else:
            Heat_g36.append(EHea_g36[i] - EHea_g36[i-1])
            Cool_g36.append(ECoo_g36[i] - ECoo_g36[i-1])
            Fan_g36.append(EFan_g36[i] - EFan_g36[i-1])
            #Pump_g36.append(EPum_g36[i] - EPum_g36[i-1])
        fanBas_g36.append(Heat_g36[i]+Cool_g36[i])
        #pumpBas_g36.append(fanBas_g36[i]+Pump_g36[i])

    width = 0.35
    labels = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
    x = np.arange(len(labels))  # the label locations
    fig, ax = plt.subplots()
    b1 = ax.bar(x - width/2, Heat, width,color='r')
    b2 = ax.bar(x - width/2, Cool, width, bottom=Heat,color='g')
    b3 = ax.bar(x - width/2, Fan, width, bottom=fanBas,color='b')
    #b4 = ax.bar(x - width/2, Pump, width, bottom=pumpBas,color='k')
    b5 = ax.bar(x + width/2, Heat_g36, width,color='r')
    b6 = ax.bar(x + width/2, Cool_g36, width, bottom=Heat_g36,color='g')
    b7 = ax.bar(x + width/2, Fan_g36, width, bottom=fanBas_g36,color='b')
    #b8 = ax.bar(x + width/2, Pump_g36, width, bottom=pumpBas_g36,color='k')
    labels = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
    ax.set_xticks(x)
    ax.set_xticklabels(labels)
    ax.set_ylabel('HVAC energy use [kWh/(m2-month)]')
    plt.xlabel('')
    plt.legend(( b3, b2, b1),( 'fan','cooling', 'heating'), loc='best')
    # plt.show()
    save_plot(fig, 'monthly energy')

def plot_power(base, g36, start_time, end_time, variable, ylabel):
    base_dur = get_plot_data(base, start_time, end_time)
    g36_dur = get_plot_data(g36, start_time, end_time)
    Pbase = base_dur[variable]/1000
    Pg36 = g36_dur[variable]/1000

    fig, ax = plt.subplots()
    ax.plot(base_dur.index, Pbase, color='blue', label='Baseline')
    ax.plot(g36_dur.index, Pg36, color='green', label='G36')
    ax.grid(linestyle='--')
    plt.ylabel(ylabel + ' (kW)')
    plt.xlabel('Date')
    if variable == 'hvac.PCoo':
        ax.set_ylim(0, 2.6)
    myFmt = mdates.DateFormatter('%m-%d')
    ax.xaxis.set_major_formatter(myFmt)
    ax.legend()
    save_plot(plt, ylabel+'-'+start_time);


def plot_temperature(base, g36, start_time, end_time, variable, ylabel):
    base_dur = get_plot_data(base, start_time, end_time)
    g36_dur = get_plot_data(g36, start_time, end_time)
    Tbase = base_dur[variable] - 273.15
    Tg36 = g36_dur[variable] - 273.15
    THeaSet = g36_dur['controller.TZonHeaSet'] - 273.15
    TCooSet = g36_dur['controller.TZonCooSet'] - 273.15
    Tout = g36_dur['weaBus.TDryBul'] -273.15

    fig, ax = plt.subplots()
    ax.plot(base_dur.index, Tbase, color='blue', label='Baseline')
    ax.plot(g36_dur.index, Tg36, color='green', label='G36')
    if variable == 'zon.senTZon.T':
        ax.plot(g36_dur.index, THeaSet, color='grey', label='Heating setpoint')
        ax.plot(g36_dur.index, TCooSet, color='grey', label='Cooling setpoint')
        ax.plot(g36_dur.index, Tout, color='lime', label='Outdoor dry bulb')
    ax.grid(linestyle='--')
    plt.ylabel(ylabel + ' ($^\circ$C)')
    plt.xlabel('Date')
    myFmt = mdates.DateFormatter('%m-%d')
    ax.xaxis.set_major_formatter(myFmt)
    ax.legend()
    save_plot(plt, ylabel+'-'+start_time);

def plot_flow(base, g36, start_time, end_time, variable, ylabel):
    base_dur = get_plot_data(base, start_time, end_time)
    g36_dur = get_plot_data(g36, start_time, end_time)
    m_flow_design = [0.03 for i in range(len(g36_dur.index))]

    fig, ax = plt.subplots()
    ax.plot(base_dur.index, base_dur[variable], color='blue', label='Baseline')
    ax.plot(g36_dur.index, g36_dur[variable], color='green', label='G36')
    if variable == 'hvac.out.ports[3].m_flow':
        ax.plot(g36_dur.index, m_flow_design, color='grey', label='Design outdoor airflow')
    ax.grid(linestyle='--')
    if start_time == '1970-04-06':
        ax.set_ylim(0,0.75)
    else:
        ax.set_ylim(0,0.8)
    plt.ylabel(ylabel + ' (kg/s)')
    plt.xlabel('Date')
    myFmt = mdates.DateFormatter('%m-%d')
    ax.xaxis.set_major_formatter(myFmt)
    ax.legend()
    save_plot(plt, ylabel+'-'+start_time);


def plot_CO2(base, g36, start_time, end_time, variable, ylabel):
    base_dur = get_plot_data(base, start_time, end_time)
    g36_dur = get_plot_data(g36, start_time, end_time)

    fig, ax = plt.subplots()
    ax.plot(base_dur.index, base_dur[variable], color='blue', label='Baseline')
    ax.plot(g36_dur.index, g36_dur[variable], color='green', label='G36')
    ax.grid(linestyle='--')
    plt.ylabel(ylabel + ' (ppm)')
    plt.xlabel('Date')
    myFmt = mdates.DateFormatter('%m-%d')
    ax.xaxis.set_major_formatter(myFmt)
    ax.legend()
    save_plot(plt, ylabel+'-'+start_time);

def plot_solar(g36, start_time, end_time, variable, ylabel):
    #base_dur = get_plot_data(base, start_time, end_time)
    g36_dur = get_plot_data(g36, start_time, end_time)

    fig, ax = plt.subplots()
    #ax.plot(base_dur.index, base_dur[variable], color='blue', label='Baseline')
    ax.plot(g36_dur.index, g36_dur[variable], color='green', label='Global horizontal radiation')
    ax.grid(linestyle='--')
    plt.ylabel(ylabel + ' (W/m2)')
    plt.xlabel('Date')
    myFmt = mdates.DateFormatter('%m-%d')
    ax.xaxis.set_major_formatter(myFmt)
    ax.legend()
    save_plot(plt, ylabel+'-'+start_time);

def calculate_winter_energy(base,g36):
    base = pd.DataFrame.from_dict(base)
    base.index = pd.to_datetime(base['time'], unit='s')
    base_jan_feb = base['res.EHea'].loc['1970-02-28 23:00:04.000'].to_numpy()
    base_to_nov = base['res.EHea'].loc['1970-11-30 23:00:24'].to_numpy()
    base_dec = base['res.EHea'][-1] - base_to_nov
    base_winter = base_jan_feb + base_dec

    g36 = pd.DataFrame.from_dict(g36)
    g36.index = pd.to_datetime(g36['time'], unit='s')
    g36_jan_feb = g36['res.EHea'].loc['1970-02-28 23:11:11.500'].to_numpy()
    g36_to_nov = g36['res.EHea'].loc['1970-11-30 23:17:26'].to_numpy()
    g36_dec = g36['res.EHea'][-1] - g36_to_nov
    g36_winter = g36_jan_feb + g36_dec

    print(g36_winter)
    ratio = (g36_winter - base_winter)/g36_winter
    print(ratio)

    return ratio

# Add variable names from Modelica Models to the list below for plotting
# Note that some variable names are not the same in different control cases
list_base = ['res.EHea', "res.ECooSen", "res.ECooLat", "res.EFan"]
#['zon.senTZon.T', 'hvac.senTSup.T', 'hvac.returnAir.m_flow', 'weaBus.TDryBul',
#        'hvac.out.ports[3].m_flow', 'hvac.QHea_flow', 'hvac.PCoo', 'hvac.PFan', 'hvac.PPum', 'hvac.uHea', 'hvac.senTraSub.C']
list_mid = list_base
list_g36 = list_base
# ['controller.TZonHeaSet', 'controller.TZonCooSet', 'weaBus.HGloHor']
# results with events
# base = get_partial_results('ChillerDXHeatingEconomizer', list_base)
# g36 = get_partial_results('Guideline36', list_g36)
# results without events
base = get_partial_results('simulations/BICBase-sac/BICBase', list_base)
mid = get_partial_results('simulations/BICMid-sac/BICMid', list_mid)
g36 = get_partial_results('simulations/Guideline36-sac/Guideline36', list_g36)

plt.rcParams['figure.figsize'] = (15, 4)
plt.rcParams['font.family'] = 'sans-serif'

# plot_energy(base, mid, g36);
#
# winter_start = '1970-12-24'
# winter_end = '1970-12-30'
# summer_start = '1970-07-28'
# summer_end = '1970-08-03'
# dec_start = '1970-12-24'
# dec_end = '1970-12-30'

# plot_temperature(base, g36, winter_start, winter_end, 'zon.senTZon.T', 'Zone temperature')
# plot_temperature(base, g36, summer_start, summer_end,  'zon.senTZon.T', 'Zone temperature')
# plot_temperature(base, g36, winter_start, winter_end,  'hvac.senTSup.T', 'Supply air temperature')
# plot_temperature(base, g36, summer_start, summer_end,  'hvac.senTSup.T', 'Supply air temperature')
#
# plot_flow(base, g36, winter_start, winter_end,  'hvac.returnAir.m_flow', 'Supply air flow')
# plot_flow(base, g36, summer_start, summer_end,  'hvac.returnAir.m_flow', 'Supply air flow')
# plot_flow(base, g36, '1970-04-06', '1970-04-12',  'hvac.returnAir.m_flow', 'Supply air flow')
# plot_flow(base, g36, winter_start, winter_end,  'hvac.out.ports[3].m_flow', 'Outdoor air flow')
# plot_flow(base, g36, summer_start, summer_end,  'hvac.out.ports[3].m_flow', 'Outdoor air flow')
#
# plot_power(base, g36, winter_start, winter_end,  'hvac.QHea_flow', 'Heating power')
# plot_power(base, g36, summer_start, summer_end,  'hvac.QHea_flow', 'Heating power')
# plot_power(base, g36, winter_start, winter_end,  'hvac.PCoo', 'Cooling power')
# plot_power(base, g36, summer_start, summer_end,  'hvac.PCoo', 'Cooling power')
# plot_power(base, g36, '1970-04-06', '1970-04-12',  'hvac.PCoo', 'Cooling power')
# plot_power(base, g36, winter_start, winter_end,  'hvac.PFan', 'Fan power')
# plot_power(base, g36, summer_start, summer_end,  'hvac.PFan', 'Fan power')
#
# plot_CO2(base,g36,winter_start, winter_end,  'hvac.senTraSub.C', 'CO2 concentration')
# plot_CO2(base,g36,summer_start, summer_end,  'hvac.senTraSub.C', 'CO2 concentration')
#
# plot_solar(g36, winter_start, winter_end,  'weaBus.HGloHor', 'Solar radiation')

# plot_energy_month(base, g36)

# calculate_winter_energy(base,g36)
