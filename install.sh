#!/bin/bash

EXTRA_SETUP="./extras/install.sh"
CODENAME=$(lsb_release -cs)

# Setup 3rd party repos
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
sudo add-apt-repository -y ppa:moka/moka-icon-theme
sudo add-apt-repository -y ppa:moka/faba-icon-theme
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add - 
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian ${CODENAME} contrib" >> /etc/apt/sources.list.d/virtualbox.list'

echo "Running apt-get update"
sudo apt-get update -qq

# Install packages
sudo apt-get install -y keepassx git git-gui terminator python-pip autojump keychain nemo unity-tweak-tool \
	build-essential realpath jq curl python-dev python3-dev tig gtk2-engines-murrine gtk2-engines-pixbuf \
	openssh-server vim traceroute tmux cifs-utils ffmpegthumbnailer oracle-java7-installer oracle-java7-set-default \
	google-chrome-stable virtualbox-4.3 dkms sublime-text-installer moka-icon-theme faba-icon-theme \
	faba-icon-theme-symbolic faba-mono-icons faba-colors

sudo pip install virtualenvwrapper

# Setup symlinks
./symlinks.py

# VIM setup
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
mkdir -p ~/.vim/colors
wget -O ~/.vim/colors/wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400

mkdir ~/.virtualenvs ~/.themes

# Run additional environment specific setup script
if [ -f $EXTRA_SETUP ]; then
	source $EXTRA_SETUP
fi
