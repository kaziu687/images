FROM        --platform=$BUILDPLATFORM ghcr.io/pterodactyl/yolks:java_8 AS java
FROM        nginx:latest

RUN         apt-get update -y \
            && apt-get install -y curl ca-certificates openssl git tar sqlite3 fontconfig tzdata iproute2 libstdc++6 bzip2 unzip xz-utils fontconfig libfreetype6 ca-certificates p11-kit jq \
            && rm -rf /var/lib/apt/lists/* \
            && useradd -d /home/container -m container

COPY        --from=java /usr/local/openjdk-8 /usr/local/openjdk-8
ENV         JAVA_HOME /usr/local/openjdk-8
ENV         PATH $JAVA_HOME/bin:$PATH

COPY        ../utils/bedrockhost_utils.sh /utils/bedrockhost_utils.sh
RUN         chmod 0777 /utils/bedrockhost_utils.sh

COPY        ../utils/serwer_www/nginx.sh /utils/serwer_www.sh
RUN         chmod 0777 /utils/serwer_www.sh
COPY        ../utils/serwer_www/nginx.conf /utils/nginx.conf.template

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
