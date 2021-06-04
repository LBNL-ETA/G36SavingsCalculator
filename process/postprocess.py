#!/usr/bin/env python
# coding: utf-8

# # Post-processing of case studies
#
# ## Usage notes
#
# All figures will be written to the directory `img` as pdf and png files.

# ## Import required libraries
import os
import cases

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

from buildingspy.io.outputfile import Reader
from buildingspy.io.postprocess import Plotter

plt.rcParams['axes.facecolor']='whitesmoke'
plt.rcParams['font.size'] = 6
plt.rcParams['text.usetex'] = False
plt.rcParams['legend.facecolor'] = 'white'
plt.rcParams['legend.framealpha'] = 0.75
plt.rcParams['legend.edgecolor'] = 'none'
plt.rcParams['savefig.dpi'] = 300

def save_plot(figure, file_name):
    """ Save the figure to a pdf and png file in the directory `img`
    """
    import os
    import matplotlib.pyplot as plt

    out_dir = "img"
    if not os.path.exists(out_dir):
        os.makedirs(out_dir)
    figure.savefig(os.path.join(out_dir, '{}.pdf'.format(file_name)))
    figure.savefig(os.path.join(out_dir, '{}.png'.format(file_name)))
    plt.clf()


def configure_axes(axes):
    """ Configure the axis style
    """
    axes.spines['right'].set_visible(False)
    axes.spines['top'].set_visible(False)
    axes.spines['left'].set_visible(False)
    axes.spines['bottom'].set_visible(False)
    axes.grid(color='lightgrey', linewidth=0.25)
    return

def get_results(case_name):
    """ Get the results for the case with name `case_name`
    """
    # Make sure simulation was successful
    dslog_name = os.path.join("simulations", case_name, "dslog.txt")
    with open(dslog_name) as dslog:
        if not "Integration terminated successfully" in dslog.read():
            raise Exception("Simulation failed. Check {}".format(dslog_name))
    file_name = cases.get_result_file_name(case_name)
    return Reader(file_name, "dymola")

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


# ---------------------------------------------------------------------------
# helper functions and scripts

def set_cases_and_initiate_plot():
    from matplotlib.gridspec import GridSpec
    cases = ['Base\ case', 'Mid\ case', 'Guideline\ 36']
    seasons = ['Winter', 'Spring', 'Summer']
    num_cases = len(cases)
    num_seasons = len(seasons)

    fig = plt.figure(figsize=(6.5,8.))
    gs1 = GridSpec(116, 1)
    gs1.update(left=0.1, right=0.9, hspace=0.05)

    ax = list()
    ax.insert(0, fig.add_subplot(gs1[0:11,:]))
    ax.insert(1, fig.add_subplot(gs1[12:23,:]))
    ax.insert(2, fig.add_subplot(gs1[24:35,:]))
    ax.insert(3, fig.add_subplot(gs1[40:51,:]))
    ax.insert(4, fig.add_subplot(gs1[52:63,:]))
    ax.insert(5, fig.add_subplot(gs1[64:75,:]))
    ax.insert(6, fig.add_subplot(gs1[80:91,:]))
    ax.insert(7, fig.add_subplot(gs1[92:103,:]))
    ax.insert(8, fig.add_subplot(gs1[104:115,:]))

    # fig, ax = plt.subplots(nrows=num_cases*num_seasons, ncols=1, figsize = (6.5,8.))
    # fig, ax = plt.subplots(nrows=20, ncols=1, figsize = (6.5,8.))

    return cases, seasons, num_cases, num_seasons, fig, ax

def set_title(ax, title):
    left, width = .01, .97
    bottom, height = .01, .88
    right = left + width
    top = bottom + height

    title_str = r"$\it{" + title + "}$"
    ax.text(left, top,
            title_str,
            verticalalignment = 'center',
            horizontalalignment = 'left',
            transform=ax.transAxes,
            fontsize = 6, color = 'k',
            bbox=dict(facecolor='white', alpha=0.75, edgecolor='none'))


def set_up_labels(i, ax, cases, seasons, num_cases, num_seasons, x_axis_label, y_axis_label):
    # Hide xtick labels and ticks on the upper case subplot (each basecase)
    #if i == 0 or 1 or 3 or 4 or 6 or 7:
    #    hide_tick_labels(ax)

    # Print x axis title only below the lowest subplot
    if i  == num_cases*num_seasons - 1:
        ax.set_xlabel(x_axis_label)
    ax.set_ylabel(y_axis_label)
    #ax.xaxis.set_ticks(np.arange(min(t)+0, 365, 1))

    # Annotate case
    set_title(ax, cases[i % 3])
    # Annotate case
    # if i % 2 == 0:
    #     title_str = r"$\bf{" + seasons[i/2] + "}$" + ' (upper: ' + r"$\it{" + cases[i % 2] + "}$" + ', lower: ' + r"$\it{"  + cases[(i-1) % 2] + "}$" + ')'
    #     ax.set_title(title_str, # mg assign appropriate season/case
    #                  verticalalignment = 'top',
    #                  horizontalalignment = 'center',
    #                  fontsize = 6, color = 'k')

    # Print legend only at the lower plot (g36 case)
    if i % 1 == 0:
        ax.legend(loc='center right', ncol=1)
    configure_axes(ax)

    #plt.tight_layout(h_pad=0)
    plt.tight_layout()
    #plt.subplots_adjust(hspace = .2)

