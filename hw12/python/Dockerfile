FROM python:3.8-slim
EXPOSE 5050
RUN mkdir /opt/app
WORKDIR /opt/app
VOLUME /opt/app
COPY req.txt /opt/app
RUN pip install --upgrade pip && pip install -r req.txt
COPY sql_orm.py /opt/app
COPY logfile.log /opt/app
ENTRYPOINT ["python", "sql_orm.py", "logfile.log"]


#sudo docker run -itd --rm -p 5050:5050 -v $(pwd):/opt/app sql
#COPY sql_core.py /opt/app


# ENV BIND_PORT 5050
# ENV REDIS_HOST redis
# ENV REDIS_PORT 6379
# EXPOSE $BIND_PORT
#RUN mkdir /opt/app

# COPY app.py /opt/app/app.py

# WORKDIR /opt/app
# VOLUME /opt/app

# COPY req.txt /opt/app
# #COPY sql_orm.py /opt/app
# COPY sql_core.py /opt/app/sql_core.py
# COPY logfile.log /opt/app

# RUN pip install --upgrade pip && pip install -r req.txt

# ENTRYPOINT ["python", "sql_core.py", "logfile.log"]

# #sudo docker run -itd --rm -p 5050:5050 -v $(pwd):/opt/app python
# #CMD ["python", "/opt/app/app.py"]