FROM php:8.3-apache

# System dependencies & python3/pip for gdown tool
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libzip-dev unzip git python3 python3-pip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip opcache

# Install gdown to handle Google Drive downloads cleanly
RUN pip3 install --break-system-packages gdown

RUN a2enmod rewrite

WORKDIR /var/www/html

# Download zip file directly from Google Drive using File ID
RUN gdown 1BOXpywwEauerR1RGZpoFpC_ZkcE74rkc -O fossbilling.zip \
    && unzip -o fossbilling.zip \
    && rm fossbilling.zip

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
