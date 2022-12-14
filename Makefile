# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ctirions <ctirions@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 17:51:13 by ctirions          #+#    #+#              #
#    Updated: 2022/10/18 13:46:25 by ctirions         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
		docker-compose -f ./srcs/docker-compose.yml build
		sudo mkdir -p /home/ctirions/data/database
		sudo mkdir -p /home/ctirions/data/wordpress
		sudo echo "127.0.0.1 ctirions.42.fr" >> /etc/hosts
		docker-compose -f ./srcs/docker-compose.yml up --detach

up:
		docker-compose -f ./srcs/docker-compose.yml up --detach

down:
		docker-compose -f ./srcs/docker-compose.yml down

clean: down
		docker-compose -f ./srcs/docker-compose.yml -v --rmi all
		docker volume rm srcs_mariadb-volume
		docker volume rm srcs_wordpress-volume

fclean: clean
		sudo rm -rf /home/ctirions/data
		docker image rm mariadb
		docker image rm wordpress
		docker image rm nginx
		docker image rm debian:buster

re: fclean all

.PHONE: all up down clean fclean re build