def tem_conv_CtoF(T_in_degC):
    '''Converts temperature provided in degC to degF
    '''
    T_in_degF = (T_in_degC)*9./5. + 32.

    return T_in_degF

def add_secondary_yaxis_for_degF(ax, time, temp_in_K):
        # Add a secondary axis with temperatures represented in F
        ax_F = ax.twinx()
        # Get limits to match with the left axis
        ax_F.set_ylim([tem_conv_CtoF(ax.get_ylim()[0]),tem_conv_CtoF(ax.get_ylim()[1])])
        # plot a "scaler" variable and make it invisible
        ax_F.plot(time, tem_conv_CtoF(temp_in_K-273.15), linewidth=0.0)
        ax_F.set_ylabel('temperature [$^\circ$F]')
        configure_axes(ax_F)
        #ax.grid(False)
        #ax.xaxis.grid()

def hide_tick_labels(ax):
    '''Removes labels and ticks. Kwargs: bottom controls the ticks, labelbottom the tick labels
    '''
    ax.tick_params(axis = 'x',labelbottom='off',bottom='off')


# ## Read data of short-term simulations
# Combining cases and seasons
# simulations without diverse loads
winter_base = 0
winter_mid = 1
winter_g36 = 2
spring_base = 3
spring_mid = 4
spring_g36 = 5
summer_base = 6
summer_mid = 7
summer_g36 = 8

r_all_without_diverse_loads = list()

r_all_without_diverse_loads.insert(winter_base, Reader(cases.get_result_file_name('winter_base'), "dymola"))
r_all_without_diverse_loads.insert(winter_mid, Reader(cases.get_result_file_name('winter_mid'), "dymola"))
r_all_without_diverse_loads.insert(winter_g36, Reader(cases.get_result_file_name('winter_g36'), "dymola"))
r_all_without_diverse_loads.insert(spring_base, Reader(cases.get_result_file_name('spring_base'), "dymola"))
r_all_without_diverse_loads.insert(spring_mid, Reader(cases.get_result_file_name('spring_mid'), "dymola"))
r_all_without_diverse_loads.insert(spring_g36, Reader(cases.get_result_file_name('spring_g36'), "dymola"))
r_all_without_diverse_loads.insert(summer_base, Reader(cases.get_result_file_name('summer_base'), "dymola"))
r_all_without_diverse_loads.insert(summer_mid, Reader(cases.get_result_file_name('summer_mid'), "dymola"))
r_all_without_diverse_loads.insert(summer_g36, Reader(cases.get_result_file_name('summer_g36'), "dymola"))

# print("summer_g36 name: {}".format(cases.get_result_file_name('summer_g36')))

# winterCold_g36_freezeControl_with = get_results('winterCold_g36_freezeControl_with')
# winterCold_g36_freezeControl_no = get_results('winterCold_g36_freezeControl_no')

# simulations with diverse loads
#winter_base_diverse_loads = 0
#winter_g36_diverse_loads = 1
#spring_base_diverse_loads = 2
#spring_g36_diverse_loads = 3
#summer_base_diverse_loads = 4
#summer_g36_diverse_loads = 5

# r_all_with_diverse_loads = list()

#r_all_with_diverse_loads.insert(winter_base_diverse_loads, Reader(cases.get_result_file_name('winter_base_diverse_loads'), "dymola"))
#r_all_with_diverse_loads.insert(winter_g36_diverse_loads, Reader(cases.get_result_file_name('winter_g36_diverse_loads'), "dymola"))
#r_all_with_diverse_loads.insert(spring_base_diverse_loads, Reader(cases.get_result_file_name('spring_base_diverse_loads'), "dymola"))
#r_all_with_diverse_loads.insert(spring_g36_diverse_loads, Reader(cases.get_result_file_name('spring_g36_diverse_loads'), "dymola"))
#r_all_with_diverse_loads.insert(summer_base_diverse_loads, Reader(cases.get_result_file_name('summer_base_diverse_loads'), "dymola"))
#r_all_with_diverse_loads.insert(summer_g36_diverse_loads, Reader(cases.get_result_file_name('summer_g36_diverse_loads'), "dymola"))

r_all = list()
# Combined simulation results
#r_all = r_all_without_diverse_loads + r_all_with_diverse_loads

print("Read short-term simulation results.")


# ## Plot results
# ## Internal loads

