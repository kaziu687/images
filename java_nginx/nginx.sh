#defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
#envsubst "$defined_envs" < "/utils/templates/nginx.conf.template" > "/etc/nginx/sites-enabled/serwer-www"
mkdir -p /home/container/_serwer-www/publiczny
nginx -c '/utils/nginx.conf' -tg 'daemon off;'
