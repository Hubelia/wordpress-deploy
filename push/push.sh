#!/bin/bash

# -- Variables --

# DB:
touch /app/web/wp-content/plugins/wordpress-deploy/deployToProduction
# EXTRA_REGEX="$1"
# WORDPRESS_DB_HOST="$2"
# WORDPRESS_DB_USER="$3"
# WORDPRESS_DB_PASSWORD="$4"
# WORDPRESS_DB_NAME="$5"
# ENC_KEY="$6"

# # General
# GIT_TOKEN="$7"
# SITE_REPO="$8"
# DB_REPO="$9"

# curl -s https://registry.hub.docker.com/v1/repositories/wordpress/tags | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}' > wordpress-tags

# VERSION="${10}"

# if [[ $(grep $VERSION wordpress-tags) == "" ]]
#    then
#          VERSION=""
#    else   
#          VERSION="${10}-"
# fi

# rm wordpress-tags

# # \d+(\.\d+)*
# sed -Ei '' "s|[0-9]+(\.[0-9]+)*-|$VERSION|g" Dockerfile*

# sed -i '' "s|worpress:fpm|wordpress:${VERSION}fpm|g" Alpine.Dockerfile
# sed -i '' "s|wordpress:apache|wordpress:${VERSION}apache|g" Dockerfile

# # -- DB --

# cd /var/www/html/db-git

# # Backup

# # Regex of the tables to include, gets fed into a query to grab them using WHERE REGEXP
# # extra strings can be added if the variable $EXTRA_REGEX is used. 
# # $EXTRA_REGEX format: term1|term2|termN
# # example: image|yoast

# REGEX_STRING='wp_post|wp_comment|wp_term|wp_options|wp_links'
# # Only wp_usermeta and wp_users are excluded from the default tables

# if [[ "${EXTRA_REGEX}" != "noregextra" ]]; then
#    REGEX_STRING="${EXTRA_REGEX}|${REGEX_STRING}"
# fi 

# REGEX_TABLES=($(echo SHOW TABLES WHERE Tables_in_$WORDPRESS_DB_NAME REGEXP \"$REGEX_STRING\"\; | mysql -h $WORDPRESS_DB_HOST -uroot -p$WORDPRESS_DB_PASSWORD -Bs --database=$WORDPRESS_DB_NAME))

 
# REGEX_TABLES_STRING=''
# for TABLE in "${REGEX_TABLES[@]}"
# do :
#    REGEX_TABLES_STRING+=" $WORDPRESS_DB_NAME.${TABLE}"
# done

# mysqldump -h $WORDPRESS_DB_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME --hex-blob --default-character-set=utf8 ${REGEX_TABLES_STRING} > $WORDPRESS_DB_NAME.sql

# # ENC
# echo $ENC_KEY | openssl aes-256-cbc -a -salt -pbkdf2 -in $WORDPRESS_DB_NAME.sql -out $WORDPRESS_DB_NAME.sql.enc -pass stdin

# # PUSH - WIP
# git add $WORDPRESS_DB_NAME.sql.enc
# TZ=":US/Eastern" date +"Pushed via plugin, %R %d/%m/%y" | git -c user.name='Plugin' -c user.email='mohamad@hubelia.com' commit --file - 

# git -c user.name='Plugin' -c user.email='mohamad@hubelia.com' push https://$GIT_TOKEN@github.com/$DB_REPO HEAD:main

# git fetch

# # Clean
# rm -f $WORDPRESS_DB_NAME.sql*



# # -- Push Files --

# cd "/var/www/html"


# # Prevent conflict
# git pull

# # -c user.name='Plugin' -c user.email='mohamad@hubelia.com'

# git add .
# TZ=":US/Eastern" date +"Pushed via plugin, %R %d/%m/%y" | git -c user.name='Plugin' -c user.email='mohamad@hubelia.com' commit --file - 

# git -c user.name='Plugin' -c user.email='mohamad@hubelia.com' push https://$GIT_TOKEN@github.com/$SITE_REPO

git fetch