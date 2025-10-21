# Use the official Drupal 10 image as base
FROM drupal:10-apache

# Install required PHP extensions and tools
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpq-dev \
    postgresql-client  \
    && docker-php-ext-install zip pdo pdo_pgsql  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /opt/drupal

# Copy custom theme files
COPY web/themes/custom/hebwebsite /opt/drupal/web/themes/custom/hebwebsite/

# Set permissions
RUN chown -R www-data:www-data /opt/drupal/web/themes/custom/hebwebsite

# Install drush
RUN composer require drush/drush && \
composer require 'drupal/flexslider:^3.0@alpha' && \
composer require 'drupal/vani:^10.0' && \
composer require 'drupal/material_base:^3.1' && \
composer require 'drupal/xara:^11.0' && \
composer require 'drupal/tara:^11.0' && \
composer require 'drupal/amp:^3.9' && \
composer require 'drupal/juicerio:^2.0' && \
composer require 'drupal/captcha:^2.0' && \
composer require 'drupal/webform:^6.3@beta' && \
composer require 'drupal/calendar_view:^2.1' && \
composer require 'drupal/simple_sitemap:^4.0' && \
composer config --no-plugins allow-plugins.cweagans/composer-patches true && \
composer require 'drupal/event:^2.0@RC' && \
composer require 'drupal/cdn:^4.1'  && \
composer require 'drupal/cognito:^2.1' && \
composer require 'drupal/s3fs:^3.9' && \
composer require 'drupal/flipdown:^1.0' && \
composer require 'drupal/maestro:^4.2'     && \
composer require 'drupal/llms_txt:^1.0'


# Enable the theme using drush (will be run in entrypoint script)
COPY docker-entrypoint-custom.sh /usr/local/bin/
COPY web/sites/default/settings.php /opt/drupal/web/sites/default/settings.php
COPY web/sites/default/files /opt/drupal/web/sites/default/files
RUN chmod +x /usr/local/bin/docker-entrypoint-custom.sh


ENTRYPOINT ["docker-entrypoint-custom.sh"]
CMD ["apache2-foreground"]
