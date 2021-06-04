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

file_path = 'occupancySimulator_high.csv'
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
# Add energy use density based on ASHRAE2004 standard
lights['ACTIVESTORAGE_MID_1 ZN']  = np.where(occupied, 1, 0.05)*conv_fac*0.8
lights['ACTIVESTORAGE_MID_2 ZN']  = lights['ACTIVESTORAGE_MID_1 ZN']
lights['ACTIVESTORAGE_MID_3 ZN']  = lights['ACTIVESTORAGE_MID_1 ZN']
lights['ACTIVESTORAGE_MID_4 ZN']  = lights['ACTIVESTORAGE_MID_1 ZN']
lights['MECHANICAL_MID ZN']       = np.where(occupied, 1, 0.05)*conv_fac*1.5
lights['RESTROOM_MID ZN']         = np.where(occupied, 1, 0.05)*conv_fac*0.9
lights['STAIR_MID_1 ZN']          = np.where(occupied, 1, 0.05)*conv_fac*0.6
lights['STAIR_MID_2 ZN']          = lights['STAIR_MID_1 ZN']
lights['ENCLOSEDOFFICE_MID_1 ZN'] = lights['ENCLOSEDOFFICE_MID_1 ZN']*conv_fac*1.1
lights['ENCLOSEDOFFICE_MID_2 ZN'] = lights['ENCLOSEDOFFICE_MID_2 ZN']*conv_fac*1.1
lights['ENCLOSEDOFFICE_MID_3 ZN'] = lights['ENCLOSEDOFFICE_MID_3 ZN']*conv_fac*1.1
lights['CONFROOM_MID_1 ZN']       = lights['CONFROOM_MID_1 ZN']*conv_fac*1.3
lights['CONFROOM_MID_2 ZN']       = lights['CONFROOM_MID_2 ZN']*conv_fac*1.3
lights['LOBBY_MID ZN']            = lights['LOBBY_MID ZN']*conv_fac*1.3
lights['CORRIDOR_MID_1 ZN']       = lights['CORRIDOR_MID_1 ZN']*conv_fac*0.5
lights['CORRIDOR_MID_2 ZN']       = lights['CORRIDOR_MID_2 ZN']*conv_fac*0.5
lights['OPENOFFICE_MID_1 ZN']     = lights['OPENOFFICE_MID_1 ZN']*conv_fac*1.1
lights['OPENOFFICE_MID_2 ZN']     = lights['OPENOFFICE_MID_2 ZN']*conv_fac*1.1
lights['OPENOFFICE_MID_3 ZN']     = lights['OPENOFFICE_MID_3 ZN']*conv_fac*1.1
lights['OPENOFFICE_MID_4 ZN']     = lights['OPENOFFICE_MID_4 ZN']*conv_fac*1.1
lights['DINING_MID ZN']           = lights['DINING_MID ZN']*conv_fac*0.9

