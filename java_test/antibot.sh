#!/bin/bash

INTERNAL_LOBBY_PORT=$SERVER_PORT

while :
do
    mkdir -p /home/container/dodatkowe-lobby/plugins
    cd /home/container/dodatkowe-lobby/plugins || exit 1
    curl -LSo AntiBot.jar https://github.com/PanSzelescik/images/raw/main/java_test/AntiBot.jar
    cd /home/container/dodatkowe-lobby || exit 1
    curl -LSo flamecord.jar https://github.com/PanSzelescik/images/raw/main/java_test/flamecord.jar

    if [ ! -f config.yml ]; then
        echo -e "listeners:\r" >> config.yml
        echo -e "- host: 0.0.0.0:${INTERNAL_LOBBY_PORT}\r" >> config.yml
        echo -e "  query_enabled: true\r" >> config.yml
        echo -e "  query_port: ${INTERNAL_LOBBY_PORT}\r" >> config.yml
        echo -e "  motd: 'Serwer hostowany przez §aBedrock§fHost.pl\r" >> config.yml
        echo -e "  force_default_server: true\r" >> config.yml
        echo -e "  ping_passthrough: true\r" >> config.yml
        echo -e "  forced_hosts: {}\r" >> config.yml
        echo -e "forge_support: true\r" >> config.yml
        echo -e "ip_forward: true\r" >> config.yml
        echo -e "groups: {}\r" >> config.yml
        echo -e "servers:\r" >> config.yml
        echo -e "  lobby:\r" >> config.yml
        echo -e "    motd: Serwer hostowany przez &aBedrock&fHost.pl\r" >> config.yml
        echo -e "    address: localhost:25565\r" >> config.yml
        echo -e "    restricted: false\r" >> config.yml
    else
        sed -e "s/query_port: \([0-9]\+\)/query_port: ${INTERNAL_LOBBY_PORT}/g" -e "s/host: 0.0.0.0:\([0-9]\+\)/host: 0.0.0.0:${INTERNAL_LOBBY_PORT}/g" config.yml > bh_config.yml
        mv bh_config.yml config.yml
    fi

    if [ ! -f /home/container/server.properties ]; then
        echo -e "server-port=25565\r" >> /home/container/server.properties
        echo -e "query-port=25565\r" >> /home/container/server.properties
    else
        sed -e "s/server-port=.*/server-port=25565/g" /home/container/server.properties > /home/container/bh_server.properties
        sed -e "s/query-port=.*/query-port=25565/g" /home/container/server.properties > /home/container/bh_server.properties
        mv /home/container/bh_server.properties /home/container/server.properties
    fi

    printf "\033[1m\033[33m[BedrockHost.pl - lobby]: \033[0mUruchamianie lokalnego lobby...\n"
    java -Xms128M -Xmx512M -jar flamecord.jar &>/dev/null
done