def plot_internal_loads(reader):
    ''' Main method that plots the results
    '''
    from buildingspy.io.outputfile import Reader
    import matplotlib.pyplot as plt
    import matplotlib
    from matplotlib.gridspec import GridSpec

    font = {'family' : 'serif',
            'weight' : 'normal',
            'size'   : 6}
    matplotlib.rc('font', **font)

    plt.clf()

    time_scale=3600.


    (t, fraInt1) = reader.values("flo.gai.y[1]")
    (t, fraInt2) = reader.values("flo.gai.y[2]")
    (t, fraInt3) = reader.values("flo.gai.y[3]")
    intLoa = fraInt1 + fraInt2 + fraInt3
    t = t/time_scale

    # Plot figure
    fig = plt.figure(figsize=(6.5, 2.5))
    ax = fig.add_subplot(1, 1, 1)
    ax.plot(t, intLoa, 'k', linewidth=0.5)

    #make_ticklabels_invisible(plt.gcf())

    # customize days to display

    ax.set_xlabel('time [h]')
    ax.set_ylabel('internal loads [$\mathrm{W/m^2}$]')
    #ax.xaxis.set_ticks(np.arange(min(t)+0, 365, 1))

    ax.set_xlim([min(t), min(t)+24])
    ax.set_xticks(range(24))

    ax.legend(loc='center right', ncol=1)

    configure_axes(ax)

    return plt

# Create the plot for all seasons and cases
fig = plot_internal_loads(r_all_without_diverse_loads[winter_base])
save_plot(fig, "internal_loads")


# ### Room temperatures
def plot_room_temp(readers):
    ''' Main method that plots the results
    '''
    from buildingspy.io.outputfile import Reader
    import matplotlib.pyplot as plt
    import matplotlib
    from matplotlib.gridspec import GridSpec

    # Optionally, change fonts to use LaTeX fonts
    #from matplotlib import rc
    #rc('text', usetex=True)
    #rc('font', family='serif')

    font = {'family' : 'serif',
            'weight' : 'normal',
            'size'   : 6}
    matplotlib.rc('font', **font)

    plt.clf()

    time_scale=86400.

    cases, seasons, num_cases, num_seasons, fig, ax = set_cases_and_initiate_plot()

    # Read results
    for i in range(num_cases*num_seasons):
        (t, TOut) = readers[i].values("weaBus.TDryBul")
        t = t/time_scale

        TRoo = list()
        reader=readers[i]
        TRoo.insert(0, reader.values("flo.nor.air.vol.T")[1])
        TRoo.insert(1, reader.values("flo.wes.air.vol.T")[1])
        TRoo.insert(2, reader.values("flo.sou.air.vol.T")[1])
        TRoo.insert(3, reader.values("flo.eas.air.vol.T")[1])
        TRoo.insert(4, reader.values("flo.cor.air.vol.T")[1])

        #TSetHea = readers[0].values("conVAVCor.TRooHeaSet")[1]
        #TSetCoo = readers[0].values("conVAVCor.TRooCooSet")[1]

        ax[i].plot(t, TOut-273.15,    'k', label='$T_{out}$', linewidth=0.5)
        ax[i].plot(t, TRoo[0]-273.15, 'b',  label='$T_{nor}$', linewidth=0.5)
        ax[i].plot(t, TRoo[1]-273.15, 'g',  label='$T_{wes}$', linewidth=0.5)
        ax[i].plot(t, TRoo[2]-273.15, 'r',  label='$T_{sou}$', linewidth=0.5)
        ax[i].plot(t, TRoo[3]-273.15, 'c',  label='$T_{eas}$', linewidth=0.5)
        ax[i].plot(t, TRoo[4]-273.15, 'g',  label='$T_{cor}$', linewidth=0.5)


        ax[i].patch.set_facecolor('mistyrose')
        #ax[i].fill_between(t, TSetHea-273.15, y2=TSetCoo-273.15, color='white')

        #make_ticklabels_invisible(plt.gcf())

        # customize days to display
        ax[i].set_xlim([min(t)+5, min(t)+10])
        ax[i].set_ylim([15, 30])

        add_secondary_yaxis_for_degF(ax[i], t, TOut)

        set_up_labels(i, ax[i],
                      cases, seasons, num_cases, num_seasons,
                      'time [days]', 'temperature [$^\circ$C]')



    return plt

# Create the plot for all seasons and cases
fig = plot_room_temp(r_all_without_diverse_loads)
save_plot(fig, "TRoom_all")


