# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ctirions <ctirions@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/13 13:53:52 by ctirions          #+#    #+#              #
#    Updated: 2022/10/17 14:14:39 by ctirions         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install nginx openssl -y

COPY ./tools/nginx.conf /etc/nginx/sites-enabled/default.conf

RUN openssl req -x509 -nodes \
					-keyout /etc/ssl/ctirions.42.fr.key \
					-out /etc/ssl/ctirions.42.fr.crt \
					-subj="/C=BE/ST=Belgium/L=Brussels/O=42/OU=19/CN=ctirions.42.fr/UID=ctirions"

CMD [ "nginx", "-g", "daemon off;"]
