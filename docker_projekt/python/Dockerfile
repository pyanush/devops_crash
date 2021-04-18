FROM python:slim

WORKDIR /app/

COPY import.txt  /app/

RUN pip3 install --upgrade pip \
    && pip3 install --no-cache-dir -r import.txt

COPY logparser.py /app/

COPY ./app/logfile.log /app/

VOLUME /upload/
ENTRYPOINT [ "python3", "logparser.py" ]
