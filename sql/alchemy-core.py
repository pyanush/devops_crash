from sqlalchemy import create_engine, MetaData, Table, Column, Integer, String, Datetime

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

ins = access_logs.insert().values(hostname = line.group(3),
  ip_address = line.group(6), date_time = datetime_obj,
  message = line.group(5))
result = conn.execute(ins)


logs_entries = [] 
result = conn.execute(access_logs.insert(None), logs_entries)

conn.close()
