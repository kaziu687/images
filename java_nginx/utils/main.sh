#!/bin/bash

settings_path="/home/container/_bedrockhost"
config_path="$settings_path/config.json"
uwaga="Nie usuwaj oraz nie wprowadzaj zmian w tym pliku. Jeśli chcesz skonfigurować serwer WWW na swojej usłudze hostingu przejdź do ustawień."

if [ -f "$settings_path" ]; then
    jq -n --arg uwaga "$uwaga" '. + {_UWAGA:$uwaga}' > $config_path
elif [ "$(jq '._UWAGA' "$config_path")" != "$uwaga" ]; then
    jq --arg uwaga "$uwaga" '. + {_UWAGA:$uwaga}' $config_path > /tmp/bh_config.json
    mv /tmp/bh_config.json "$config_path"
fi

### MODULES

# SERWER WWW
if [ -d "$settings_path/serwer_www" ]; then
    /utils/./serwer_www.sh &
fi
# SERWER WWW
