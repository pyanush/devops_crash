import pandas as pd
import numpy
import datetime
import re
import os


""" Below RegExp returns 6 groups:
    1) Datetime (mm dd hh:ss:mm = Feb 15 13:01:24)
    2) Month (Feb)
    3) Host machine
    4) SSHD
    5) Message
    6) IP address
"""

input_filepath = 'D:\ALL_THE_STUFF\DevOps_Crash_Course\devops_crash\lesson7\data\logfile.log'
output_filepath = 'D:\ALL_THE_STUFF\DevOps_Crash_Course\devops_crash\lesson7\data\output.xlsx'

with open(input_filepath,'r') as file:
    rows = file.readlines()
    log_entries = []
    for entry in file:
        line = re.compile(r'^((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{1,2}\s+\d{2}:\d{2}:\d{2})\s+(\S+)\s+(sshd)\S+:\s+(.*?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*)$').search(entry)
        if line:
            datetime_str = line.group(1) + "" + str(datetime.datetime.now().year)
            datetime_obj = datetime.datetime.strptime(datetime_str,'%b %d %H:%S %Y')
            log_entries.append({"date_time":datetime_obj, "hostname":line.group(3),"ip_address":line_group(6), "message":line.group(5)})

df = pd.DataFrame(log_entries)
df.to_excel(output_filepath)
file.close()

# Make sure that newly create Excel file isn't empty :P
import os

# Check more on file sizes here https://stackoverflow.com/questions/2104080/how-can-i-check-file-size-in-python
file_size = os.stat(output_filepath).st_size
print(file_size)
if(file_size < 5000):
    raise Exception("Sorry, bro, but your Excel file is empty 😔")

#df["hostname"].mask(df["hosname"].duplicated(),inplance=True)
#df["ip_address"].mask(df["ip_address"].duplicated(),inplance=True)