# South and north zone temperature with and without diverse IHG:
def plot_N_S_room_temp(readers):
    ''' Main method that plots the results
    '''
    from buildingspy.io.outputfile import Reader
    import matplotlib.pyplot as plt
    import matplotlib

    # Optionally, change fonts to use LaTeX fonts
    #from matplotlib import rc
    #rc('text', usetex=True)
    #rc('font', family='serif')

    font = {'family' : 'serif',
            'weight' : 'normal',
            'size'   : 6}
    matplotlib.rc('font', **font)

    plt.clf()
    time_scale=86400.

    cases, seasons, num_cases, num_seasons, fig, ax = set_cases_and_initiate_plot()

    # Read results
    for i in range(num_cases*num_seasons):
        (t, TOut) = readers[i].values("weaBus.TDryBul")
        t = t/time_scale

        reader_without_diverse_IHG = readers[i]
        #reader_with_diverse_IHG = readers[i+6]

        TRoo_N_S = list()
        TRoo_N_S.insert(0,reader_without_diverse_IHG.values("flo.nor.air.vol.T")[1])
        #TRoo_N_S.insert(1,reader_with_diverse_IHG.values("flo.nor.air.vol.T")[1])
        TRoo_N_S.insert(1,reader_without_diverse_IHG.values("flo.sou.air.vol.T")[1])
        #TRoo_N_S.insert(3,reader_with_diverse_IHG.values("flo.sou.air.vol.T")[1])
        TRoo_N_S.insert(2,reader_without_diverse_IHG.values("flo.sou.air.vol.T")[1])

        tWith = reader_with_diverse_IHG.values("flo.nor.air.vol.T")[0]/time_scale

        #TSetHea = reader_without_diverse_IHG.values("conVAVCor.TRooHeaSet")[1]
        #TSetCoo = reader_without_diverse_IHG.values("conVAVCor.TRooCooSet")[1]

        # Generate figure and plot data
        # ax[i] = plt.subplot(num_cases*num_seasons, 1, i+1)

        #ax[i].plot(t, TOut-273.15,        'k',  label='$T_{out}$', linewidth=0.5)
        ax[i].plot(t, TRoo_N_S[0]-273.15, 'b',  label='$T_{nor}$', linewidth=0.5)
        #ax[i].plot(tWith, TRoo_N_S[1]-273.15, 'b',  label='$T_{nor, -50\%}$', linewidth=0.5, linestyle='--')
        ax[i].plot(t, TRoo_N_S[1]-273.15, 'r',  label='$T_{sou}$', linewidth=0.5)
        #ax[i].plot(tWith, TRoo_N_S[3]-273.15, 'r',  label='$T_{sou, +50\%}$', linewidth=0.5, linestyle='--')
        ax[i].plot(t, TRoo_N_S[2]-273.15, 'r',  label='$T_{sou}$', linewidth=0.5)

        ax[i].patch.set_facecolor('mistyrose')
        #ax[i].fill_between(t, TSetHea-273.15, y2=TSetCoo-273.15, color='white')

        # customize days to display
        ax[i].set_xlim([min(t)+5, min(t)+10])
        ax[i].set_ylim([15, 30])

        add_secondary_yaxis_for_degF(ax[i], t, TOut)

        set_up_labels(i, ax[i],
                      cases, seasons, num_cases, num_seasons,
                      'time [days]', 'temperature [$^\circ$C]')


    return plt

# Create the plot for all seasons and cases
fig = plot_N_S_room_temp(r_all)
save_plot(fig, "TRoom_with_without_div_IHG")


# ### Outside conditions
def plot_outside(readers):
    ''' Main method that plots the results
    '''
    # ------------------------------------------------------
    from buildingspy.io.outputfile import Reader
    import matplotlib.pyplot as plt

    plt.clf()
    time_scale=86400.
    # ------------------------------------------------------

    ax = list()
    # Read results
    title = ['winter', 'winter', 'spring', 'spring', 'summer', 'summer']
    for i in range(9):
        (t, TOut) = readers[i].values("weaBus.TDryBul")
        (t, H) = readers[i].values("weaDat.weaBus.HGloHor")

        t = t/time_scale

        # Generate figure and plot data
        ax.insert(i, plt.subplot(6, 1, i+1))

        if i in [0, 3, 6]:
            ax[i].plot(t, TOut-273.15, 'r',                    label='$T_{out}$', linewidth=0.5)
            ax[i].set_ylabel('temperature [$^\circ$C]')
            add_secondary_yaxis_for_degF(ax[i], t, TOut)
            set_title(ax[i], title[i])
        elif i in [1, 4, 7]:
            ax[i].plot(t, H, 'b',                    label='$H_{glo,hor}$', linewidth=0.5)
            ax[i].set_ylim([0, 1000])
            ax[i].set_ylabel('solar irradiation [$W/m^2$]')
        else:
            pass

        # customize days to display
        ax[i].set_xlim([min(t)+5, min(t)+10])


        configure_axes(ax[i])
        ax[i].legend(loc='center right', ncol=1)

    ax[5].set_xlabel('time [days]')

    return plt

# Create the plot for all seasons and cases
fig = plot_outside(r_all_without_diverse_loads)
save_plot(fig, "outside")


