FROM        --platform=$BUILDPLATFORM openjdk:11-jdk-slim-buster

LABEL       author="PanSzelescik" maintainer="panszelescik@github.com"

LABEL       org.opencontainers.image.authors="PanSzelescik, Michael Parker"
LABEL       org.opencontainers.image.source="https://github.com/PanSzelescik/images"
LABEL       org.opencontainers.image.licenses=MIT

RUN 		apt-get update -y \
 			&& apt-get install -y curl ca-certificates openssl git tar sqlite fontconfig tzdata iproute2 libstdc++6 procps \
 			&& useradd -d /home/container -m container

COPY        ../thread_printer.sh /utils/thread_printer.sh
RUN         chmod 0755 /utils/thread_printer.sh

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
