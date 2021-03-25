FROM python:3.8-slim
ENV BIND_PORT 5050
ENV REDIS_HOST redis
ENV REDIS_PORT 6379
EXPOSE $BIND_PORT
WORKDIR /opt/app
VOLUME /opt/app
COPY req.txt /opt/app
RUN pip install --upgrade pip && pip install -r req.txt
COPY sql_orm.py /opt/app
# ENTRYPOINT ["python","ssh.py"]
CMD ["python", "sql_orm.py"]
#sudo docker run -itd --rm -p 5050:5050 -v $(pwd):/opt/app sql

#COPY logfile.log /opt/app

# COPY app.py /opt/app/app.py