# ## VAV control
def plot_vav(readers):
    ''' Main method that plots the results
    '''
    # ------------------------------------------------------
    from buildingspy.io.outputfile import Reader
    import matplotlib.pyplot as plt

    room_styles = ['b', 'k', 'r', 'g', 'c', 'g']
    room_names = ['nor', 'wes', 'sou', 'eas', 'cor']
    plt.clf()
    time_scale=86400.
    # ------------------------------------------------------

    cases, seasons, num_cases, num_seasons, fig, ax = set_cases_and_initiate_plot()

    # Read results
    for i in range(num_cases*num_seasons):
        (t, TOut) = readers[i].values("weaBus.TDryBul")
        t = t/time_scale

        yHea = list()
        yVAV = list()

        reader=readers[i]

        for kRoo in range(len(room_names)):
            yHea.insert(kRoo, reader.values(                "{}.yVal".format(room_names[kRoo]))[1])
            yVAV.insert(kRoo, reader.values(                "{}.yVAV".format(room_names[kRoo]))[1])

        # Generate figure and plot data
        # ax[i] = plt.subplot(num_cases*num_seasons, 1, i+1)

        for iRoo in [0, 2]:
            ax[i].plot(t, yHea[iRoo], room_styles[iRoo],                    label='$y_{{hea,{name}}}$'.format(name=room_names[iRoo]), linewidth=0.5)
            ax[i].plot(t, yVAV[iRoo], room_styles[iRoo],                     label='$y_{{vav,{name}}}$'.format(name=room_names[iRoo]), linewidth=0.5, linestyle="--",                     marker='^', markersize=1, markevery=200)

        #ax[i].fill_between(t, y1=-30, y2=+30, \
        #                   where = (reader.values("conVAVCor.TRooCooSet")[1] < 273.15+28), color='white')
        ax[i].set_ylim([0, 1])

        # customize days to display
        ax[i].set_xlim([min(t)+5, min(t)+10])


        set_up_labels(i, ax[i],
                      cases, seasons, num_cases, num_seasons,
                      'time [days]', 'control signal [$1$]')

    return plt

# Create the plot for all seasons and cases
fig = plot_vav(r_all_without_diverse_loads)
save_plot(fig, "vav_all")


# ### AHU temperatures
def plot_ahu_temp(readers):
    ''' Main method that plots the results
    '''
    # ------------------------------------------------------
    from buildingspy.io.outputfile import Reader
    import matplotlib.pyplot as plt

    room_styles = ['k', 'b', 'g', 'r', 'c', 'g']
    room_names = ['nor', 'wes', 'sou', 'eas', 'cor']
    plt.clf()
    time_scale=86400.
    # ------------------------------------------------------

    cases, seasons, num_cases, num_seasons, fig, ax = set_cases_and_initiate_plot()

    # Read results
    for i in range(num_cases*num_seasons):
        (t, TOut) = readers[i].values("weaBus.TDryBul")
        t = t/time_scale

        reader=readers[i]

        try:
            TSetSup = reader.values("conAHU.TSetSup")[1]
            haveTSetSup = True
        except KeyError:
            haveTSetSup = False
        TSup = reader.values("TSup.T")[1]
        TMix = reader.values("TMix.T")[1]
        TRet = reader.values("TRet.T")[1]

        # Generate figure and plot data
        # ax[i] = plt.subplot(num_cases*num_seasons, 1, i+1)

        ax[i].plot(t, TOut-273.15,    'gray', label='$T_{out}$', linewidth=0.5)
        if haveTSetSup:
            ax[i].plot(t, TSetSup-TSup, 'pink', label='$T_{sup}-T_{set,sup}$', linewidth=0.5)
        ax[i].plot(t, TSup-273.15,    'r', label='$T_{sup}$', linewidth=0.5)
        ax[i].plot(t, TMix-273.15,    'g', label='$T_{mix}$', linewidth=0.5)
        ax[i].plot(t, TRet-273.15,    'b', label='$T_{ret}$', linewidth=0.5)

        ax[i].set_xlim([min(t)+5, min(t)+10])

        # Make the off-hours darker
        #ax[i].fill_between(t, y1=-30, y2=+50, \
        #                   where = (reader.values("conVAVCor.TRooCooSet")[1] < 273.15+28), color='white')
        yMin=min(min(TOut), min(TRet), min(TSup)-5, 273.15-5)-273.15
        yMax=max(max(TOut), max(TSup), max(TRet))-273.15
        ax[i].set_ylim([yMin, yMax])


        set_up_labels(i, ax[i],
                      cases, seasons, num_cases, num_seasons,
                      'time [days]', 'temperature [$^\circ$C]')

        add_secondary_yaxis_for_degF(ax[i], t, TOut)

    return plt

# Create the plot for all seasons and cases
fig = plot_ahu_temp(r_all_without_diverse_loads)
save_plot(fig, "TAHU_all")


