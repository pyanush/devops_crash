FROM python:3.9-rc-slim

WORKDIR /app/

VOLUME ./app/

COPY import.txt ./

RUN pip3 install --upgrade pip \
    --no-cache-dir -r import.txt
     
COPY logParser.py /app/

COPY ./app/logfile.log /app/logfile.log

CMD ["python3", "logParser.py"]