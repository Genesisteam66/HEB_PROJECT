#!/bin/bash
set -e

# Wait for PostgreSQL to be ready
if [ ! -z "${POSTGRES_HOST}" ]; then
  until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c '\q'; do
    echo "Waiting for database to be ready..."
    sleep 2
  done
fi

# First run the original Drupal entrypoint script
docker-php-entrypoint

# Enable our custom theme
if [ -f /opt/drupal/vendor/bin/drush ]; then
  echo "Enabling HEB Website theme..."
#   /opt/drupal/vendor/bin/drush -y theme:enable hebwebsite
#   /opt/drupal/vendor/bin/drush -y config-set system.theme default hebwebsite
#   /opt/drupal/vendor/bin/drush cache:rebuild
fi

exec "$@"
