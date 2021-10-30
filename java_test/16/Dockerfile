FROM        --platform=$BUILDPLATFORM ghcr.io/pterodactyl/yolks:java_16

USER        root
COPY        ../antibot.sh /utils/antibot.sh
RUN         chmod 0755 /utils/antibot.sh

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
