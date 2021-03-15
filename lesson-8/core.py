import sys, re, datetime
from sqlalchemy import create_engine, MetaData, Table, Column, Integer, String, DateTime

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

engine = create_engine('sqlite:///access-core.db', echo = True)
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
inserts = conn.execute(access_logs.insert(None), logs_entries)
conn.close()
