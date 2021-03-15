import sys, re, datetime, openpyxl, pandas as pd
file = open(sys.argv[1], 'r')
logs_entries = []
for entry in file:
    line = re.compile(r'^((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{1,2}\s+\d{2}:\d{2}:\d{2})\s+(\S+)\s+(sshd)\S+:\s+(.*?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*)$').search(entry)
    if line:
        datetime_str = line.group(1) + " " + str(datetime.datetime.now().year)
        datetime_obj = datetime.datetime.strptime(datetime_str, '%b %d %H:%M:%S %Y')
        logs_entries.append({"hostname": line.group(3), "ip_address": line.group(6), "date_time": datetime_obj, "message": line.group(5)})

# Now we should close the file and write collected results in Excel file
file.close()
df = pd.DataFrame(logs_entries)
df.to_excel("./my_access_logs.xlsx")

df["hostname"].mask(df["hostname"].duplicated(), inplace=True)
df["ip_address"].mask(df["ip_address"].duplicated(), inplace=True)
df.to_excel("./my_Formatted_logs.xlsx")