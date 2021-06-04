import pandas as pd
import os

def get_zone_flow(file):
    '''
    Read zone nominal flow from EnergyPlus sizing output.
    '''
    zone_sz = pd.read_csv(file,index_col='Time')
    mid_floor = []
    for column in zone_sz.columns.values:
        if 'MID' in column and 'Des Cool Mass Flow' in column:
            mid_floor.append(column)
    v_flow_zone = list(zone_sz.loc['Peak Vol Flow (m3/s)',mid_floor].array)
    m_flow_zone = [round(1.2*i,3) for i in v_flow_zone]

    return m_flow_zone

sf_size_file = os.path.abspath(os.path.join(__file__,'..',
            'MediumOfficeDetailed_2004_3C_sf_Zsz.csv'))
m_flow_zone_sf = get_zone_flow(sf_size_file)
print("SF zone flow rates are:")
print(m_flow_zone_sf)

sac_size_file = os.path.abspath(os.path.join(__file__,'..',
            'MediumOfficeDetailed_2004_3B_sacramento_Zsz.csv'))
m_flow_zone_sac = get_zone_flow(sac_size_file)
print("Sacramento zone flow rates are:")
print(m_flow_zone_sac)