# equipment
equipment['ACTIVESTORAGE_MID_1 ZN']  = 0
equipment['ACTIVESTORAGE_MID_2 ZN']  = equipment['ACTIVESTORAGE_MID_1 ZN']
equipment['ACTIVESTORAGE_MID_3 ZN']  = equipment['ACTIVESTORAGE_MID_1 ZN']
equipment['ACTIVESTORAGE_MID_4 ZN']  = equipment['ACTIVESTORAGE_MID_1 ZN']
equipment['MECHANICAL_MID ZN']       = np.where(occupied, 1, 0.2)*conv_fac*0.27
equipment['RESTROOM_MID ZN']         = np.where(occupied, 1, 0.2)*conv_fac*0.27
equipment['STAIR_MID_1 ZN']          = 0
equipment['STAIR_MID_2 ZN']          = equipment['STAIR_MID_1 ZN']
equipment['ENCLOSEDOFFICE_MID_1 ZN'] = equipment['ENCLOSEDOFFICE_MID_1 ZN']*conv_fac*0.87
equipment['ENCLOSEDOFFICE_MID_2 ZN'] = equipment['ENCLOSEDOFFICE_MID_2 ZN']*conv_fac*0.87
equipment['ENCLOSEDOFFICE_MID_3 ZN'] = equipment['ENCLOSEDOFFICE_MID_3 ZN']*conv_fac*0.87
equipment['CONFROOM_MID_1 ZN']       = equipment['CONFROOM_MID_1 ZN']*conv_fac*1.0
equipment['CONFROOM_MID_2 ZN']       = equipment['CONFROOM_MID_2 ZN']*conv_fac*1.0
equipment['LOBBY_MID ZN']            = equipment['LOBBY_MID ZN']*conv_fac*0.27
equipment['CORRIDOR_MID_1 ZN']       = equipment['CORRIDOR_MID_1 ZN']*conv_fac*0.29
equipment['CORRIDOR_MID_2 ZN']       = equipment['CORRIDOR_MID_2 ZN']*conv_fac*0.29
equipment['OPENOFFICE_MID_1 ZN']     = equipment['OPENOFFICE_MID_1 ZN']*conv_fac*0.96
equipment['OPENOFFICE_MID_2 ZN']     = equipment['OPENOFFICE_MID_2 ZN']*conv_fac*0.96
equipment['OPENOFFICE_MID_3 ZN']     = equipment['OPENOFFICE_MID_3 ZN']*conv_fac*0.96
equipment['OPENOFFICE_MID_4 ZN']     = equipment['OPENOFFICE_MID_4 ZN']*conv_fac*0.96
equipment['DINING_MID ZN']           = equipment['DINING_MID ZN']*conv_fac*1.0

# add number of people to each zone and convert to W/m2
peo_watt = 120 # W
occ['ENCLOSEDOFFICE_MID_1 ZN'] = occ['ENCLOSEDOFFICE_MID_1 ZN']*peo_watt*11/125.8
occ['ENCLOSEDOFFICE_MID_2 ZN'] = occ['ENCLOSEDOFFICE_MID_2 ZN']*peo_watt*12/125.8
occ['ENCLOSEDOFFICE_MID_3 ZN'] = occ['ENCLOSEDOFFICE_MID_3 ZN']*peo_watt*7/42.13
occ['CONFROOM_MID_1 ZN']       = occ['CONFROOM_MID_1 ZN']*peo_watt*8/43.11
occ['CONFROOM_MID_2 ZN']       = occ['CONFROOM_MID_2 ZN']*peo_watt*8/43.11
occ['LOBBY_MID ZN']            = occ['LOBBY_MID ZN']*peo_watt*5/61.43
occ['CORRIDOR_MID_1 ZN']       = occ['CORRIDOR_MID_1 ZN']*peo_watt*6/74.44
occ['CORRIDOR_MID_2 ZN']       = occ['CORRIDOR_MID_2 ZN']*peo_watt*6/74.44
occ['OPENOFFICE_MID_1 ZN']     = occ['OPENOFFICE_MID_1 ZN']*peo_watt*13/176.31
occ['OPENOFFICE_MID_2 ZN']     = occ['OPENOFFICE_MID_2 ZN']*peo_watt*14/180.41
occ['OPENOFFICE_MID_3 ZN']     = occ['OPENOFFICE_MID_3 ZN']*peo_watt*14/194.1
occ['OPENOFFICE_MID_4 ZN']     = occ['OPENOFFICE_MID_4 ZN']*peo_watt*14/211.92
occ['DINING_MID ZN']           = occ['DINING_MID ZN']*peo_watt*6/22.94

def write_to_modelica(data, data_type, file_name):

    # drop the two columns not needed by modelica
    data = data.drop(['Step','Time'],axis=1)
    # get the dimension of the matrix
    size = data.shape
    # write to csv for modelica
    file = file_name + '.dat'
    with open(file,'w') as f:
        line1 = '#1'
        line2 = data_type + ' ' + file_name + '(' + str(size[0]) + '\t' + str(size[1]+1) + ')'
        f.write('{}\n{}\n'.format(line1,line2))
        data.to_csv(f, header=False)

# occ.to_csv('occupancy.csv')
# lights.to_csv('lights.csv')
# equipment.to_csv('equipment.csv')
write_to_modelica(occ, data_type, 'people')
write_to_modelica(lights, data_type, 'lights')
write_to_modelica(equipment, data_type, 'equipment')
