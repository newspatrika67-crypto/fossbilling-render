FROM php:8.3-apache

# Install required packages for intl, bz2, and imagick
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libzip-dev unzip git curl \
    libicu-dev libbz2-dev libmagickwand-dev python3 python3-pip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip opcache intl bz2 \
    && pecl install imagick \
    && docker-php-ext-enable imagick

# Install gdown tool
RUN pip3 install --break-system-packages gdown

RUN a2enmod rewrite

WORKDIR /var/www/html

# Download zip file from Google Drive
RUN gdown 1BOXpywwEauerR1RGZpoFpC_ZkcE74rkc -O fossbilling.zip \
    && unzip -o fossbilling.zip \
    && rm fossbilling.zip

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html

EXPOSE 80
