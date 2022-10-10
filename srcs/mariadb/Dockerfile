# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ctirions <ctirions@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/03 18:15:36 by ctirions          #+#    #+#              #
#    Updated: 2022/10/10 14:13:45 by ctirions         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install mariadb-server -y

COPY ./utils/entrypoint.sh ./

ENTRYPOINT [ "bash", "entrypoint.sh" ]
