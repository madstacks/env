# Define some colors.
if [[ $COLORTERM = gnome-* && $TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then 
    TERM=gnome-256color; 
fi

# Color chart: http://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
if tput setaf 1 &> /dev/null; then
    tput sgr0
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
      BASE03=$(tput setaf 234)
      BASE02=$(tput setaf 235)
      BASE01=$(tput setaf 240)
      BASE00=$(tput setaf 241)
      BASE0=$(tput setaf 244)
      BASE1=$(tput setaf 245)
      BASE2=$(tput setaf 254)
      BASE3=$(tput setaf 230)
      YELLOW=$(tput setaf 229)
      ORANGE=$(tput setaf 166)
      RED=$(tput setaf 124)
      MAGENTA=$(tput setaf 125)
      VIOLET=$(tput setaf 61)
      BLUE=$(tput setaf 32)
      CYAN=$(tput setaf 37)
      GREEN=$(tput setaf 113)
      LIGHTGREEN=$(tput setaf 112)
    else
      BASE03=$(tput setaf 8)
      BASE02=$(tput setaf 0)
      BASE01=$(tput setaf 10)
      BASE00=$(tput setaf 11)
      BASE0=$(tput setaf 12)
      BASE1=$(tput setaf 14)
      BASE2=$(tput setaf 7)
      BASE3=$(tput setaf 15)
      YELLOW=$(tput setaf 3)
      ORANGE=$(tput setaf 9)
      RED=$(tput setaf 1)
      MAGENTA=$(tput setaf 5)
      VIOLET=$(tput setaf 13)
      BLUE=$(tput setaf 4)
      CYAN=$(tput setaf 6)
      GREEN=$(tput setaf 2)
      LIGHTGREEN=$(tput setaf 2)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    # Linux console colors. I don't have the energy
    # to figure out the Solarized values
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    LIGHTGREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

# this file can be found normally in git-core under /usr/share/git-core/contrib/completion/
# Ubuntu has it automatically sourced in 

source ~/.git-prompt.sh
#GIT_PS1_SHOWUPSTREAM="verbose git"
# GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_UNTRACKEDFILES=true
# export PS1='\[${GREEN}\]\h\[$BLUE\] \w \[${LIGHTBLUE}\][$(__git_ps1 "%s")]\[$BLUE\] > \[$RESET\]'

# Borrowed from http://mediadoneright.com/content/ultimate-git-ps1-bash-prompt

export PS1='\[$BLUE\]\w $(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # Clean repository - nothing to commit
    echo "'$LIGHTGREEN'$(__git_ps1 "[%s]") "; \
  else \
    # Changes to working tree
    echo "'$RED'$(__git_ps1 "[%s]") "; \
  fi)";\
fi)> \[$RESET\]'
