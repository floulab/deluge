FROM floulab/ubuntu-ansible
MAINTAINER Ioannis Angelakopoulos <ioagel@gmail.com>

#install deluge
RUN add-apt-repository ppa:deluge-team/ppa && \
    apt-get update -q && \
    apt-get install -qy deluged deluge-web && \
    apt-get clean

ADD playbook.yml /srv
ADD start.sh /srv
WORKDIR /srv

RUN ansible-playbook playbook.yml

VOLUME /var/lib/deluge

# torrent port
EXPOSE 55100
EXPOSE 55100/udp
# WebUI
EXPOSE 8112

USER media

CMD ["/start.sh"]