# ## Mixed air temperature with and without freeze protection
def plot_ahu_temp(readers):
    ''' Main method that plots the results
    '''
    # ------------------------------------------------------
    from buildingspy.io.outputfile import Reader
    import matplotlib.pyplot as plt

    plt.clf()
    time_scale=86400.
    # ------------------------------------------------------

    # Read results

    for i in [0, 1]:
        (t, TOut) = readers[i].values("weaBus.TDryBul")
        t = t/time_scale

        reader=readers[i]

        if i == 0:
            (tWith, TMixWith) = reader.values("TMix.T")
            yEcoOutWith = reader.values("eco.yOut")[1]
            TSupWith = reader.values("TSup.T")[1]

            tWith = tWith/time_scale
        else:
            TMixNoFr = reader.values("TMix.T")[1]
            yEcoOutNoFr = reader.values("eco.yOut")[1]
            TSupNoFr = reader.values("TSup.T")[1]


    # Plot figure
    fig = plt.figure(figsize=(6.5,4.))
    ax = fig.add_subplot(2, 1, 1)
    ax.plot(t, TOut-273.15,         'gray', label='$T_{out}$', linewidth=0.5)
    ax.plot(t, TSupNoFr-273.15,     'r', label='$T_{sup}$', linewidth=0.5, linestyle="--")
    ax.plot(t, TMixNoFr-273.15,     'b', label='$T_{mix,no}$',  linewidth=0.5, linestyle="--")
    #ax.plot(tWith, TSupWith-273.15, 'r', label='$T_{sup,with}$', linewidth=0.5)
    ax.plot(tWith, TMixWith-273.15, 'b', label='$T_{mix,with}$', linewidth=0.5)

    #ax.set_xlabel('time [days]')
    ax.set_ylabel('temperature [$^\circ$C]')

    ax.set_xlim([min(t)+5, min(t)+10])
    add_secondary_yaxis_for_degF(ax, t, TOut)

    ax.legend(loc='center right', ncol=1)

    configure_axes(ax)

    # Make the off-hours darker
    #ax.fill_between(t, y1=-30, y2=+50, \
    #                     where = (reader.values("conVAVCor.TRooCooSet")[1] < 273.15+28), color='white')
    yMin=min(min(TOut), min(TMixNoFr))-273.15
    yMax=max(max(TOut), max(TMixNoFr))-273.15
    ax.set_ylim([-35, 30])


    ax = fig.add_subplot(2, 1, 2)
    ax.plot(tWith, yEcoOutWith,    'r', label='$y_{eco,out,with}$', linewidth=0.5)
    ax.plot(t, yEcoOutNoFr,    'r', label='$y_{eco,out,no}$',  linewidth=0.5, linestyle="--")
    ax.set_xlabel('time [days]')
    ax.set_ylabel('$y_{eco,out}$ [$1$]')
    #ax.xaxis.set_ticks(np.arange(min(t)+0, 365, 1))

    # Make the off-hours darker
    #ax.fill_between(t, y1=-30, y2=+50, \
    #                     where = (reader.values("conVAVCor.TRooCooSet")[1] < 273.15+28), color='white')
    yMin=0
    yMax=1
    ax.set_ylim([yMin, yMax])


    ax.set_xlim([min(t)+5, min(t)+10])

    ax.legend(loc='center right', ncol=1)

    configure_axes(ax)

    return plt

# Create the plots
fig = plot_ahu_temp([winterCold_g36_freezeControl_with, winterCold_g36_freezeControl_no])
save_plot(fig, "TMixFre")


# ### Flow rates and fan speed
def plot_flow_signals(readers):
    ''' Main method that plots the results
    '''
    # ------------------------------------------------------
    from buildingspy.io.outputfile import Reader
    import matplotlib.pyplot as plt

    room_styles = ['k', 'b', 'g', 'r', 'c', 'g']
    room_names = ['nor', 'wes', 'sou', 'eas', 'cor']
    plt.clf()
    time_scale=86400.
    # ------------------------------------------------------

    cases, seasons, num_cases, num_seasons, fig, ax = set_cases_and_initiate_plot()

    # Read results
    for i in range(num_cases*num_seasons):
        (t, TOut) = readers[i].values("weaBus.TDryBul")
        t = t/time_scale

        reader=readers[i]

        yFanSup = reader.values("fanSup.y")[1]
        #yFanRet = reader.values("fanRet.y")[1]
        yEcoOut = reader.values("eco.yOut")[1]
        yEcoRet = reader.values("eco.yRet")[1]

        # Generate figure and plot data
        # ax[i] = plt.subplot(num_cases*num_seasons, 1, i+1)

        ax[i].plot(t, yFanSup, 'r', label='$y_{fan,sup}$', linewidth=0.5)
        #ax[i].plot(t, yFanRet, 'b', label='$y_{fan,ret}$', linewidth=0.5, linestyle='--')
        ax[i].plot(t, yEcoOut, 'b', label='$y_{eco,out}$', linewidth=0.5)
        ax[i].plot(t, yEcoRet, 'g', label='$y_{eco,ret}$', linewidth=0.5, linestyle='--')

        ax[i].set_xlim([min(t)+5, min(t)+10])

        set_up_labels(i, ax[i],
                      cases, seasons, num_cases, num_seasons,
                      'time [days]', 'control signal [$1$]')

        # Make the off-hours darker
        #ax[i].fill_between(t, y1=-30, y2=+50, \
        #                 where = (reader.values("conVAVCor.TRooCooSet")[1] < 273.15+28), color='white')
        yMin=0
        yMax=1
        ax[i].set_ylim([yMin, yMax])


    return plt

