# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

export LANG=en_US.utf8
export EDITOR=vim

# python virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev
source /usr/local/bin/virtualenvwrapper.sh

source $HOME/apps/resty/resty
source $HOME/.git-completion.sh
source $HOME/.ps1-git-prompt.sh
source /usr/share/autojump/autojump.sh

PATH=$PATH:~/apps/p4merge/bin:/opt/sublime_text
export PATH

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l'
alias lm='ls -al |more'
alias root='sudo su -'
alias pfind='ps -aef | grep $@'
alias rd='rm -rf'
alias mkv3='mkvirtualenv -p /usr/bin/python3'
alias sub='sublime_text'
alias ssh='ssh -A'
alias gg='git gui &'
alias runps='sudo service postgresql start'

#eval `keychain --env /etc/profile.d/openssh.sh --eval --agents ssh id_rsa id_crt`
eval `keychain --eval --agents ssh id_rsa`

# ssh known_hosts deletion helper
sdk()
{
    if echo $1 | grep -qE '^[0-9]+$|^[0-9]+,[0-9]+$' ; then
        sed -i "${1}d" ${HOME}/.ssh/known_hosts
    fi
}


# deposit rsa key to root@remotehost
putkey()
{
    host=$(echo $@ | cut -d@ -f2) # helpful for putkey !! or !$ when previous "ssh root@<host>" fails
    scp -o strictHostKeyChecking=no ${HOME}/.ssh/id_rsa.pub ${host}:rglen_rsa.pub >/dev/null 2>&1
    ssh -t -t -o strictHostKeyChecking=no $host \
        "sudo su -c \"cat ${HOME}/rglen_rsa.pub >> /root/.ssh/authorized_keys\" ; rm rglen_rsa.pub"
}
