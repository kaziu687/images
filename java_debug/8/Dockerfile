FROM        --platform=$BUILDPLATFORM ghcr.io/pterodactyl/yolks:java_8

RUN         apt update \
            && apt install cron

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]