#!/bin/bash

EXTRA_SETUP="./extras/install.sh"

# Setup 3rd party repos
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
sudo add-apt-repository -y ppa:moka/moka-icon-theme
sudo add-apt-repository -y ppa:moka/faba-icon-theme
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add - 
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" > /etc/apt/sources.list.d/virtualbox.list'

echo "Running apt-get update"
sudo apt-get update -qq || exit 1

# Install packages
sudo apt-get install -y keepassx git git-gui terminator python-pip autojump keychain nemo unity-tweak-tool \
	build-essential realpath jq curl python-dev python3-dev tig gtk2-engines-murrine gtk2-engines-pixbuf \
	openssh-server vim traceroute tmux cifs-utils ffmpegthumbnailer oracle-java7-installer oracle-java7-set-default \
	google-chrome-stable virtualbox-4.3 dkms sublime-text-installer moka-icon-theme faba-icon-theme \
	faba-icon-theme-symbolic faba-mono-icons faba-colors dconf-editor ipython || exit 1

sudo pip install virtualenvwrapper  || exit 1

# Setup symlinks
./symlinks.py

# VIM setup
if [ ! -d ~/.vim/bundle/vundle ]; then
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

mkdir -p ~/.vim/colors
wget -O ~/.vim/colors/wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400

mkdir -p ~/.virtualenvs ~/.themes ~/Apps ~/dev

# Run additional environment specific setup script
if [ -f $EXTRA_SETUP ]; then
	source $EXTRA_SETUP
fi
