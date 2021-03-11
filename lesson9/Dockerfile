FROM python:3.8
RUN mkdir /opt/app
WORKDIR /opt/app
COPY mywork.py  /opt/app
COPY logfile.log /opt/app
COPY requirements.txt /opt/app

RUN pip install -r requirements.txt
VOLUME /opt/app
CMD ["python","mywork.py","logfile.log"]
