# # Use an official PHP image as a parent image
# FROM php:8.2-fpm

# # Install system dependencies and PHP extensions
# RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev libzip-dev \
#     && docker-php-ext-configure gd --with-freetype --with-jpeg \
#     && docker-php-ext-install gd zip \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists/*

# # Set the working directory inside the container
# WORKDIR /var/www/html

# # Copy the current directory contents into the container at /var/www/html
# COPY . .

# # Install Composer
# RUN curl -sS https://getcomposer.org/installer | php \
#     && mv composer.phar /usr/local/bin/composer

# # Install PHP dependencies
# RUN composer install

# # Expose port 8000 for the Laravel application
# EXPOSE 8000

# # Run the Laravel development server
# CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]


# Use an official PHP image as a parent image
FROM php:8.2-fpm

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy the current directory contents into the container at /var/www/html
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Install PHP dependencies
RUN composer install

# Set proper permissions for storage and bootstrap/cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 9000 for the PHP-FPM server
EXPOSE 9000

# Run the PHP-FPM server
CMD ["php-fpm"]
