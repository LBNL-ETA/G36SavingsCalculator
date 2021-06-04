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

use_result_file = True
outputs = ['res.PCooSen', 'res.PCooLat', 'res.PFan', 'res.PHea', 'conAHU.VEffOutAir_flow']
climate = 'SA'
dirpath = "/mnt/hgfs/VMShare18/202010/{0}".format(climate)
print('Loading results...')
if use_result_file:
    # use result file path directly
    result_file = os.path.join(dirpath, 'Guideline36.mat')
    r = Reader(result_file, 'dymola')
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
    csv_file_path = os.path.join(dirpath, 'Guideline36_small.txt')
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
