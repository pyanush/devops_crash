FROM python:3.8

WORKDIR "/app/"

COPY logParser.py /app/

RUN pip3 install --upgrade pip && pip3 install pandas workbook openxl -r /app/

CMD ["python3", "logParser.py"]