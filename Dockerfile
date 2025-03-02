# Use the official WordPress image as a base image
FROM wordpress:latest

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions for Composer
RUN docker-php-ext-install pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Set the working directory
WORKDIR /var/www/html