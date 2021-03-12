import sys
import re
import pandas as pd
import datetime
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine, MetaData, Table, Column, Integer, String, DateTime

engine = create_engine('sqlite:///access_ORM.db', echo=True)
file = open(sys.argv[1], "r")
logs_entries = []
Base = declarative_base()


class LogEntry(Base):
    __tablename__ = 'access_logs'
    id = Column(Integer, primary_key=True)
    hostname = Column(String)
    ip_address = Column(String)
    date_time = Column(DateTime)
    message = Column(String)


Base.metadata.create_all(engine)

Session = sessionmaker(bind=engine)
session = Session()

for entry in file:
    line = re.compile(
        r'^((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{1,2}\s+\d{2}:\d{2}:\d{2})\s+(\S+)\s+(sshd)\S+:\s+(.*?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*)$').search(entry)
    if line:
        datetime_str = line.group(1) + " " + str(datetime.datetime.now().year)

        datetime_obj = datetime.datetime.strptime(
            datetime_str, '%b %d %H:%M:%S %Y')

        log = LogEntry(hostname=line.group(3), ip_address=line.group(6),
                       date_time=datetime_obj, message=line.group(5))
        logs_entries.append(log)
        # session.add(log)

session.commit()
# Bulk save:
session.bulk_save_objects(logs_entries)
session.commit()

session.close()
file.close()
