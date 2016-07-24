FROM ubuntu:latest
MAINTAINER Ioannis Angelakopoulos <ioagel@gmail.com>

#Upgrade system
RUN apt-get update && apt-get upgrade -y && apt-get clean

#install deluge
RUN apt-get install -y software-properties-common && \
    add-apt-repository ppa:deluge-team/ppa && \
    apt-get update -q && \
    apt-get install -qy deluged deluge-web && \
    apt-get clean

# ADD playbook.yml /srv
#ADD start.sh /srv
ADD start.sh /usr/local/bin

#set timezone
RUN ln -sf /usr/share/zoneinfo/Europe/Athens /etc/localtime
RUN chmod +x /usr/local/bin/start.sh
#WORKDIR /srv
RUN useradd -m -d /var/lib/deluge -s /bin/bash -u 10000 -g 10000 media
# RUN ansible-playbook playbook.yml

VOLUME /var/lib/deluge

# torrent port
EXPOSE 55100
EXPOSE 55100/udp
# WebUI
EXPOSE 8112

USER media

ENTRYPOINT ["start.sh"]
