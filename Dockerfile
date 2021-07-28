FROM php:7.4.9-apache-buster
RUN apt-get update && apt-get install -y libpq-dev curl libcurl4-openssl-dev libxml2-dev zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev openssl zip unzip git libonig-dev libtidy-dev libzip-dev nano
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install curl dom gd mbstring pdo pdo_mysql pdo_pgsql pgsql simplexml soap tidy zip
RUN a2enmod rewrite
RUN mkdir /app
RUN a2dissite 000-default.conf default-ssl.conf
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default.conf