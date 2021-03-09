import sys, re, numpy, datetime, pandas, openpyxl

pattern = re.compile(r'^((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{1,2}\s+\d{2}:\d{2}:\d{2})\s+(\S+)\s+(sshd)\S+:\s+(.*?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*)$')

file = open(sys.argv[1], 'r')
logs_entries = []

for line in file:
    result = pattern.search(line)
    if result:
        datetime_str = result.group(1) + " " + str(datetime.datetime.now().year)
        datetime_obj = datetime.datetime.strptime(datetime_str, '%b %d %H:%M:%S %Y')
        logs_entries.append({"date_time": datetime_obj, "hostname": result.group(3), "ip_address": result.group(6), "message": result.group(5)})

file.close()

df = pandas.DataFrame(logs_entries)
df["hostname"].mask(df["hostname"].duplicated(), inplace=True)
df["ip_address"].mask(df["ip_address"].duplicated(), inplace=True)
df.to_excel("output_logs.xlsx")

