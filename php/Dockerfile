FROM php:5.6-fpm

COPY php.ini /usr/local/etc/php/

RUN apt-get update \
    && apt-get -y install \
            libpcre3-dev \
            gcc \
            make \
            libssl-dev \ 
            libxml2-dev \
            flex \
            libbison-dev \
            bison \
            re2c \
            php5-dev \
            git \
            --no-install-recommends

RUN docker-php-ext-install \
            xml \
            dom 

RUN pecl install mongo \   
    && cd /tmp && curl -sL https://github.com/facebookarchive/xhp-php5-extension/archive/master.tar.gz | tar xz \
      && cd xhp-php5-extension-master/ \
      && phpize \
      && ./configure \
      && make \
      && make install \
    && docker-php-ext-enable \ 
            mongo.so \
            xhp.so \
    && rm -r /var/lib/apt/lists/* 

RUN cd /tmp \
    && git clone --depth=1 git://github.com/phalcon/cphalcon.git \
    && cd cphalcon/build \
    && ./install \
    && docker-php-ext-enable phalcon.so

ENV PHPREDIS_VERSION=2.2.7
RUN cd /usr/src/php/ext \
    && curl -q https://codeload.github.com/phpredis/phpredis/tar.gz/$PHPREDIS_VERSION | tar -xz \
    && docker-php-ext-install phpredis-$PHPREDIS_VERSION

WORKDIR /var/www
