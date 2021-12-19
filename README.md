# Snapcast Docker Image

[![Build Image using Containerfile](https://github.com/lukashass/snapcast/actions/workflows/build.yml/badge.svg)](https://github.com/lukashass/snapcast/actions/workflows/build.yml)

A docker image containing [Snapcast](https://github.com/badaix/snapcast) (__only the server__) with librespot support

## Deployment example

docker-compose.yml

```yml
version: '3'

services:
  server:
    image: ghcr.io/lukashass/snapcast
    restart: always
    ports:
      - 1704:1704
      - 1705:1705
      - 1780:1780
    # use `network_mode: host` for easy network discovery
    volumes:
      - ./mopidyfifo:/tmp/mopidyfifo
      - ./config:/root/.config/snapserver
      - ./snapserver.conf:/etc/snapserver.conf
    command: snapserver
```

snapserver.conf

```conf
[stream]
stream = pipe:///tmp/mopidyfifo?name=Mopidy&sampleformat=48000:16:2
stream = librespot://librespot?name=Spotify&dryout_ms=2000&devicename=Multiroom&autoplay=true

[http]
doc_root = /usr/share/snapserver/snapweb

[logging]
filter = *:warning
```
