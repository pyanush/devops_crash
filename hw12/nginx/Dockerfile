FROM debian:buster-slim

COPY . /opt
WORKDIR /opt/app
VOLUME /opt/app

RUN apt-get update && apt-get install -y \
  nginx \
  && rm -rf /var/lib/apt/lists/*

COPY custom.conf /etc/nginx/conf.d/

EXPOSE 80

CMD ["nginx","-g","daemon off;"]