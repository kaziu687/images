FROM        --platform=$BUILDPLATFORM ghcr.io/pterodactyl/yolks:java_11

USER        root
RUN         apt update \
            && apt -y --no-install-recommends install cron

COPY        ./../cron_executor.sh /utils/cron_executor.sh
RUN         chmod 0755 /utils/cron_executor.sh

COPY        ./../cron_script.sh /etc/cron.d/cron_script.sh
RUN         chmod 0755 /etc/cron.d/cron_script.sh

RUN         crontab /etc/cron.d/cron_script.sh \
            && systemctl enable crond

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
