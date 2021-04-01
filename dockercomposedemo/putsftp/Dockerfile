FROM alpine
RUN apk add --update bash openssh sshpass
COPY putsftp.sh /
COPY putpassfile /
CMD ["bin/sh", "/putsftp.sh"]

