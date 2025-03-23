FROM php:8.1-fpm-alpine AS builder

RUN apk update && apk add --no-cache nginx && rm -rf /var/cache/apk/*

WORKDIR /var/www/html

COPY . /var/www/html/

RUN mkdir -p /var/www/html/storage && chown -R www-data:www-data /var/www/html/storage

FROM php:8.1-fpm-alpine

RUN apk update && apk add --no-cache nginx && rm -rf /var/cache/apk/*

COPY --from=builder /var/www/html /var/www/html

COPY default.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html/storage && chown -R www-data:www-data /var/www/html/storage

WORKDIR /var/www/html

EXPOSE 80

CMD nginx -g 'daemon off;' & php-fpm
