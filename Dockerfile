FROM php:8.1-fpm-alpine AS builder

WORKDIR /var/www/html

COPY . /var/www/html/

RUN mkdir -p /var/www/html/storage && chown -R www-data:www-data /var/www/html/storage

FROM php:8.1-fpm-alpine

COPY --from=builder /var/www/html /var/www/html

#Installed necessary PHP extensions
RUN apk update && apk add --no-cache \
    libzip-dev \
    zip \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip pdo pdo_mysql && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /var/www/html/storage && chown -R www-data:www-data /var/www/html/storage

WORKDIR /var/www/html

VOLUME /var/www/html/storage

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]
