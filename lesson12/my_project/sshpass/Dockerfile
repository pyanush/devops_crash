FROM alpine
RUN apk add --update bash openssh sshpass
COPY cont_script.sh /
COPY passfile /
CMD ["bin/sh", "/cont_script.sh"]


