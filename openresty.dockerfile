FROM openresty/openresty:alpine

RUN ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log && \
	ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log

EXPOSE 80 443