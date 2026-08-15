FROM php:8.2-apache

# Install required system tools & extensions
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libzip-dev unzip git curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip opcache

RUN a2enmod rewrite

WORKDIR /var/www/html

# Download FOSSBilling latest release directly following redirects (-sSL)
RUN curl -sSL https://github.com/FOSSBilling/FOSSBilling/releases/latest/download/FOSSBilling.zip -o FOSSBilling.zip \
    && unzip -o FOSSBilling.zip \
    && rm FOSSBilling.zip

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
