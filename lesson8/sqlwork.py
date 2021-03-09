import sys
import re
import pandas as pd
import datetime
# python sqlwork.py logfile.log
# pip install openpyxl
# pip install

from sqlalchemy import create_engine, MetaData, Table, Column, Integer, String, DateTime

engine = create_engine('sqlite:///access.db', echo = True)

meta = MetaData()
access_logs = Table(
 'access_logs', meta,
 Column('id', Integer, primary_key = True),
 Column('hostname', String),
 Column('ip_address', String),
 Column('date_time', DateTime),
 Column('message', String),
)
meta.create_all(engine)

conn = engine.connect()

logs_entries = []
file = open(sys.argv[1], "r")
# File = open("logfile.log", mode="r", encoding="UTF-8", )

for entry in file:
    line = re.compile(r'^((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{1,2}\s+\d{2}:\d{2}:\d{2})\s+(\S+)\s+(sshd)\S+:\s+(.*?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*)$').search(entry)

    if line:
        datetime_str = line.group(1) + " " + str(datetime.datetime.now().year)
        datetime_obj = datetime.datetime.strptime(datetime_str, '%b %d %H:%M:%S %Y')
        logs_entries.append({"hostname": line.group(3),
                             "ip_address": line.group(6), "date_time": datetime_obj,
                             "message": line.group(5)})


        ins = access_logs.insert().values(hostname = line.group(3), ip_address = line.group(6), date_time = datetime_obj, message = line.group(5))
        result = conn.execute(ins)

file.close()

conn.close()