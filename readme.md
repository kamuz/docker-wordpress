# Setup Docker for WordPress projects

Install dependcies and download WordPress:

```
git clone git@github.com:kamuz/docker-wordpress.git wordpress
cd wordpress
docker-compose up -d
docker exec -it wordpress_wordpress_1 bash
```

Run WordPress installation - [http://localhost:8000/](http://localhost:8000/)

Test email:

```
wp plugin install wp-mail-smtp --activate --allow-root

wp config set WPMS_ON true --raw --allow-root
wp config set WPMS_MAILER smtp --allow-root
wp config set WPMS_SMTP_HOST mailhog --allow-root
wp config set WPMS_SMTP_PORT 1025 --allow-root
wp config set WPMS_SSL '' --allow-root
wp config set WPMS_SMTP_AUTH false --raw --allow-root
wp config set WPMS_SMTP_AUTOTLS false --raw --allow-root
wp config set WPMS_SMTP_USER '' --allow-root
wp config set WPMS_SMTP_PASS '' --allow-root

wp eval 'wp_mail("test@example.com", "Test Email", "This is a test email from WordPress.");' --allow-root
```

Check email - [http://localhost:8025/](http://localhost:8025/)

Go to phpMyAdmin (`wordpress/wordpress`) - [http://localhost:8080/](http://localhost:8080/)
