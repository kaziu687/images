FROM        --platform=$BUILDPLATFORM ghcr.io/pterodactyl/yolks:java_8

USER        root
RUN         apt update \
            && apt -y --no-install-recommends install cron

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../cron_executor.sh /utils/cron_executor.sh
RUN         chmod 0777 /utils/cron_executor.sh

COPY        ./../cron_script.sh /utils/cron_script.sh
RUN         chmod 0777 /utils/cron_script.sh

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
