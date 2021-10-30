#!/bin/bash

# TODO: Remove
printf "\033[1m\033[31m[Serwer WWW]: UWAGA: Funkcjonalność serwera WWW jest jeszcze w trakcie testów i może nie działać prawidłowo\033[0m\n"
mkdir -p /home/container/_serwer_www/publiczny

cp /utils/nginx.conf.template /tmp/nginx.conf

if [ ! -f /home/container/_serwer_www/config.json ]; then
    {
      echo "{"
      echo "  \"_UWAGA\": \"Nie usuwaj oraz nie wprowadzaj zmian w tym pliku. Jeśli chcesz skonfigurować serwer WWW na swojej usłudze hostingu przejdź do ustawień.\","
      echo "  \"port\": 30080"
      echo "}"
    } >> /home/container/_serwer_www/config.json
fi

port=$(jq '.port | tonumber' /home/container/_serwer_www/config.json)
if [[ -z "$port" || ${port} == 30080 ]]; then
    printf "\033[1m\033[31m[Serwer WWW]: Port serwera nie został prawidłowo ustawiony, więc nie został on uruchomiony\033[0m\n"
    printf "\033[1m\033[31m[Serwer WWW]: Konfigurację serwera WWW znajdziesz w ustawieniach usługi\033[0m\n"
    printf "\033[1m\033[31m[Serwer WWW]: Jak uruchomić serwer WWW dowiesz się z naszego poradnika:\033[0m\n"
    printf "\033[1m\033[31m[Serwer WWW]: \033[36mhttps://bedrockhost.pl/w/docs/panel/zarzadzanie-plikami/jak-uruchomic-serwer-www-na-hostingu/\033[0m\n"
    exit 1
fi
sed -i "s/{PORT}/$port/g" /tmp/nginx.conf

printf "\033[1m\033[33m[Serwer WWW]: \033[0mUruchamianie serwera na porcie %s...\033[0m\n" "$port"
nginx -t
nginx -c '/tmp/nginx.conf' -g 'daemon off;'
