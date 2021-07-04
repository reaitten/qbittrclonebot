# qbittrclonebot 🚀

[![Docker Pulls](https://img.shields.io/docker/pulls/rclone/rclone)](https://hub.docker.com/r/guzmi/qbittrclonebot)

This docker container contains the qBittorrent client, Rclone tool and an extra BOT in Python for telegram to which to send the torrents and automatically add them to the qbittorrent client, in order to automate the upload of our downloads to the main cloud servers such as gdrive etc. .

### Pre-requisites 📋
We will only need to have docker installed on our operating system.

## Deployment 📦
The most recommended way to launch this container is the following:

```
docker run \
  --name=qbittorrent \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e UMASK_SET=022 \
  -e WEBUI_PORT=8085 \
  -p 6881:6881 \
  -p 6881:6881/udp \
  -p 8085:8085 \
  -v /tupath/config:/config \
  -v /tupath/downloads:/downloads \
  --restart unless-stopped \
-it guzmi/qbittrclonebot /bin/bash
```
## +info 📖
The version that contains the qBittorrent client is v4.2.1
So that the telgram bot can work and we must edit the bot.py file that is in the / config folder and add the TOKEN ID of our telegram bot in the indicated place, then to qBittorrent in configuration we must configure it as a monitored / config / normal folder /

It is necessary that the folders to which the volumes point have read and write permissions, otherwise rclone will not be able to read and write its configuration file.
