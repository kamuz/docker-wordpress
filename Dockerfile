# Use the official WordPress image as a base image
FROM wordpress:latest

# Set your user name, ex: user=kamuz
ARG user=kamuz
ARG uid=1000

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

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

RUN groupadd webdev && \
    usermod -aG webdev www-data && \
    usermod -aG webdev root && \
    usermod -aG webdev kamuz && \
    chown -R :webdev . && \
    find . -type d -exec chmod 755 {} \;  && \
    find . -type f -exec chmod 644 {} \;


# Set the working directory
WORKDIR /var/www/html
