FROM php:8.0.24RC1-fpm-alpine3.16

RUN apk update && apk upgrade

RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql

RUN apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
	&& pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host = host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
	&& echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20200930/xdebug.so" >> /usr/local/etc/php/php.ini

ADD php/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

COPY ./wordpress/ /usr/share/nginx/html

WORKDIR /usr/share/nginx/html

RUN chown root:root -R /usr/share/nginx/html \
    && chmod 777 -R /usr/share/nginx/html \
    && chown www-data -R /var/log

# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp