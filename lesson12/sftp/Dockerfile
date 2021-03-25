FROM ubuntu:16.04

# Steps done in one RUN layer:
# - Install packages (vsftpd, openssh-server)
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN apt-get update && \
    apt-get install vsftpd -y && \
    apt-get -y install openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    mkdir -p /main/inbox

EXPOSE 22

ENTRYPOINT ["/bin/bash", "configure_vsftpd.sh"]
