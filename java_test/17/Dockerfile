FROM        --platform=$BUILDPLATFORM ghcr.io/pterodactyl/yolks:java_17

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ../test.sh /utils/test.sh

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
