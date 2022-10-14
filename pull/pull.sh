#!/bin/bash

# -- Variables --

# DB:
WORDPRESS_DB_HOST="$1"
WORDPRESS_DB_USER="$2"
WORDPRESS_DB_PASSWORD="$3"
WORDPRESS_DB_NAME="$4"
ENC_KEY="$5"

# -- DB --

cd /var/www/html/db-git/

git pull origin main

# Decrypt

echo $ENC_KEY | openssl aes-256-cbc -a -salt -pbkdf2 -d -in $WORDPRESS_DB_NAME.sql.enc -out $WORDPRESS_DB_NAME.sql -pass stdin

# Testing backup

# mysqldump -h $WORDPRESS_DB_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME --hex-blob --default-character-set=utf8 --add-drop-database  --databases > $WORDPRESS_DB_NAME.BKP.sql

# Restore

mysql -h $WORDPRESS_DB_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME < $WORDPRESS_DB_NAME.sql

# Fix URLs

cd /var/www/html/

CURRENT_URL=$(wp option get siteurl --allow-root)

if [ $CURRENT_URL != $SITE_URL ]; then
    wp search-replace $CURRENT_URL $SITE_URL --allow-root
    wp rewrite flush --allow-root
fi

sleep 3s

# -- Files --

git pull