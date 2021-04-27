import datetime
import re
from sqlalchemy import create_engine, MetaData, Table, Column, Integer, String, DateTime, engine
from sqlalchemy.engine import result


inputFile = open ("lesson8/logfile.log", 'r',encoding='utf-8')

log_entries = []

for entry in inputFile:
    line = re.compile (
        r'^((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{1,2}\s+\d{2}:\d{2}:\d{2})\s+(\S+)\s+(sshd)\S+:\s+(.*?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*)$').search (
        entry)
    if line:
        datetime_str = line.group (1) + " " + str (datetime.datetime.now ().year)
        datetime_obj = datetime.datetime.strptime (datetime_str, '%b %d %H:%M:%S %Y')
        log_entries.append ({"hostname": line.group (3), "ip_address": line.group (6), "date_time": datetime_obj,"message": line.group (5)})

inputFile.close ()

engine = create_engine('sqlite:///lesson8/access.db',echo = True)
meta = MetaData()

access_logs = Table(
    'access_logs', meta, 
    Column('id', Integer, primary_key= True),
    Column('hostname', String), 
    Column('ip_address', String), 
    Column('date_time', DateTime), 
    Column('message', String),
    )
meta.create_all(engine)
conn = engine.connect()
result = conn.execute(access_logs.insert(None), log_entries)
conn.close()