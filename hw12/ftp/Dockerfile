FROM ubuntu
RUN mkdir /opt/app
WORKDIR /opt/app
COPY run.sh /opt/app
VOLUME /opt/app

COPY . /opt/

RUN apt-get update -y && \
apt-get install vsftpd -y && \
apt-get install ftp -y && \
apt-get install sshpass -y && \
apt-get install systemd -y && \
apt-get install firewalld -y


COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE 223
CMD ["/bin/bash", "run.sh"]
