from datetime import datetime
import sys
import pandas as pd
import numpy
import re
import os

logs_entries = []
with open('logfile.log', 'rt') as file:
    for lines in file:
        line = re.compile(r'^((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{1,2}\s+\d{2}:\d{2}:\d{2})\s+(\S+)\s+(sshd)\S+:\s+(.*?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*)$').search(lines)
        if line:
            datetime_str = line.group(1) + " " +str(datetime.now().year)
            datetime_obj = datetime.strptime(datetime_str,'%b %d %H:%M:%S %Y')
            logs_entries.append({
                "date_time":datetime_obj, 
                "ip_address":line.group(6), 
                "hostname":line.group(3), 
                "message":line.group(5)
                })

df = pd.DataFrame(logs_entries)
df.to_excel("parsed_logs.xlsx")