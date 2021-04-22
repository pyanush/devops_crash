#  parsing SFTP server access logs
import sys
import os
import datetime
import re
import pandas as pd
reg = re.compile(r'^((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s'
                 r'+\d{1,2}\s+\d{2}:\d{2}:\d{2})\s+(\S+)\s+(sshd)\S+:\s+'
                 r'(.*?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*)$')
try:
    file = open('/opt/apt/logs/logfile.log', 'r')  # get input file name from args
except:
    print('*** No input file! ***')

logs = []
cnt, uptime = 0, datetime.datetime.now()
print('File processing has started. Please wait...')
for entry in file.readlines():  # read file line by line
    line = reg.search(entry)    # to find strings that we looking for
    if line:
        cnt += 1
        datetime_str = line.group(1) + ' ' + str(datetime.datetime.now().year)
        datetime_obj = datetime.datetime.strptime(datetime_str, '%b %d %H:%M:%S %Y')
        logs.append({"hostname": line.group(3), "ip_address": line.group(6),
                     "date_time": datetime_obj, "message": line.group(5)})
file.close()
# converting to excel file using pandas
if cnt > 0:
    df = pd.DataFrame(logs)
#    if not os.path.exists('/opt/app/result'):  # check output directory
#        print('trouble with dir')
#        os.mkdir('/opt/apt/result')
    df.sort_values(by=['ip_address'], inplace=True)  # sort by ip address
    df["hostname"].mask(df["hostname"].duplicated(), inplace=True)  # erasing duplicates from hostname
    df["ip_address"].mask(df["ip_address"].duplicated(), inplace=True)  # same ip address
    df.to_excel('/opt/apt/result/access_logs.xlsx')
    open('/opt/apt/result/.access_logs.xlsx', 'a').close()
else:
    print('Something goes wrong!')
    if cnt == 0:
        print('No matches founded. Nothing to import')
# counting time that script was running
uptime = (datetime.datetime.now()-uptime).total_seconds()
print('We find %s matches! Script was running during: %s seconds' % (cnt, uptime))
