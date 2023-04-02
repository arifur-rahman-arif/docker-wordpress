FROM php:8.0.24RC1-fpm-alpine3.16

RUN apk update && apk upgrade

RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql

RUN apk add --update linux-headers \ 
    && apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
	&& pecl install xdebug-3.0.4 \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host = docker.for.mac.localhost" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini


COPY ./php/php.ini /usr/local/etc/php/

RUN ln -s /usr/local/etc/php/php.ini /usr/local/etc/php/conf.d/docker-php.ini

COPY ./wordpress/ /usr/share/nginx/html

RUN chmod 777 -R /usr/share/nginx/html

WORKDIR /usr/share/nginx/html

RUN chown -R www-data:www-data /usr/share/nginx/html \
    && chmod -R 775 /usr/share/nginx/html \
    && chown -R www-data:www-data /var/log

# Add the wp-cli support in the container
RUN apk add --no-cache bash \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && wp --allow-root --version