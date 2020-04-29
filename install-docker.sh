#!/bin/sh
#
# Script for automatic setup of docker and docker compose on Ubuntu.

# DO NOT RUN THIS SCRIPT ON YOUR PC OR MacOS!
#
# The latest version of this script is available at:
#
# Copyright (C) 2020 Neeson <neesonqk@gmail.com>

# =====================================================


export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

bigecho() { echo; echo "## $1"; echo; }

cat <<EOF

================================================

Before starting, you should be noted below term(s):

1) Docker Compose will be auto installed if yet installed.
2) curl will be auto installed if yet installed.

================================================

EOF

read -p "Ok, I'm well noted. (Y/n)" agreed
agreed=${agreed:-Y}
agreed=`echo "${agreed}" | tr '[a-z]' '[A-Z]'`
echo "$agreed"

if [ "$agreed" != "Y" ] ; then
    printf "You disagreed the terms, exiting now."
    exit 0;
fi

printf "You've agreed all terms \n\n"

bigecho "Start to install docker ..."

sudo apt update

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

sudo apt update

sudo apt install docker-ce -y

sudo docker version

bigecho "Docker installiation is completed."

bigecho "Start to install Docker Compose ... "

sudo apt install curl -y

sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo docker-compose --version

bigecho "Docker Compose installiation is completed."
