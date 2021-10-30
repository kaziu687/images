#!/bin/bash

INTERNAL_LOBBY_PORT=$SERVER_PORT

while :
do
    mkdir -p /home/container/dodatkowe-lobby/plugins
    cd /home/container/dodatkowe-lobby/plugins || exit 1
    curl -Lso AntiBot.jar https://github.com/PanSzelescik/images/raw/main/java_test/AntiBot.jar > /dev/null
    cd /home/container/dodatkowe-lobby || exit 1
    curl -Lso flamecord.jar https://github.com/PanSzelescik/images/raw/main/java_test/flamecord.jar > /dev/null

    if [ ! -f config.yml ]; then
        {
            echo "listeners:\r" >> config.yml
            echo "- host: 0.0.0.0:${INTERNAL_LOBBY_PORT}"
            echo "  query_enabled: true"
            echo "  query_port: ${INTERNAL_LOBBY_PORT}"
            echo "  motd: 'Serwer hostowany przez §aBedrock§fHost.pl"
            echo "  force_default_server: true"
            echo "  ping_passthrough: true"
            echo "  forced_hosts: {}"
            echo "forge_support: true"
            echo "ip_forward: true"
            echo "groups: {}"
            echo "servers:"
            echo "  lobby:"
            echo "    motd: Serwer hostowany przez &aBedrock&fHost.pl"
            echo "    address: localhost:25565"
            echo "    restricted: false"
        } >> config.yml
    else
        sed -e "s/query_port: \([0-9]\+\)/query_port: ${INTERNAL_LOBBY_PORT}/g" -e "s/host: 0.0.0.0:\([0-9]\+\)/host: 0.0.0.0:${INTERNAL_LOBBY_PORT}/g" config.yml > bh_config.yml
        mv bh_config.yml config.yml
    fi

    if [ ! -f /home/container/server.properties ]; then
        echo -e "server-port=25565\r" >> /home/container/server.properties
        echo -e "query-port=25565\r" >> /home/container/server.properties
    else
        sed -e "s/server-port=.*/server-port=25565/g" -e "s/query.port=.*/query.port=25565/g" /home/container/server.properties > /home/container/bh_server.properties
        mv /home/container/bh_server.properties /home/container/server.properties
    fi

    printf "\033[1m\033[33m[BedrockHost.pl - lobby]: \033[0mUruchamianie lokalnego lobby...\n"
    java -Xms128M -Xmx512M -jar flamecord.jar &>/dev/null
done
