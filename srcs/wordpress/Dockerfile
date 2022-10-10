# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ctirions <ctirions@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 17:01:42 by ctirions          #+#    #+#              #
#    Updated: 2022/10/10 18:14:36 by ctirions         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql curl
RUN mkdir -p /run/php

COPY ./utils/entrypoint.sh ./

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/wordpress/

RUN wp core download --allow-root

ENTRYPOINT [ "sh", "entrypoint.sh" ]
