defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
echo "$defined_envs"
envsubst "$defined_envs" < "/utils/nginx.conf.template" > "/tmp/nginx.conf"
mkdir -p /home/container/_serwer_www/publiczny
nginx -c '/tmp/nginx.conf' -g 'daemon off;'
