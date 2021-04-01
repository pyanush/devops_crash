FROM python:3.8-slim

WORKDIR opt/app

COPY req.txt ./

RUN python -m pip install --upgrade pip &&  pip install --no-cache-dir -r req.txt

COPY log_pars.py ./

ENTRYPOINT ["python", "log_pars.py"]
