FROM lsiobase/ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG QBITTORRENT_VERSION
LABEL maintainer="guzmi"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config" \
XDG_CONFIG_HOME="/config" \
XDG_DATA_HOME="/config"

# add repo and install qbitorrent
RUN \
 echo "***** add qbitorrent repositories ****" && \
apt-get update && \
 apt-get install -y \
        gnupg \
        python3 \
	python3-pip && \
	python3 -m pip install telegram python-telegram-bot --upgrade && \
 apt-get install -y software-properties-common && \
 apt-get -y update && \
 add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable && \
 echo "**** install packages ****" && \
 if [ -z ${QBITTORRENT_VERSION+x} ]; then \
        QBITTORRENT_VERSION=$(curl -sX GET http://ppa.launchpad.net/qbittorrent-team/qbittorrent-stable/ubuntu/dists/bionic/main/binary-amd64/Packages.gz | gunzip -c \
        |grep -A 7 -m 1 "Package: qbittorrent-nox" | awk -F ": " '/Version/{print $2;exit}');\
 fi && \
 apt-get update && \
 apt-get install -y \
        p7zip-full \
        qbittorrent \
        qbittorrent-nox=${QBITTORRENT_VERSION} \
        unrar \
        geoip-bin \
        unzip && \
        curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
        unzip rclone-current-linux-amd64.zip && \
        cd rclone-*-linux-amd64 && \
        cp rclone /usr/bin/ && \
        chown root:root /usr/bin/rclone && \
        chmod 755 /usr/bin/rclone && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 6881 6881/udp 8085
VOLUME /config /downloads
