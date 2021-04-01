FROM python:slim
WORKDIR "/app/"
COPY parser.py req.txt /app/
RUN pip3 install --upgrade pip && pip3 install -r /app/req.txt
CMD ["python3", "parser.py"]
