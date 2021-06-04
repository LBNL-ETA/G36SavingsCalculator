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

# Add variable names from Modelica Models to the list below for plotting
# Note that some variable names are not the same in different control cases
list_base = ['res.PHeaAhu', 'res.PHeaReh', 'res.PCooSen', 'res.PCooLat', 'res.PFan',
             'AHU.returnAir.m_flow','AHU.TSup.T','AHU.VOut1.V_flow','weather.weaBus.TDryBul','weather.weaBus.HGloHor',
             'Building.zoneVAV1.VSupRoo_flow.V_flow','Building.zoneVAV2.VSupRoo_flow.V_flow','Building.zoneVAV3.VSupRoo_flow.V_flow',
             'Building.zoneVAV4.VSupRoo_flow.V_flow','Building.zoneVAV5.VSupRoo_flow.V_flow','Building.zoneVAV6.VSupRoo_flow.V_flow',
             'Building.zoneVAV7.VSupRoo_flow.V_flow','Building.zoneVAV8.VSupRoo_flow.V_flow','Building.zoneVAV9.VSupRoo_flow.V_flow',
             'Building.zoneVAV10.VSupRoo_flow.V_flow','Building.zoneVAV11.VSupRoo_flow.V_flow','Building.zoneVAV12.VSupRoo_flow.V_flow',
             'Building.zoneVAV13.VSupRoo_flow.V_flow','Building.zoneVAV14.VSupRoo_flow.V_flow','Building.zoneVAV15.VSupRoo_flow.V_flow',
             'Building.zoneVAV16.VSupRoo_flow.V_flow','Building.zoneVAV17.VSupRoo_flow.V_flow','Building.zoneVAV18.VSupRoo_flow.V_flow',
             'Building.zoneVAV19.VSupRoo_flow.V_flow','Building.zoneVAV20.VSupRoo_flow.V_flow','Building.zoneVAV21.VSupRoo_flow.V_flow',
             'Building.zoneVAV1.TSupRoo.T','Building.zoneVAV2.TSupRoo.T','Building.zoneVAV3.TSupRoo.T',
             'Building.zoneVAV4.TSupRoo.T','Building.zoneVAV5.TSupRoo.T','Building.zoneVAV6.TSupRoo.T',
             'Building.zoneVAV7.TSupRoo.T','Building.zoneVAV8.TSupRoo.T','Building.zoneVAV9.TSupRoo.T',
             'Building.zoneVAV10.TSupRoo.T','Building.zoneVAV11.TSupRoo.T','Building.zoneVAV12.TSupRoo.T',
             'Building.zoneVAV13.TSupRoo.T','Building.zoneVAV14.TSupRoo.T','Building.zoneVAV15.TSupRoo.T',
             'Building.zoneVAV16.TSupRoo.T','Building.zoneVAV17.TSupRoo.T','Building.zoneVAV18.TSupRoo.T',
             'Building.zoneVAV19.TSupRoo.T','Building.zoneVAV20.TSupRoo.T','Building.zoneVAV21.TSupRoo.T']
list_mid = list_base
list_g36 = list_base
# ['controller.TZonHeaSet', 'controller.TZonCooSet', 'weaBus.HGloHor']

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

# plot_solar(g36, winter_start, winter_end,  'weaBus.HGloHor', 'Solar radiation')
