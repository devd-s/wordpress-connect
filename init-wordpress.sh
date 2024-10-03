#!/bin/bash
set -e

# Wait for the database to be ready
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    echo "Waiting for database connection..."
    sleep 2
done

# Check if the database exists
if ! mysql -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "USE $WORDPRESS_DB_NAME"; then
    echo "Database does not exist. Creating..."
    mysql -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "CREATE DATABASE $WORDPRESS_DB_NAME"
    echo "Database created."
else
    echo "Database already exists."
fi

# Start Apache in foreground
apache2-foreground
