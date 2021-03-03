import pandas as pd
import re
out=open('ip_logs.txt', 'a')
log = pd.read_table('logfile.log')
for index, row in log.iterrows():
    for z in row:
        l=re.findall(r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}',z)
        if l:
            line=l[0]+','+re.sub(r'.+ \d\d\:\d\d\:\d\d ', '', z)
            l4=re.sub(r'sshd\[\d{1,6}\]\: ', '', re.sub(r'vmi\d{6} ', '', line))
            print(l4)
            out.write(l4+'\n')
out.close()

data = open('ip_logs.txt')
df = pd.read_csv(data, sep=',', names=("IP", "description" ))
df.sort_values(by=['IP'], inplace=True)
df.to_excel("output.xlsx")
# for index, row in df.iterrows():
#     y=f'{row[0]}\t{row[1]}\n'
#     print(y)
#     with open('output.csv', 'a') as outf:
#         outf.write(y)

data.close()
