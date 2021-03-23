FROM debian

COPY . /opt/

RUN apt-get update && apt-get install -y \
  nginx \
  && rm -rf /var/lib/apt/lists/*

COPY custom.conf /etc/nginx/conf.d/

EXPOSE 80

CMD ["nginx","-g","daemon off;"]