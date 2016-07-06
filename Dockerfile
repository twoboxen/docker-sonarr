FROM debian:wheezy
MAINTAINER twoboxen <hawkins22gmail.com>

# mono 3.10 currently doesn't install in debian jessie due to libpeg8 being removed.

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC \
  && echo "deb http://apt.sonarr.tv/ master main" | tee -a /etc/apt/sources.list \
  && apt-get update -q \
  && apt-get install -qy nzbdrone mediainfo \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8989
EXPOSE 9898
VOLUME /volumes/config
VOLUME /volumes/media
VOLUME /volumes/blackhole

ADD develop/start.sh /
RUN chmod +x /start.sh

ADD develop/sonarr-update.sh /sonarr-update.sh

WORKDIR /opt/NzbDrone

ENTRYPOINT ["/start.sh"]
