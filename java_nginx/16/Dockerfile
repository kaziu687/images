FROM        --platform=$BUILDPLATFORM ghcr.io/pterodactyl/yolks:java_16 AS java
FROM        nginx:latest

RUN         apt-get update -y \
            && apt-get install -y curl ca-certificates openssl git tar sqlite3 fontconfig tzdata iproute2 libstdc++6 bzip2 unzip xz-utils fontconfig libfreetype6 ca-certificates p11-kit \
            && rm -rf /var/lib/apt/lists/* \
            && useradd -d /home/container -m container

COPY        --from=java /usr/local/openjdk-16 /usr/local/openjdk-16
ENV         JAVA_HOME /usr/local/openjdk-16
ENV         PATH $JAVA_HOME/bin:$PATH

COPY        ../nginx.sh /utils/nginx.sh
RUN         chmod 0755 /utils/nginx.sh
COPY        ../default.conf.template /etc/nginx/templates/default.conf.template
ENV         NGINX_PORT 35010

RUN         hown -R container:container /var/cache/nginx && \
            chown -R container:container /var/log/nginx && \
            chown -R container:container /etc/nginx/conf.d
RUN         touch /var/run/nginx.pid && \
            chown -R container:container /var/run/nginx.pid

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
