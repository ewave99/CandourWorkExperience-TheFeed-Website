FROM php:8.0-apache

# Install Required Depedencies
RUN apt-get update && apt-get install -y --force-yes \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    imagemagick \
    libmagickwand-dev \
    libexif-dev \
    ssl-cert \
    build-essential \
    libzip-dev \
    supervisor \
    wget \
    git

RUN mkdir -p /usr/src/php/ext/imagick \
    && git clone https://github.com/Imagick/imagick.git /usr/src/php/ext/imagick \
    && docker-php-ext-install imagick

RUN mkdir -p /usr/src/php/ext/redis \
    && curl -fsSL https://pecl.php.net/get/redis | tar xvz -C "/usr/src/php/ext/redis" --strip 1 \
    && docker-php-ext-install redis

RUN docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-install -j$(nproc) pdo \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-install -j$(nproc) exif \
    && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Configure PHP & Enabled Apache Modules
COPY .user.ini /usr/local/etc/php/
RUN cat /usr/local/etc/php/.user.ini >> /usr/local/etc/php/php.ini \
    && rm -f /usr/local/etc/php/.user.ini

RUN usermod -u 1000 www-data && chown -R www-data:www-data /var/www
RUN a2enmod rewrite \
    && a2enmod ssl \
    && a2enmod headers \
    && a2enmod expires \
    && a2ensite default-ssl

ENV COMPOSER_HOME=/opt/composer/config
ENV COMPOSER_CACHE_DIR=/opt/composer/cache

RUN mkdir -p /opt/composer/config \
    && mkdir /opt/composer/cache \
    && chown -R www-data:www-data /opt/composer

WORKDIR /var/www

CMD ["apache2-foreground"]
