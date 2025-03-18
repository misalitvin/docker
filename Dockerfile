FROM php:8.1-fpm

RUN apt-get update && apt-get install -y --no-install-recommends nginx


COPY default.conf /etc/nginx/sites-available/default

COPY . /var/www/html/

WORKDIR /var/www/html/

EXPOSE 80

CMD service nginx start && php-fpm