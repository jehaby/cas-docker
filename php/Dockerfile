FROM php:5.6-fpm

RUN apt-get update \
    && apt-get -y install \
            libssl-dev \ 
            libxml2-dev \
            --no-install-recommends \
    && docker-php-ext-install \
            xml \
            dom \
    && pecl install mongo \   
    && docker-php-ext-enable mongo.so \
    && rm -r /var/lib/apt/lists/* 


ENV PHPREDIS_VERSION=2.2.7
RUN cd /usr/src/php/ext \
    && curl -q https://codeload.github.com/phpredis/phpredis/tar.gz/$PHPREDIS_VERSION | tar -xz \
    && docker-php-ext-install phpredis-$PHPREDIS_VERSION

WORKDIR /var/www
