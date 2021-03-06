#!/usr/bin/env bash

NGINX_DEFAULT="usr/local/openresty/nginx/conf";
FILENAME=${NGINX_DEFAULT}"/nginx.conf"

> ${FILENAME}

OUTPUT="$(aws secretsmanager get-secret-value --secret-id pbadmin | jq -r '.SecretString')"
KEYS="$(echo ${OUTPUT} | jq -r 'keys | .[]')"

for VARIABLE in ${KEYS}
do
	echo "env" ${VARIABLE}"="$(echo ${OUTPUT} | jq -r '.'${VARIABLE})";" >> ${FILENAME}
done

echo "include nginxdefault.conf;" >> ${FILENAME}
