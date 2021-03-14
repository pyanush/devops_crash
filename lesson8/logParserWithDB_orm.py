import datetime
import re
import pandas as pd
from os import access
from sqlalchemy import create_engine, engine, log
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import session
from sqlalchemy.orm.session import Session
from sqlalchemy.sql.schema import Column
from sqlalchemy.sql.sqltypes import DateTime, Integer, String
from sqlalchemy.orm import sessionmaker


inputFile = open ("lesson7/logfile.log", 'r',encoding='utf-8')

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
print(type(log_entries))

'''
engine = create_engine('sqlite:///lesson8/access_logs.db', echo = True)
Base = declarative_base()

class LogEntry(Base):
    __tablename__ = 'access_logs'

    id = Column(Integer, primary_key=True)
    hostname = Column(String)
    ip_address = Column(String)
    date_time = Column(DateTime)
    message = Column(String)
Base.metadata.create_all(engine)  

Session = sessionmaker(bind = engine)
session = Session()  
log = LogEntry(hostname = 'hostname', ip_address = 'ip address', date_time = datetime_obj, message = 'who is')
session.add(log)

#logs_entries = log_entries
session.add_all([log_entries])
session.commit()

session.close()
'''