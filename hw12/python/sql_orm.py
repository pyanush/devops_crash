import re
import datetime
from sqlalchemy import Column, ForeignKey, Integer, String, MetaData, Table, DateTime
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

err=[]
logs_entries = []
access_logs =[]
meta = MetaData()
engine = create_engine('sqlite:///access_logs.db', echo = True)
Base = declarative_base()


class LogEntry(Base):
    __tablename__ = 'access_logs'
    id = Column('id',Integer, primary_key=True)
    hostname = Column('host', String)
    ip_address = Column('ip', String)
    date_time = Column('date', DateTime)
    message = Column('description', String)
    def __init__(self, **kwargs): self.__dict__.update(kwargs)
    # def __repr__(self): return "(id='%s', date='%s', ip='%s', msg='%s', hostname='%s')" % (self.id, self.date, self.ip,  self.msg, self.hostname)

Base.metadata.create_all(engine)

Session = sessionmaker(bind = engine)
session = Session()

try: file = open(sys.argv[1], 'r')
except: file = open('logfile.log', 'r')

for lines in file:
    line = re.compile(r'^((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{1,2}\s+\d{2}:\d{2}:\d{2})\s+(\S+)\s+(sshd)\S+:\s+(.*?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*)$').search(lines)
    if line:
        datetime_str = line.group(1) + " " +str(datetime.datetime.now().year)
        datetime_obj = datetime.datetime.strptime(datetime_str,'%b %d %H:%M:%S %Y')
        log = LogEntry(hostname=line.group(3), ip_address=line.group(6),date_time=datetime_obj, message = line.group(5))
        logs_entries.append(log)
file.close()
session.bulk_save_objects(logs_entries)
session.add(log)
session.commit()
session.close()
