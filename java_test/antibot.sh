if [[ ${IBC_CHECKBOX_INTERNAL_LOBBY} == "true" ]]; then
    mkdir -p /home/container/dodatkowe-lobby/plugins
    cd /home/container/dodatkowe-lobby/plugins || exit 1
    curl -LSo AntiBot.jar https://github.com/PanSzelescik/images/raw/main/java_test/AntiBot.jar
    cd /home/container/dodatkowe-lobby || exit 1
    curl -LSo flamecord.jar https://github.com/PanSzelescik/images/raw/main/java_test/flamecord.jar

    INTERNAL_LOBBY_PORT=$SERVER_PORT
    SERVER_PORT=25565

    if [ ! -f /home/container/dodatkowe-lobby/config.yml ]; then
        echo -e "listeners:\r- host: 0.0.0.0:${INTERNAL_LOBBY_PORT}\r  query_enabled: true\r  query_port: ${INTERNAL_LOBBY_PORT}\r  motd: 'Serwer hostowany przez §aBedrock§fHost.pl'" > /home/container/dodatkowe-lobby/config.yml
    else
        sed -e "s/query_port: \([0-9]\+\)/query_port: $INTERNAL_LOBBY_PORT/g" -e "s/host: 0.0.0.0:\([0-9]\+\)/host: 0.0.0.0:$INTERNAL_LOBBY_PORT/g" config.yml > bh_config.yml
        mv bh_config.yml config.yml
    fi

    printf "\033[1m\033[33m[BedrockHost.pl - AntiBot]: \033[0mUruchamianie AntiBota...\n"
    java -Xms128M -Xmx512M -jar flamecord.jar
    cd /home/container || exit 1
fi
