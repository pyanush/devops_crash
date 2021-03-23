FROM ubuntu:focal
RUN mkdir /opt/app
WORKDIR /opt/app
COPY run.sh /opt/app
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
VOLUME /opt/app

# RUN apt-get update -y && \
# apt-get install vsftpd -y && \
# apt-get install ftp -y && \
# apt-get install openssh-server sudo -y && \
# apt-get install sshpass -y && \
# apt-get install systemd -y && \
# apt-get install firewalld -y

RUN apt-get update && apt-get install -y \
	openssh-server \
	mcrypt \
	&& mkdir /var/run/sshd \
	&& chmod 0755 /var/run/sshd \
	&& mkdir -p /data/incoming \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& mkdir /ssh/

ADD start.sh /opt/app/start.sh

CMD ["/bin/bash", "/opt/app/start.sh"]

EXPOSE 223
ENTRYPOINT ["/bin/bash", "run.sh"]
#sudo docker run -itd --rm -p 223:223 -v $(pwd):/opt/app ftp