#!/usr/bin/env bash

#This is Portfoliobox App Server NGINX Config

#env                                 ENC_ENV_KEY=4V+A-fW7%RpWCb=D;
#env                                 ENC_ENV_IV=F?@Znk?D^f*6M@F$;
#
#include                             /var/www/html/pbox14/nginx/conf/nginx.conf;

NGINX_DEFAULT="usr/local/openresty/nginx/conf";
FILENAME=${NGINX_DEFAULT}"/nginx.conf"

> ${FILENAME}

echo "env ENC_ENV_KEY=4V+A-fW7%RpWCb=D;" >> ${FILENAME}

echo "env ENC_ENV_IV=F?@Znk?D^f*6M@F$;" >> ${FILENAME}

echo "include nginxdefault.conf;" >> ${FILENAME}