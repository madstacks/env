#!/bin/bash

# Install packages
sudo apt-get install -y keepassx git git-gui terminator python-pip autojump screen gnome-tweak-tool
sudo apt-get install -y keychain nemo unity-tweak-tool build-essential mongodb realpath jq curl
sudo apt-get install -y python-dev python3-dev slapd ldap-utils libldap2-dev libsasl2-modules-ldap libsasl2-dev
sudo apt-get install -y openssh-server vim

sudo pip install virtualenvwrapper

# Set 3rd party repos
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository ppa:webupd8team/sublime-text-2
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add - 
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian saucy contrib" >> /etc/apt/sources.list.d/virtualbox.list'
sudo apt-get update

# Install extra packages
sudo apt-get install -y oracle-java7-installer oracle-java7-set-default sublime-text google-chrome-stable
sudo apt-get install -y virtualbox-4.3 dkms

./symlinks.py

mkdir ~/apps
cd ~/apps

git clone https://github.com/micha/resty.git
git clone https://github.com/royrusso/elasticsearch-HQ.git
git clone git://github.com/mobz/elasticsearch-head.git

cd ~
mkdir ~/.virtualenvs
