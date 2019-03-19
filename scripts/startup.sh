#!/bin/sh
echo $GIT_DEPLOY_KEY_BASE64 | base64 -d > /root/.ssh/id_rsa

chmod 600 /root/.ssh/id_rsa

cd /usr/share/nginx/html

git clone $GIT_REPO .

rm /root/.ssh/id_rsa

if [ -z "$NGINX_HTPASSWD_BASE64" ]
then # Do not configure basic auth
  touch /etc/nginx/basic-auth.conf;
else
  echo "auth_basic \"Restricted\";" > /etc/nginx/basic-auth.conf;
  echo "auth_basic_user_file /usr/share/nginx/html/basic-auth;" >> /etc/nginx/basic-auth.conf;
  echo "$NGINX_HTPASSWD_BASE64" | base64 -d > /usr/share/nginx/html/basic-auth;
fi

echo "Nginx webserver running!"
exec nginx -g 'daemon off;'
