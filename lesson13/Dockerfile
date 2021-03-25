FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y curl
COPY ./script1.sh /usr/bin/script1.sh
VOLUME /home/testuser/MyProject/lesson/log/
ENTRYPOINT [ "script1.sh" ]
 
CMD ["Finished!"]
