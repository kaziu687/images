defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
envsubst "$defined_envs" < "/utils/templates/nginx.conf.template" > "/etc/nginx/nginx.conf"
cat /etc/nginx/nginx.conf
cat /etc/nginx/conf.d/default.conf
nginx -g 'daemon off;'
