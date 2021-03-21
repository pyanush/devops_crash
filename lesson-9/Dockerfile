FROM python:3.8.5
RUN mkdir -p /opt/app/
WORKDIR /opt/app/
COPY . /opt/app/
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
CMD ["python3","core.py"]
