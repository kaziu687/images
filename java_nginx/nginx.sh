mkdir -p /home/container/_serwer_www/publiczny

cp /utils/nginx.conf.template /tmp/nginx.conf

if [ ! -f /home/container/_serwer_www/config.json ]; then
    echo "{\"port\":30000}" > /home/container/_serwer_www/config.json
fi

port=$(jq '.port | tonumber' /home/container/_serwer_www/config.json)
sed -i "s/{PORT}/${port}/g" /tmp/nginx.conf

nginx -c '/tmp/nginx.conf' -g 'daemon off;'
