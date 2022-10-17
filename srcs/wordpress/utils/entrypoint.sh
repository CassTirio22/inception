# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ctirions <ctirions@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 18:12:02 by ctirions          #+#    #+#              #
#    Updated: 2022/10/17 15:59:46 by ctirions         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!bin/sh

grep -E "listen = 9000" "/etc/php/7.3/fpm/pool.d/www.conf" > /dev/null 2>&1
if [ $? -ne 0 ]; then
 	echo "Listen port configuration"
	sed -i "s|.*listen = /run/php/php7.3-fpm.sock.*|listen = 9000|g" "/etc/php/7.3/fpm/pool.d/www.conf"
fi

cat /.setup 2> /dev/null
if [ $? -ne 0 ]; then
	echo "Create wp-config.php"
	wp config create \
		--dbname=$MARIADB_DATABASE \
		--dbuser=$MARIADB_USER_NAME \
		--dbpass=$MARIADB_USER_PSW \
		--dbhost=$MARIADB_NAME \
		--path="/var/www/wordpress/" \
		--allow-root \
		--skip-check
	touch /.setup
fi

if ! wp core is-installed --allow-root; then
	echo "Install wordpress"
	wp core install \
	--url="$WORDPRESS_URL" \
	--title="$WORDPRESS_TITLE" \
	--admin_user="$WORDPRESS_ADMIN_USER" \
	--admin_password="$WORDPRESS_ADMIN_PSW" \
	--admin_email="$WORDPRESS_ADMIN_EMAIL" \
	--skip-email \
	--allow-root

	echo "Update wordpress"
	wp plugin update --all --allow-root

	echo "Create first user"
	wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL \
	--role=editor \
	--user_pass=$WORDPRESS_USER_PSW \
	--allow-root

	echo "Create first post"
	wp post generate \
		--count=1 \
		--post_title=$WORDPRESS_TITLE \
		--allow-root

fi

echo "Start"
php-fpm7.3 --nodaemonize
