FROM        --platform=$BUILDPLATFORM ghcr.io/pterodactyl/yolks:java_16

USER        root
RUN         apt update \
            && apt -y --no-install-recommends install cron

COPY        ./../cron_script.sh /etc/cron.d/cron_script
COPY        ./../cron_executor.sh /utils/cron_executor.sh
RUN         chmod 0644 /etc/cron.d/crontab_script \
            && chmod 0744 /utils/cron_executor.sh

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

RUN         crontab /etc/cron.d/crontab_script

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
