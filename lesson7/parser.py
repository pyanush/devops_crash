import sys
import re
import pandas as pd
import datetime

file = open(sys.argv[1], "r")

logs_entries = []

for entry in file:
    line = re.compile(
        r'^((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{1,2}\s+\d{2}:\d{2}:\d{2})\s+(\S+)\s+(sshd)\S+:\s+(.*?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*)$').search(entry)
    if line:
        datetime_str = line.group(1) + " " + str(datetime.datetime.now().year)

        datetime_obj = datetime.datetime.strptime(
            datetime_str, '%b %d %H:%M:%S %Y')
        logs_entries.append({"hostname": line.group(3), "ip_address": line.group(
            6), "date_time": datetime_obj, "message": line.group(5)})


df = pd.DataFrame(logs_entries)

df.to_excel("access_logs.xlsx")
file.close()
