import sys
import re
#import pandas as pd
import datetime
from sqlalchemy import create_engine, MetaData, Table, Column, Integer, String, DateTime

engine = create_engine('sqlite:////app/result/access.db', echo=True)
file = open("/app/logs/logfile.log", "r")
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

# Creating table:
meta = MetaData()
access_logs = Table('access_logs', meta, Column('id', Integer, primary_key=True), Column(
    'hostname', String), Column('ip_address', String), Column('date_time', DateTime), Column('message', String),)
meta.create_all(engine)
# Connect to engine
conn = engine.connect()
# Bulk insert:
result = conn.execute(access_logs.insert(None), logs_entries)
# Connection close
conn.close()
file.close()
