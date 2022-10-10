# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ctirions <ctirions@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/03 18:19:13 by ctirions          #+#    #+#              #
#    Updated: 2022/10/10 14:34:27 by ctirions         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

if [ ! -d /var/lib/mysql/$MARIADB_NAME ]; then
	service mysql start --datadir=/var/lib/mysql

	echo "Create $MARIADB_NAME"
	eval "echo \"$(cat /tmp/config.sql)\"" | mariadb -u root

	service mysql stop --datadir=/var/lib/mysql

fi

mysqld_safe --datadir=/var/lib/mysql
