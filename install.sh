#!/bin/bash

EXTRA_SETUP="./extras/install.sh"

##############################################
# Setup Directories
##############################################
mkdir -p ~/virtualenvs ~/Apps

##############################################
# Install Software
##############################################

# Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# VirtualBox
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian '$(lsb_release -cs)' contrib non-free' > /etc/apt/sources.list.d/virtualbox.list"

echo "Running apt-get update"
sudo apt-get update -qq || exit 1

# Install Packages
sudo apt-get install -y software-properties-common git git-gui terminator python-pip autojump keychain \
    unity-tweak-tool build-essential jq python-dev python3-dev tig gtk2-engines-murrine \
    gtk2-engines-pixbuf openssh-server traceroute tmux cifs-utils ffmpegthumbnailer \
    google-chrome-stable dkms dconf-editor pinta tree sysstat dstat htop || exit 1

# Python Stuff
sudo pip install virtualenvwrapper ansible || exit 1


##############################################
# Setup Symlinks
##############################################
./symlinks.py


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
# Run environment specific setup script
##############################################
if [ -f $EXTRA_SETUP ]; then
    pushd ./extras
    ./install.sh
    popd
fi
