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

# out=open('ip_logs.txt', 'a')
# log = pd.read_table('logfile.log')
# for index, row in log.iterrows():
#     for z in row:
#         l=re.findall(r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}',z)
#         if l:
#             line=l[0]+','+re.sub(r'.+ \d\d\:\d\d\:\d\d ', '', z)
#             l4=re.sub(r'sshd\[\d{1,6}\]\: ', '', re.sub(r'vmi\d{6} ', '', line))
#             print(l4)
#             out.write(l4+'\n')
           
# out.close()


# data = open('ip_logs.txt')
# df = pd.read_csv(data, sep=',', names=("IP", "description" ))
# df.sort_values(by=['IP'], inplace=True)
# df.to_excel("output.xlsx")
# data.close()