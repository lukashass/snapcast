FROM rust:1.91.1-slim-trixie@sha256:5218a2b4b4cb172f26503ac2b2de8e5ffd629ae1c0d885aff2cbe97fd4d1a409

RUN apt update \
    && apt install -y git libssl-dev pkg-config

WORKDIR /build

RUN git clone https://github.com/librespot-org/librespot.git \
    && cd librespot \
    && git checkout v0.8.0 \
    && cargo build --release --no-default-features --features "native-tls with-libmdns"

FROM debian:trixie-20251117-slim@sha256:18764e98673c3baf1a6f8d960b5b5a1ec69092049522abac4e24a7726425b016

ENV SNAPCAST_VERSION=0.34.0

RUN apt update \
    && apt install -y wget

RUN wget https://github.com/badaix/snapcast/releases/download/v${SNAPCAST_VERSION}/snapserver_${SNAPCAST_VERSION}-1_amd64_trixie.deb

RUN apt install -y ./snapserver_${SNAPCAST_VERSION}-1_amd64_trixie.deb \
    && rm snapserver_${SNAPCAST_VERSION}-1_amd64_trixie.deb

COPY --from=0 /build/librespot/target/release/librespot /usr/local/bin/librespot
