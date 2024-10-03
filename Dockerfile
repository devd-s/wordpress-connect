FROM wordpress:latest

# Install MySQL client
RUN apt-get update && apt-get install -y default-mysql-client && rm -rf /var/lib/apt/lists/*

# Install any additional PHP extensions if needed
RUN docker-php-ext-install pdo pdo_mysql

# Copy wp-config.php
COPY wp-config.php /var/www/html/

# Copy initialization script
COPY init-wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init-wordpress.sh

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Set the entrypoint
ENTRYPOINT ["init-wordpress.sh"]
