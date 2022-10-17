# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ctirions <ctirions@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/03 18:19:13 by ctirions          #+#    #+#              #
#    Updated: 2022/10/17 14:20:33 by ctirions         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

if [ ! -d /var/lib/mysql/$MARIADB_NAME ]; then
	service mysql start --datadir=/var/lib/mysql

	echo "Create $MARIADB_NAME"
	eval "echo \"$(cat ./config.sql)\"" | mariadb -u root

	mysqladmin -u root password $MARIADB_PSW

	service mysql stop --datadir=/var/lib/mysql

fi

mysqld_safe --datadir=/var/lib/mysql
