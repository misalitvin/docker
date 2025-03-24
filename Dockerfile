FROM php:8.1-fpm-alpine AS builder

WORKDIR /var/www/html

COPY . /var/www/html/

RUN mkdir -p /var/www/html/storage && chown -R www-data:www-data /var/www/html/storage

FROM php:8.1-fpm-alpine

COPY --from=builder /var/www/html /var/www/html

RUN mkdir -p /var/www/html/storage && chown -R www-data:www-data /var/www/html/storage

WORKDIR /var/www/html

VOLUME /var/www/html/storage

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]
