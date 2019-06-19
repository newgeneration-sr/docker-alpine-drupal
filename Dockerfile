FROM dotriver/alpine-s6

ENV DATABASE_HOST=localhost \
    DATABASE_PORT=3306 \
    DRUPAL_DB_NAME=drupal \
    DRUPAL_DB_USERNAME=drupal \
    DRUPAL_DB_PASSWORD=password \
    ADMIN_USERNAME=admin \
    ADMIN_PASSWORD=password \
    ADMIN_EMAIL=admin@exemple.org \
    SITE_NAME="drupal" \
    TRUSTED_HOST=localhost

RUN set -x \
    && apk update \
    && apk add --no-cache \
        mysql-client \
        git \
        composer \
        php7 \
        php7-fpm \
        php7-imagick \
        php7-ldap \
        php7-dom \
        php7-gd \
        php7-json \
        php7-mysqli \
        php7-opcache \
        php7-pdo \
        php7-pdo_mysql \
        php7-session \
        php7-simplexml \
        php7-tokenizer \
        php7-xml \
        php7-xmlwriter \
        php7-ctype \
        php7-curl \
        php7-zip \
        php7-fileinfo \
        nginx \
        memcached \
        php7-memcached \
    && rm /etc/nginx/conf.d/default.conf \
    && mkdir /run/nginx \
    && rm -R /var/www/* || true \
    && chown nginx:nginx /run/nginx


RUN mkdir -p /opt/ressources/ \
    && composer create-project drupal-composer/drupal-project:7.x-dev /opt/ressources/drupal --prefer-dist --no-interaction --no-dev  --quiet



ADD conf/ /

RUN set -x \
    && chmod +x /etc/cont-init.d/* \
    && chmod +x /etc/s6/services/*/* \
    && chmod +x /etc/periodic/*/*
