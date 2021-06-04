#!/usr/bin/env python
# coding: utf-8

from datetime import datetime, timedelta
from numpy import arange

# Convert date to julian day
def date_to_julian(date):
    if type(date) is str:
        date = datetime.strptime(date,'%Y-%m-%d')
    time_structure = date.timetuple()
    julian = time_structure.tm_yday

    return julian

# Convert julian day to simulation hours
def julian_to_hour(date):
    julian = date_to_julian(date)
    start_hour = (julian-1)*24
    end_hour = julian*24

    return start_hour,end_hour

# Get hours due to normal open and close without considering holidays
def all_hours(open_hour,close_hour):
    all_hours = []
    for iDay in range(365):
        all_hours.append(open_hour+iDay*24)
        all_hours.append(close_hour+iDay*24)

    return all_hours

# Remove holiday hours
def operation_hours(open_hour,close_hour,holidays,Sundays=[],Saturdays=[]):
    '''Sunday and Saturday are optional inputs.
       They are referring to the first occuring dates for Sunday and Saturday in the year.
    '''

    operation_hours = []
    operation_hours = all_hours(open_hour,close_hour)
    for date in holidays+Sundays+Saturdays:
        start_hour, end_hour = julian_to_hour(date)
        for hour in arange(start_hour,end_hour,0.5):
            if hour in operation_hours:
                operation_hours.remove(hour)

    return operation_hours

# Remove Saturday or Sunday hours
def saturdays_or_sundays(day):
    days = []
    for week in range(52):
        days.append(datetime.strptime(day,'%Y-%m-%d')+timedelta(week*7))

    return days

# US holidays in 2019: 1/1,1/21,2/18,5/27,7/4,9/2,10/14,11/11,11/28,12/25
holidays = ['2019-01-01',
            '2019-01-21',
            '2019-02-18',
            '2019-05-27',
            '2019-07-04',
            '2019-09-02',
            '2019-10-14',
            '2019-11-11',
            '2019-11-28',
            '2019-12-25']

# Create high operation hours case: 7:00-22:00 M-Sun
operation_hours_high = operation_hours(7.0,22.0,holidays)
print(operation_hours_high)

# The first weekend in 2019 starts on Jan 5 and 6
# Create medium operation hours case: 7:00-19:30 M-Sat,
Sunday = '2019-01-06'
Sundays = saturdays_or_sundays(Sunday)
operation_hours_medium = operation_hours(7.0,19.5,holidays,Sundays=Sundays)
print(operation_hours_medium)

# Create low operation hours case: 8:00-18:00 M-F
Saturday = '2019-01-05'
Saturdays = saturdays_or_sundays(Saturday)
operation_hours_low = operation_hours(8.0,18.0,holidays,Sundays,Saturdays)
print(operation_hours_low)

# Sanity check
all_hours = all_hours(7,22)
print('The total operation hours not considering holidays has "{}" entries'.format(len(all_hours)))
print('The high operation hour case has "{}" entries'.format(len(operation_hours_high)))
print('The medium operation hour case has "{}" entries'.format(len(operation_hours_medium)))
print('The low operation hour case has "{}" entries'.format(len(operation_hours_low)))
