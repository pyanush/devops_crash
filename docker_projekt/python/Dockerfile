FROM python:slim

WORKDIR /app/

COPY import.txt  /app/

RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r import.txt

COPY logparser.py /app/

COPY ./app/logfile.log /app/

VOLUME /upload/
ENTRYPOINT [ "python", "logparser.py" ]
#CMD ["python", "logparser.py" ]
