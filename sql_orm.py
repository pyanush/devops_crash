import paramiko
import time
ssh_client =paramiko.SSHClient()
ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh_client.connect(hostname='207.244.229.74',username='testuser',password='*,<R#!$(2udw{Zgz')
ftp_client=ssh_client.open_sftp()
ftp_client.get('/opt/testuser/logfile.log','logfile.log')
ftp_client.close()
time.sleep(10)

import sys
import datetime
import pandas as pd
import re

logs_entries=[]
try: file = open(sys.argv[1], 'r')
except:  file = open('logfile.log', 'r')

for lines in file:
    line = re.compile(r'^((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{1,2}\s+\d{2}:\d{2}:\d{2})\s+(\S+)\s+(sshd)\S+:\s+(.*?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*)$').search(lines)
    if line:
        print(line)
        datetime_str = line.group(1) + " " +str(datetime.datetime.now().year)
        datetime_obj = datetime.datetime.strptime(datetime_str,'%b %d %H:%M:%S %Y')
        logs_entries.append({"hostname": line.group(3),"ip_address": line.group(6), "date_time": datetime_obj,"message": line.group(5)})
file.close()

df = pd.DataFrame(logs_entries)
#df["hostname"].mask(df["hostname"].duplicated(),inplace=True)
#df["ip_address"].mask(df["ip_address"].duplicated(),inplace=True)
df.sort_values(by=['ip_address'], inplace=True)
df.to_excel("access_logs.xlsx")
