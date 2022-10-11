# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ctirions <ctirions@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 18:12:02 by ctirions          #+#    #+#              #
#    Updated: 2022/10/11 12:18:05 by ctirions         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!bin/sh

echo "Create wp-config.php"
rm -rf /var/www/wordpress/wp-config.php
wp config create \
	--dbname=$MARIADB_DATABASE \
	--dbuser=$MARIADB_USER \
	--dbpass=$MARIADB_PASSWORD \
	--dbhost=$MARIADB_HOST \
	--path="/var/www/wordpress/" \
	--allow-root \
	--skip-check

if ! wp core is-installed --allow-root; then
	echo "Install wordpress"
	wp core install \
		--url="$WORDPRESS_URL" \
		--title="$WORDPRESS_TITLE" \
		--admin_user="$WORDPRESS_ADMIN_USER" \
		--admin_password="$WORDPRESS_ADMIN_PWD" \
		--admin_email="$WORDPRESS_ADMIN_EMAIL" \
		--allow-root

	echo "Update wordpress"
	wp plugin update --all --allow-root

	echo "Create first user"
	wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL \
		--role=editor \
		--user_pass=$WORDPRESS_USER_PWD \
		--allow-root

fi

echo "Start"
php-fpm7.3 --nodaemonize
