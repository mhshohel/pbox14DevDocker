FROM php:5.5.38-apache

#If want to change PORT
#COPY ./etc/apache2/ports.conf /etc/apache2/ports.conf
#COPY ./etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf

ENV APACHE_DOCUMENT_ROOT /var/www/html/pbox14

RUN apt-get update && \
	apt-get -y install sudo && \
	apt-get -y install git && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
	sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf && \
	sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf && \
	ln -sf /dev/stdout /var/log/apache2/access.log && \
	ln -sf /dev/stderr /var/log/apache2/error.log && \
	docker-php-ext-install mysqli && \
	docker-php-ext-install pdo pdo_mysql && \
	docker-php-ext-install mbstring

# Need to change folder permission in the server to 1000 and run it to change container's
# folder permission to www-data
RUN usermod -u 1000 www-data
#RUN usermod -G root www-data