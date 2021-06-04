#!/usr/bin/env python
# coding: utf-8

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# def to_modelica_occ(file_path, timestep, occ_type, file_name):
'''
Parameters:
file_path: the file path of the existing occ
time_step: the time step of the occ
occ_type: specify the occ type such as float, double etc.
file_name: the file name of the modelica occ
'''

'''
# Columns mapping from occupancySimulator to EnergyPlus zone names
CONFROOM_MID_1 ZN	S3_Meeting_room
CONFROOM_MID_2 ZN	S4_Meeting_room
CORRIDOR_MID_1 ZN	S6_Corridor
CORRIDOR_MID_2 ZN	S7_Corridor
DINING_MID ZN	S13_Dining
ENCLOSEDOFFICE_MID_1 ZN	S1_Office_126
ENCLOSEDOFFICE_MID_2 ZN	S2_Office_126
ENCLOSEDOFFICE_MID_3 ZN	S12_Office_43
LOBBY_MID ZN	S5_Lobby
OPENOFFICE_MID_1 ZN	S8_Office_180
OPENOFFICE_MID_2 ZN	S9_Office_180
OPENOFFICE_MID_3 ZN	S10_Office_200
OPENOFFICE_MID_4 ZN	S11_Office_200

# unoccupied zones
'ACTIVESTORAGE_MID_1 ZN',
'ACTIVESTORAGE_MID_2 ZN',
'ACTIVESTORAGE_MID_3 ZN',
'ACTIVESTORAGE_MID_4 ZN',
'MECHANICAL_MID ZN',
'RESTROOM_MID ZN',
'STAIR_MID_1 ZN',
'STAIR_MID_2 ZN'
'''

file_path = 'occupancySimulator_low.csv'
timestep = 600
data_type = 'float'
# read the existing occ
occ = pd.read_csv(file_path, skiprows=6)
occ = occ.drop(occ.columns[15:],axis=1)
# add the first row as step 0
occ.loc[-1] = occ.loc[0]
occ.index = occ.index+1
occ.sort_index(inplace=True)
# convert string to datetime
occ['Time'] = '2020 ' + occ['Time']
occ['Time'] = pd.to_datetime(occ['Time'])
# occ['Time'].loc[0] = occ['Time'].loc[1] - pd.Timedelta(minutes=10)
# create a new index for modelica
occ.index = occ.index*timestep

# add EnergyPlus zone names to the exisiting columns
header = ['Step', 'Time',
          'ENCLOSEDOFFICE_MID_1 ZN','ENCLOSEDOFFICE_MID_2 ZN',
          'CONFROOM_MID_1 ZN', 'CONFROOM_MID_2 ZN',
          'LOBBY_MID ZN', 'CORRIDOR_MID_1 ZN',
          'CORRIDOR_MID_2 ZN', 'OPENOFFICE_MID_1 ZN',
          'OPENOFFICE_MID_2 ZN', 'OPENOFFICE_MID_3 ZN',
          'OPENOFFICE_MID_4 ZN', 'ENCLOSEDOFFICE_MID_3 ZN', 'DINING_MID ZN']
occ.columns = header

# add the other 8 zones
occ['ACTIVESTORAGE_MID_1 ZN'] = 0
occ['ACTIVESTORAGE_MID_2 ZN'] = 0
occ['ACTIVESTORAGE_MID_3 ZN'] = 0
occ['ACTIVESTORAGE_MID_4 ZN'] = 0
occ['MECHANICAL_MID ZN'] = 0
occ['RESTROOM_MID ZN'] = 0
occ['STAIR_MID_1 ZN'] = 0
occ['STAIR_MID_2 ZN'] = 0
occ = occ.reindex(sorted(occ.columns), axis=1)
#occ['ENCLOSEDOFFICE_MID_1 ZN'].plot()

# Create lights and equipment schedules based on occupancySimulator schedules
lights = pd.DataFrame(index=occ.index, columns=occ.columns)
equipment = pd.DataFrame(index=occ.index, columns=occ.columns)
# The schedules are only for zones with people
for key in occ.columns[:-3]:
    # if key == 'Time' or 'Step':
    #     lights[key] = occ[key]
    #     equipment[key] = occ[key]
    # else:
    # lights are 5% on during unoccupied hours
    lights[key] = np.where(occ[key]>0, 1, 0.05)
    # equipment are 10% on during unoccupied hours
    equipment[key] = np.where(occ[key]>0, occ[key], 0.1)

