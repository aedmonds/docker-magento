FROM php:5.5-apache
MAINTAINER David Nuñez <davidn@copiousinc.com>

COPY docker-entrypoint.sh /entrypoint.sh
COPY conf.d/reset-permissions.sh /usr/local/bin/reset-permissions
COPY conf.d/crontab /etc/crontab
COPY conf.d/000-default.conf /etc/apache2/sites-available/

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libpng12-dev \
    libxslt1-dev \
    libz-dev \
    mysql-client \
  && docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) \
    bcmath \
    gd \
    intl \
    mbstring \
    mcrypt \
    opcache \
    pdo_mysql \
    soap \
    xsl \
    zip \
  && pecl install memcached \
  && docker-php-ext-enable memcached \
  && rm -rf /var/lib/apt/lists/* \
  && curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin \
    --filename=composer \
  && curl -L -o /usr/local/bin/magerun \
    http://files.magerun.net/n98-magerun-latest.phar \
  && chmod +x /usr/local/bin/magerun \
  && a2enmod rewrite \
  && a2ensite 000-default

ONBUILD COPY auth.json /var/www/html/
ONBUILD COPY composer.* /var/www/html/
ONBUILD COPY ./magento /var/www/html/magento/
ONBUILD RUN composer install -n \
  && chown -R www-data ./magento \
  && find ./magento -type d -exec chmod 700 {} \; \
  && find ./magento -type f -exec chmod 600 {} \;

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
