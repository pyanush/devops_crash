from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base

engine = create_engine('sqlite:///access_logs.db', echo = True)


Base = declarative_base()
class LogEntry(Base):
	__tablename__ = 'access_logs'
	id = Column(Integer, primary_key=True)
	hostname = Column(String)
	ip_address = Column(String)
	date_time = Column(DateTime)
	message = Column(String)
Base.metadata.create_all(engine)


from sqlalchemy.orm import sessionmaker
Session = sessionmaker(bind = engine)
session = Session()


log = LogEntry(hostname=line.group(3), ip_address=line.group(6),
  date_time=datetime_obj, message = line.group(5))
session.add(log)
session.commit()


logs_entries = []
session.bulk_save_objects(logs_entries)
session.commit()
session.close()
