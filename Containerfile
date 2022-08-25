FROM rust:1.57.0-slim-buster

RUN apt update \
    && apt install -y git

WORKDIR /build

RUN git clone https://github.com/librespot-org/librespot.git \
    && cd librespot \
    && git checkout v0.4.2 \
    && cargo build --release --no-default-features


FROM debian:bullseye-slim

ENV SNAPCAST_VERSION=0.26.0

RUN apt update \
    && apt install -y wget

RUN wget https://github.com/badaix/snapcast/releases/download/v${SNAPCAST_VERSION}/snapserver_${SNAPCAST_VERSION}-1_amd64.deb

RUN apt install -y ./snapserver_${SNAPCAST_VERSION}-1_amd64.deb \
    && rm snapserver_${SNAPCAST_VERSION}-1_amd64.deb

COPY --from=0 /build/librespot/target/release/librespot /usr/local/bin/librespot
