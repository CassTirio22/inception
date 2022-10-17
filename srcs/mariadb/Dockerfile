# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ctirions <ctirions@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/03 18:15:36 by ctirions          #+#    #+#              #
#    Updated: 2022/10/17 14:18:37 by ctirions         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install mariadb-server -y

RUN chown -R mysql:mysql /var/lib/mysql
RUN mkdir -p /var/run/mysqld
RUN touch /var/run/mysqld/mysqlf.pid
RUN mkfifo /var/run/mysqld/mysqld.sock
RUN chown -R mysql:mysql /var/run/mysqld

COPY ./utils/mariadb.cnf /etc/mysql/
COPY ./utils/entrypoint.sh ./
COPY ./utils/config.sql ./

ENTRYPOINT [ "bash", "entrypoint.sh" ]
