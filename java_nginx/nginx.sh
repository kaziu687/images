#!/bin/bash

mkdir -p /home/container/_serwer_www/publiczny

cp /utils/nginx.conf.template /tmp/nginx.conf

if [ ! -f /home/container/_serwer_www/config.json ]; then
    echo "{\"port\":30000}" > /home/container/_serwer_www/config.json
fi

port=$(jq '.port | tonumber' /home/container/_serwer_www/config.json)
if [ ! $? ]; then
    printf "\033[1m\033[31m[BedrockHost.pl]: Nie można odczytać portu serwera WWW!\n"
    exit 1
fi
sed -i "s/{PORT}/$port/g" /tmp/nginx.conf

printf "\033[1m\033[33m[BedrockHost.pl]: \033[0mUruchamianie serwera WWW na porcie %s...\n" "$port"
nginx -c '/tmp/nginx.conf' -g 'daemon off;'
