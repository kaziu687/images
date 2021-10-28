cat /etc/nginx/nginx.conf
defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
envsubst "$defined_envs" < "/utils/templates/nginx.conf.template" > "/etc/nginx/sites-enabled/serwer-www"
nginx -c -tg 'daemon off;'
