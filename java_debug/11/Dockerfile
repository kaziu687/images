FROM        --platform=$BUILDPLATFORM ghcr.io/pterodactyl/yolks:java_11

USER        root
COPY        ./../cron_executor.sh /utils/cron_executor.sh
RUN         chmod 0755 /utils/cron_executor.sh

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
