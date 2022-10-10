# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install_docker_ubuntu.sh                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ctirions <ctirions@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 16:43:01 by ctirions          #+#    #+#              #
#    Updated: 2022/10/10 16:43:02 by ctirions         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install  curl apt-transport-https ca-certificates software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update

sudo apt-get install docker-ce docker-compose -y

sudo adduser $USER docker
