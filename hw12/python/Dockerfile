FROM python:3.8-slim
EXPOSE 5050
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

# COPY app.py /opt/app/app.py
# #CMD ["python", "/opt/app/app.py"]
