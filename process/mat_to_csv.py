# -*- coding: utf-8 -*-
"""
This script can be used to convert a .mat simulation result file into a
.csv file with a subset of model variables, as defined in the "outputs" list.

The .csv file is saved in the same directory as the .mat file, and is based
on the case, climate, and scenario.

"""

from buildingspy.io.outputfile import Reader
import os
import pandas as pd
import glob

use_result_file = False
outputs = ['res.PHeaAhu', 'res.PHeaReh', 'res.PCooSen', 'res.PCooLat', 'res.PFan',
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
             'Building.zoneVAV19.TSupRoo.T','Building.zoneVAV20.TSupRoo.T','Building.zoneVAV21.TSupRoo.T',
             'res.EHea', "res.ECooSen", "res.ECooLat", "res.EFan",
             'res.DiscomfortHeating', 'res.DiscomfortCooling',
             'Building.zoneVAV1.zon.TAir','Building.zoneVAV2.zon.TAir','Building.zoneVAV3.zon.TAir',
             'Building.zoneVAV4.zon.TAir','Building.zoneVAV5.zon.TAir','Building.zoneVAV6.zon.TAir',
             'Building.zoneVAV7.zon.TAir','Building.zoneVAV8.zon.TAir','Building.zoneVAV9.zon.TAir',
             'Building.zoneVAV10.zon.TAir','Building.zoneVAV11.zon.TAir','Building.zoneVAV12.zon.TAir',
             'Building.zoneVAV13.zon.TAir','Building.zoneVAV14.zon.TAir','Building.zoneVAV15.zon.TAir',
             'Building.zoneVAV16.zon.TAir','Building.zoneVAV17.zon.TAir','Building.zoneVAV18.zon.TAir',
             'Building.zoneVAV19.zon.TAir','Building.zoneVAV20.zon.TAir','Building.zoneVAV21.zon.TAir',
             'Building.TRooHeaSet','Building.TRooCooSet']

print('Loading results...')
if use_result_file:
    # use result file path directly
    result_file = "Base_LA_hLoad_lHours/BICBase.mat"
    path = os.path.abspath(os.path.join(__file__,"..","..","simulations",result_file))
    r = Reader(path, 'dymola')
    print('Done loading results.')
    # Parse results into dataframe
    print('Parsing and saving results...')

    df = pd.DataFrame()
    for variable in outputs:
        try:
            (time, values) = r.values(variable)
        except KeyError:
            print('Warning: {0} not in data'.format(variable))
            continue
        df_var = pd.DataFrame(index=time,data=values,columns=[variable])
        df = pd.concat((df, df_var), axis=1)
    df.index.name = 'Time'
    #        # Resample if want
    #        df.index = pd.to_timedelta(df.index.values, unit='s')
    #        df = df.resample('15T').mean()
    #        df.index.name = 'Time'
    # Save to csv
    csv_file_path = path[:-4]+'_TSet.csv'
    df.to_csv(csv_file_path)
    print('Done parsing and saving results.')
    print('Results saved to {0}'.format(csv_file_path))
else:
    # parse each result file in all the folders
    simulations = "/mnt/hgfs/E/simulations"
    # simulations = os.path.abspath(os.path.join(__file__,"..","..","simulations"))
    result_folders = [x[0] for x in os.walk(simulations)]
    for folder in result_folders:
        # glob returns a list of path
        result_file_path = glob.glob(os.path.join(folder,'*.mat'))
        for path in result_file_path:
            r = Reader(path, 'dymola')
            print('Done loading results.')
            # Parse results into dataframe
            print('Parsing and saving results...')

            df = pd.DataFrame()
            for variable in outputs:
                try:
                    (time, values) = r.values(variable)
                except KeyError:
                    print('Warning: {0} not in data'.format(variable))
                    continue
                df_var = pd.DataFrame(index=time,data=values,columns=[variable])
                df = pd.concat((df, df_var), axis=1)
            df.index.name = 'Time'
            #        # Resample if want
            #        df.index = pd.to_timedelta(df.index.values, unit='s')
            #        df = df.resample('15T').mean()
            #        df.index.name = 'Time'
            # Save to csv
            csv_file_path = path[:-4]+'.txt'
            df.to_csv(csv_file_path)
            print('Done parsing and saving results.')
            print('Results saved to {0}'.format(csv_file_path))
