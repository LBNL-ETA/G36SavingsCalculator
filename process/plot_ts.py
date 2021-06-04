#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Mon Dec 14 18:21:32 2020

@author: dhbubu18
"""

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import numpy as np
import os

plt.rcParams['savefig.dpi'] = 300
plt.rcParams['font.size'] = 16

climate = 'LA'
file1 = '{0}/BICBase.txt'.format(climate)
#file2 = 'BICBase_{0}_hLoad_lHours/BICBase_ts.csv'.format(climate)

file3 = '{0}/BICMid.txt'.format(climate)
#file4 = 'BICMid_{0}_hLoad_lHours/BICMid_ts.csv'.format(climate)

file5 = '{0}/Guideline36.txt'.format(climate)
file6 = '{0}/Guideline36_small.txt'.format(climate)

#def load_results(result_file1, result_file2, resample=False):
def load_results(result_file1, result_file2=None, resample=False):
    result_folder = '/mnt/hgfs/VMShare18/202010'
    result_path1 = os.path.join(result_folder,result_file1)
    df_ts = pd.read_csv(result_path1, index_col='Time')
    df_ts.index = pd.to_datetime(df_ts.index,unit='s')
    df_ts = df_ts[~df_ts.index.duplicated(keep='first')]
    if result_file2:
        result_path2 = os.path.join(result_folder,result_file2)
        df_2 = pd.read_csv(result_path2, index_col='Time')
        df_2.index = pd.to_datetime(df_2.index,unit='s')
        df_2 = df_2[~df_2.index.duplicated(keep='first')]
        print(df_ts)
        print(df_2)
        df = pd.concat([df_ts,df_2],axis=1)
    else:
        df = df_ts
    if resample:
        df = df.drop_duplicates()
        df = df.resample('10Min').mean()
    
    return df

def cal_mean_temp(df):
    TZon_col = df.loc[:,'Building.zoneVAV1.zon.TAir':'Building.zoneVAV21.zon.TAir']
    df['TZonMea'] = TZon_col.mean(axis=1)-273.15
    
    return df

def cal_heat_power(df):
    df['PHea'] = (df['res.PHeaReh'])/1000
    
    return df

def cal_cool_power(df):
    df['PCoo'] = -(df['res.PCooSen']+df['res.PCooLat'])/1000
    
    return df
#
#df_base = load_results(file1)
#df_base = cal_mean_temp(df_base)
#df_base = cal_cool_power(df_base)
#df_base = cal_heat_power(df_base)
#
#df_mid = load_results(file3)
#df_mid = cal_mean_temp(df_mid)
#df_mid = cal_cool_power(df_mid)
#df_mid = cal_heat_power(df_mid)

df_g36 = load_results(file5, file6)
df_g36 = cal_mean_temp(df_g36)
df_g36 = cal_cool_power(df_g36)