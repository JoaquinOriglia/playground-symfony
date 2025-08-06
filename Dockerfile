ARG PHP_VERSION=8.4

ARG DEBIAN_VERSION=bookworm

FROM php:${PHP_VERSION}-fpm-${DEBIAN_VERSION} AS my_image

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libxml2-dev \
    libpng-dev \
    libonig-dev \
    libicu-dev \
    libpq-dev \
    build-essential \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_pgsql intl opcache zip

COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

#COPY composer.json composer.lock ./

#RUN composer install

COPY . .

EXPOSE 9000

CMD ["php-fpm"]
