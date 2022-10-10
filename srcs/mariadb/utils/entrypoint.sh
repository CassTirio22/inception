# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ctirions <ctirions@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/03 18:19:13 by ctirions          #+#    #+#              #
#    Updated: 2022/10/10 13:01:26 by ctirions         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

if [ ! -d /var/lib/mysql/$MARIADB_NAME ]; then
	service mysql start --datadir=/var/lib/mysql

	mysql -e "UPDATE mysql.user SET Password = PASSWORD('$MARIADB_PSW') WHERE User = 'root'"
	mysql -e "DELETE FROM mysql.user WHERE User='';"
	mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
	mysql -e "DROP DATABASE test;"

	echo "Create $MARIADB_NAME"
	mysql -e "CREATE DATABASE $MARIADB_NAME"
	mysql -e "CREATE USER '$MARIADB_USER_NAME'@'localhost' IDENTIFIED BY '$MARIADB_USER_PSW'"
	mysql -e "GRANT ALL PRIVILEGES ON $MARIADB_NAME.* TO $MARIADB_USER_NAME@'localhost'"

	mysql -e "FLUSH PRIVILEGES"

	service mysql stop --datadir=/var/lib/mysql

fi

mysqld_safe --datadir=/var/lib/mysql
