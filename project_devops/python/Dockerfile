FROM python:3.9-rc-slim

WORKDIR /app/

VOLUME /app/

COPY logParser.py /app/

COPY ./upload/ /app/

RUN pip3 install --upgrade pip \
    && pip3 install pandas \
    && pip3 install workbook \
    && pip3 install openpyxl  

CMD ["python3", "logParser.py"]