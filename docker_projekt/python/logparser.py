import datetime
import re

import numpy as np
import pandas as pd

inputFile = open("/app/logfile.log", 'r', encoding='utf-8')

log_entries = []

for entry in inputFile:
    line = re.compile(
        r'^((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{1,2}\s+\d{2}:\d{2}:\d{2})\s+(\S+)\s+('
        r'sshd)\S+:\s+(.*?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*)$').search(entry)
    if line:
        datetime_str = line.group(1) + " " + str(datetime.datetime.now().year)
        datetime_obj = datetime.datetime.strptime(datetime_str, '%b %d %H:%M:%S %Y')
        log_entries.append({"hostname": line.group(3), "ip_address": line.group(6), "date_time": datetime_obj, "message": line.group(5)})

inputFile.close()

# Excel file:
df = pd.DataFrame(log_entries)
df["hostname"].mask(df["hostname"].duplicated(), inplace=True)
df["ip_address"].mask(df["ip_address"].duplicated(), inplace=True)
len(df)
part_1_df, part_2_df = np.split(df, [int(len(df) * .50)])
part_1_df.to_excel('/app/upload/formated1_log.xlsx')
part_2_df.to_excel('/app/upload/formated2_log.xlsx')

#while True:
 #   pass