# Create the plots
fig = plot_flow_signals(r_all_without_diverse_loads)
save_plot(fig, "flow_signals_all")


# ### Normalized flow rates
def plot_normalized_flow_rates(readers):
    ''' Main method that plots the results
    '''
    # ------------------------------------------------------
    from buildingspy.io.outputfile import Reader
    import matplotlib.pyplot as plt

    room_styles = ['k', 'b', 'g', 'r', 'c', 'g']
    room_names = ['nor', 'wes', 'sou', 'eas', 'cor']
    plt.clf()
    time_scale=86400.
    # ------------------------------------------------------

    cases, seasons, num_cases, num_seasons, fig, ax = set_cases_and_initiate_plot()

    # Read results
    for i in range(num_cases*num_seasons):
        (t, TOut) = readers[i].values("weaBus.TDryBul")
        t = t/time_scale

        reader=readers[i]

        mFanSup = reader.values("fanSup.m_flow")[1]
#        mFanRet = reader.values("fanRet.m_flow")[1]/ \
#            reader.values("fanRet.m_flow_nominal")[1][1]
        mEco = reader.values("eco.port_Out.m_flow")[1]

        # Convert to air change per hours
        VBui = reader.values("ATot")[1][1] * reader.values("flo.hRoo")[1][1]
        #print("Total floor area {}".format(reader.values("ATot")[1][1]))
        #print("Room height {}".format(reader.values("flo.hRoo")[1][1]))
        #print("Volume      {}".format(VBui))
        conFacACH = 3600./VBui/1.2

        fanSupACH = mFanSup * conFacACH
        ecoACH    = mEco    * conFacACH

        # ax[i] = plt.subplot(num_cases*num_seasons, 1, i+1)

        ax[i].plot(t, fanSupACH,    'b', label='$\dot V_{fan,sup}/V_{bui}$', linewidth=0.5)
#        ax[i].plot(t, mFanRet,    'g', label='$\dot m_{fan,ret}/\dot m_{0}$', linewidth=0.5)
        ax[i].plot(t, ecoACH,       'r', label='$\dot V_{eco,out}/V_{bui}$', linewidth=0.5)


        # Make the off-hours darker
        #ax[i].fill_between(t, y1=-30, y2=+50, \
        #                 where = (reader.values("conVAVCor.TRooCooSet")[1] < 273.15+28), color='white')

        # customize days to display
        ax[i].set_xlim([min(t)+5, min(t)+10])
        ax[i].set_ylim([0, 4])

        set_up_labels(i, ax[i],
                      cases, seasons, num_cases, num_seasons,
                      'time [days]', 'ACH [$h^{-1}$]')

    return plt

# Create the plots
fig = plot_normalized_flow_rates(r_all_without_diverse_loads)
save_plot(fig, "normalized_flow_all")


# ## Read annual results
#
# This section also clears the old results to free up memory.
# Free up storage, then read new data
import gc
r_all_without_diverse_loads = list()
r_all_with_diverse_loads = list()
r_all = list()
gc.collect()

print("Cleaned up memory.")


list_of_variables = ['res.EHea', "res.ECooSen", "res.ECooLat", "res.EFan"]
r_g36_annual_without_diverse_loads=get_partial_results('annual_g36', list_of_variables)
print("Read annual G36 without diverse loads")

r_base_annual_without_diverse_loads=get_partial_results('annual_base', list_of_variables)
print("Read annual base without diverse loads")
#r_g36_annual_with_diverse_loads=get_partial_results('annual_g36_diverse_loads', list_of_variables)
#print("Read annual G36 with diverse loads")
#r_base_annual_with_diverse_loads=get_partial_results('annual_base_diverse_loads', list_of_variables)
#print("Read annual base with diverse loads")

# Get setpoints
#reader=get_results('annual_g36.mat')
#TSetHea = reader.values("conVAVCor.TRooHeaSet")
#TSetCoo = reader.values("conVAVCor.TRooCooSet")

r_mid_annual_without_diverse_loads=get_partial_results('annual_mid', list_of_variables)
print("Read annual mid without diverse loads")