# 1W/ft2 = 10.76 W/m2
conv_fac = 10.76
# daily schedule 8:00 ~ 19:00 for zones without people
occupied = np.logical_and(occ['Time'].dt.hour>=8, occ['Time'].dt.hour<=19)
# Zone area
a1 = 36.19
a2 = 32.22
a3 = a2
a4 = 13.24
a5 = 43.11
a6 = a5
a7 = 74.44
a8 = a7
a9 = 22.94
a10 = 125.8
a11 = a10
a12 = 42.13
a13 = 61.43
a14 = 49.81
a15 = 176.31
a16 = 180.41
a17 = 194.1
a18 = 211.92
a19 = 59.71
a20 = 30.71
a21 = a20
# Add energy use density based on ASHRAE2004 standard
lights['ACTIVESTORAGE_MID_1 ZN']  = np.where(occupied, 1, 0.05)*conv_fac*0.8*a1
lights['ACTIVESTORAGE_MID_2 ZN']  = np.where(occupied, 1, 0.05)*conv_fac*0.8*a2
lights['ACTIVESTORAGE_MID_3 ZN']  = np.where(occupied, 1, 0.05)*conv_fac*0.8*a3
lights['ACTIVESTORAGE_MID_4 ZN']  = np.where(occupied, 1, 0.05)*conv_fac*0.8*a4
lights['CONFROOM_MID_1 ZN']       = lights['CONFROOM_MID_1 ZN']*conv_fac*1.3*a5
lights['CONFROOM_MID_2 ZN']       = lights['CONFROOM_MID_2 ZN']*conv_fac*1.3*a6
lights['CORRIDOR_MID_1 ZN']       = lights['CORRIDOR_MID_1 ZN']*conv_fac*0.5*a7
lights['CORRIDOR_MID_2 ZN']       = lights['CORRIDOR_MID_2 ZN']*conv_fac*0.5*a8
lights['DINING_MID ZN']           = lights['DINING_MID ZN']*conv_fac*0.9*a9
lights['ENCLOSEDOFFICE_MID_1 ZN'] = lights['ENCLOSEDOFFICE_MID_1 ZN']*conv_fac*1.1*a10
lights['ENCLOSEDOFFICE_MID_2 ZN'] = lights['ENCLOSEDOFFICE_MID_2 ZN']*conv_fac*1.1*a11
lights['ENCLOSEDOFFICE_MID_3 ZN'] = lights['ENCLOSEDOFFICE_MID_3 ZN']*conv_fac*1.1*a12
lights['LOBBY_MID ZN']            = lights['LOBBY_MID ZN']*conv_fac*1.3*a13
lights['MECHANICAL_MID ZN']       = np.where(occupied, 1, 0.05)*conv_fac*1.5*a14
lights['OPENOFFICE_MID_1 ZN']     = lights['OPENOFFICE_MID_1 ZN']*conv_fac*1.1*a15
lights['OPENOFFICE_MID_2 ZN']     = lights['OPENOFFICE_MID_2 ZN']*conv_fac*1.1*a16
lights['OPENOFFICE_MID_3 ZN']     = lights['OPENOFFICE_MID_3 ZN']*conv_fac*1.1*a17
lights['OPENOFFICE_MID_4 ZN']     = lights['OPENOFFICE_MID_4 ZN']*conv_fac*1.1*a18
lights['RESTROOM_MID ZN']         = np.where(occupied, 1, 0.05)*conv_fac*0.9*a19
lights['STAIR_MID_1 ZN']          = np.where(occupied, 1, 0.05)*conv_fac*0.6*a20
lights['STAIR_MID_2 ZN']          = np.where(occupied, 1, 0.05)*conv_fac*0.6*a21

# equipment
equipment['ACTIVESTORAGE_MID_1 ZN']  = 0*a1
equipment['ACTIVESTORAGE_MID_2 ZN']  = 0*a2
equipment['ACTIVESTORAGE_MID_3 ZN']  = 0*a3
equipment['ACTIVESTORAGE_MID_4 ZN']  = 0*a4
equipment['CONFROOM_MID_1 ZN']       = equipment['CONFROOM_MID_1 ZN']*conv_fac*1.0*a5
equipment['CONFROOM_MID_2 ZN']       = equipment['CONFROOM_MID_2 ZN']*conv_fac*1.0*a6
equipment['CORRIDOR_MID_1 ZN']       = equipment['CORRIDOR_MID_1 ZN']*conv_fac*0.29*a7
equipment['CORRIDOR_MID_2 ZN']       = equipment['CORRIDOR_MID_2 ZN']*conv_fac*0.29*a8
equipment['DINING_MID ZN']           = equipment['DINING_MID ZN']*conv_fac*1.0*a9
equipment['ENCLOSEDOFFICE_MID_1 ZN'] = equipment['ENCLOSEDOFFICE_MID_1 ZN']*conv_fac*0.87*a10
equipment['ENCLOSEDOFFICE_MID_2 ZN'] = equipment['ENCLOSEDOFFICE_MID_2 ZN']*conv_fac*0.87*a11
equipment['ENCLOSEDOFFICE_MID_3 ZN'] = equipment['ENCLOSEDOFFICE_MID_3 ZN']*conv_fac*0.87*a12
equipment['LOBBY_MID ZN']            = equipment['LOBBY_MID ZN']*conv_fac*0.27*a13
equipment['MECHANICAL_MID ZN']       = np.where(occupied, 1, 0.2)*conv_fac*0.27*a14
equipment['OPENOFFICE_MID_1 ZN']     = equipment['OPENOFFICE_MID_1 ZN']*conv_fac*0.96*a15
equipment['OPENOFFICE_MID_2 ZN']     = equipment['OPENOFFICE_MID_2 ZN']*conv_fac*0.96*a16
equipment['OPENOFFICE_MID_3 ZN']     = equipment['OPENOFFICE_MID_3 ZN']*conv_fac*0.96*a17
equipment['OPENOFFICE_MID_4 ZN']     = equipment['OPENOFFICE_MID_4 ZN']*conv_fac*0.96*a18
equipment['RESTROOM_MID ZN']         = np.where(occupied, 1, 0.2)*conv_fac*0.27*a19
equipment['STAIR_MID_1 ZN']          = 0*a20
equipment['STAIR_MID_2 ZN']          = 0*a21

print(lights.sum(axis=0))
print(equipment.sum(axis=0))
# occ.to_csv('occupancy.csv')
# lights.to_csv('lights.csv')
# equipment.to_csv('equipment.csv')
print(lights.sum(axis=0).sum())
print(equipment.sum(axis=0).sum())
unit_conv = 1000*6 #kWh = 1000*6 (W*10min)
int_load_total = (lights.sum(axis=0).sum()+equipment.sum(axis=0).sum())/(1660.75*unit_conv)
print(int_load_total)
