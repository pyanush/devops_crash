FROM python
WORKDIR "/app/"
COPY core.py logfile.log requirements.txt /app/
RUN pip3 install --upgrade pip && pip3 install -r /app/requirements.txt
ENTRYPOINT ["python3", "core.py"]
CMD ["core.py"]
