# Snapcast Docker Image

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/lukashass/snapcast)
![Docker Pulls](https://img.shields.io/docker/pulls/lukashass/snapcast)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/lukashass/snapcast/latest)

## Deployment example

docker-compose.yml

```yml
version: '3'

services:
  server:
    image: lukashass/snapcast
    restart: always
    ports:
      - 1704:1704
      - 1705:1705
    volumes:
      - ./mopidyfifo:/tmp/mopidyfifo
      - ./config:/root/.config/snapserver
      - ./snapserver.conf:/etc/snapserver.conf
    command: snapserver

  client:
    image: lukashass/snapcast
    restart: always
    privileged: true
    volumes:
      - /dev/snd:/dev/snd
    command: snapclient -h server
```

snapserver.conf

```conf
[stream]
stream = pipe:///tmp/mopidyfifo?name=Mopidy&sampleformat=48000:16:2
```
