FROM python:3.6.9
RUN mkdir /opt/app
WORKDIR /opt/app
COPY req.txt /opt/app
#COPY sql_orm.py /opt/app
COPY sql_core.py /opt/app
#COPY logfile.log /opt/app
RUN pip install --upgrade pip && pip install -r req.txt
#RUN pip install pandas sqlalchemy openpyxl
VOLUME /opt/app
ENTRYPOINT ["python", "sql_orm.py", "logfile.log"]
EXPOSE 5050
#sudo docker run -itd --rm -p 5050:5050 -v $(pwd):/opt/app python
