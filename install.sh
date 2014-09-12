#!/bin/bash

EXTRA_SETUP="./extras/install.sh"

##############################################
# Setup Directories
##############################################
mkdir -p ~/.virtualenvs ~/.themes ~/apps ~/dev

##############################################
# Install Software
##############################################
# Setup 3rd party repos
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
sudo add-apt-repository -y ppa:moka/moka-icon-theme
sudo add-apt-repository -y ppa:moka/faba-icon-theme

# Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'

# VirtualBox
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian '$(lsb_release -cs)' contrib non-free' > /etc/apt/sources.list.d/virtualbox.list"

echo "Running apt-get update"
sudo apt-get update -qq || exit 1

# Install Packages
sudo apt-get install -y software-properties-common git git-gui terminator python-pip autojump keychain \
    nemo unity-tweak-tool build-essential realpath jq curl python-dev python3-dev tig gtk2-engines-murrine \
    gtk2-engines-pixbuf openssh-server vim traceroute tmux cifs-utils ffmpegthumbnailer \
    oracle-java7-installer oracle-java7-set-default google-chrome-stable virtualbox-4.3 dkms \
    sublime-text-installer moka-icon-theme faba-icon-theme faba-icon-theme-symbolic faba-mono-icons \
    faba-colors dconf-editor ipython pinta tree || exit 1

# Python Stuff
sudo pip install virtualenvwrapper ansible || exit 1

# Misc Stuff
if [ ! -d ~/apps/resty ]; then
    git clone https://github.com/micha/resty.git ~/apps/resty
fi

##############################################
# Setup Symlinks
##############################################
./symlinks.py

##############################################
# VIM Setup
##############################################
if [ ! -d ~/.vim/bundle/vundle ]; then
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

mkdir -p ~/.vim/colors
wget -O ~/.vim/colors/wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400

##############################################
# dconf Settings
##############################################
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
gsettings set com.canonical.Unity.Lenses home-lens-default-view "['applications.scope', 'applications-applications.scope']"
gsettings set com.canonical.Unity.Lenses remote-content-search "none"
gsettings set com.canonical.Unity.ApplicationsLens display-available-apps "false"
gsettings set org.gnome.nautilus.desktop home-icon-visible "true"
gsettings set org.gnome.nautilus.desktop trash-icon-visible "true"
gsettings set org.gnome.nautilus.preferences show-image-thumbnails "always"
gsettings set com.canonical.indicator.datetime show-date "true"
gsettings set com.canonical.indicator.datetime show-day "true"
gsettings set com.canonical.indicator.bluetooth visible "false"

##############################################
# Powerline Setup
# Installs to /usr/local/lib/python2.7/dist-packages/powerline
##############################################
sudo pip install powerline-status 
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo fc-cache -vf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

##############################################
# Run environment specific setup script
##############################################
if [ -f $EXTRA_SETUP ]; then
    pushd ./extras
    ./install.sh
    popd
fi