# ### Energy use
#
# We convert the energy use to site electricity use, using an average COP for the chiller of 3.2, and a COP for heating of 4.0. These numbers are from https://portfoliomanager.energystar.gov/pdf/reference/Source%20Energy.pdf
#

type(r_g36_annual_without_diverse_loads)

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
plot_energy(r_base_annual_without_diverse_loads, r_mid_annual_without_diverse_loads, r_g36_annual_without_diverse_loads)


# ## Plot energy use with diverse loads

def plot_all_energy(r_base_without, r_g36_without, r_base_with, r_g36_with):
    from buildingspy.io.outputfile import Reader
    import matplotlib.pyplot as plt

    plt.clf()

    # Conversion to kWh/m2
    conv = 1/3600./1000.
    results = [r_base_without, r_g36_without, r_base_with, r_g36_with]
    width = 0.5       # the width of the bars: can also be len(x) sequence

    hea    = [0., 0., 0., 0.]
    cooSen = [0., 0., 0., 0.]
    cooLat = [0., 0., 0., 0.]
    fan    = [0., 0., 0., 0.]
    cooLatBas = [0., 0., 0., 0.]
    coo = [0, 0, 0., 0.]
    fanBas = [0., 0., 0., 0.]

    idx = [0, 1, 2, 3]
    for i in idx:
        res_dic = results[i]
        hea[i]    =  res_dic['res.EHea'][-1] * conv / COPh
        cooSen[i] = -res_dic['res.ECooSen'][-1] * conv / COPc
        cooLat[i] = -res_dic['res.ECooLat'][-1] * conv / COPc
        coo[i] = cooSen[i] + cooLat[i]
        fan[i]    =  res_dic['res.EFan'][-1] * conv
        cooLatBas[i] = hea[i] + cooSen[i]
        fanBas[i]    = cooLatBas[i] + cooLat[i]


    plt.figure(figsize=(5,3))

    p1 = plt.bar(idx, hea,    width, color='r')
    p2 = plt.bar(idx, cooSen, width, bottom=hea, color='g')
    p3 = plt.bar(idx, cooLat, width, bottom=cooLatBas, color='b')
    p4 = plt.bar(idx, fan,    width, bottom=fanBas, color='k')
    plt.ylabel('site electricity use [kWh/(m2  a)]')
    plt.xticks([0, 1, 2, 3], ('base case', 'guideline 36', 'base case, $\pm 50\%$', 'guideline 36, $\pm 50\%$'))
    #plt.yticks(np.arange(0, 81, 10))
    plt.legend((p1[0], p2[0], p3[0], p4[0]),('heating', 'sensible cooling', 'latent cooling', 'fan'),loc='upper right')
    plt.grid(color='lightgrey', axis='y', linewidth=0.25)
    for spine in plt.gca().spines.values():
        spine.set_visible(False)
    save_plot(plt, "energy_all")

plot_all_energy(r_base_annual_with_diverse_loads, r_mid_annual_with_diverse_loads,
                r_g36_annual_with_diverse_loads)


# ### Diagnostic output

print("CPUtime, base {} h".format(r_base_annual_without_diverse_loads['CPUtime'][-1]/3600.))
print("CPUtime, G36  {} h".format(r_g36_annual_without_diverse_loads['CPUtime'][-1]/3600.))

plt.clf()

roo_lis = [{"var": 'nor', "name": 'north'},
           {"var": 'wes', "name": 'west'},
           {"var": 'sou', "name": 'south'},
           {"var": 'eas', "name": 'east'},
           {"var": 'cor', "name": 'corridor'}]
nRoo = len(roo_lis)
iRoo = 1
iPlt = 1
for roo in roo_lis:
    iSim = 1
    for sim in [{"res": r_base_annual_without_diverse_loads, 'name': 'base case'},
                {"res": r_base_annual_without_diverse_loads, 'name': 'mid case'},
                {"res": r_g36_annual_without_diverse_loads, 'name': 'guideline36'}]:
        plt.subplot(nRoo, 2, iPlt)
        plt=Plotter.boxplot(t=sim['res']['time'],                     y=sim['res']['flo.{}.air.vol.T'.format(roo['var'])]-273.15,                     increment=3600, nIncrement=24)
        #plt.set_facecolor('mistyrose')
        #plt.patch.fill_between(t, TSetHea-273.15, y2=TSetCoo-273.15, color='white')
        # Decorate, save and show the plot
        if iRoo is nRoo:
            plt.xlabel('Time [h]')
        if iSim is 1:
            plt.ylabel(u'$T_{room}$ [$^\circ$C]')
        plt.grid()
        plt.xlim(6.5,19.5)
        plt.ylim(18, 26)
        plt.yticks([18, 20, 22, 24, 26])

        plt.title('{} zone, {}'.format(roo['name'], sim['name']))
        iSim+=1
        iPlt+=1
    iRoo+=1
plt.tight_layout()
save_plot(plt, "roomTemperatures_boxplot")
plt.show()
