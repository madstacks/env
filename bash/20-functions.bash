# ssh known_hosts deletion helper
function sdk() {
    if echo $1 | grep -qE '^[0-9]+$|^[0-9]+,[0-9]+$' ; then
        sed -i "${1}d" ${HOME}/.ssh/known_hosts
    fi
}


# deposit rsa key to root@remotehost
function putkey() {
    host=$(echo $@ | cut -d@ -f2) # helpful for putkey !! or !$ when previous "ssh root@<host>" fails
    scp -o strictHostKeyChecking=no ${HOME}/.ssh/id_rsa.pub ${host}:my_rsa.pub >/dev/null 2>&1
    ssh -t -t -o strictHostKeyChecking=no $host \
        "sudo su -c \"cat ${HOME}/my_rsa.pub >> /root/.ssh/authorized_keys\" ; rm my_rsa.pub"
}


# delete a local and remote git branch
function rmbranch() {
    git branch -D $1 && git push origin :$1
}


# Tag and push upstream
function gtag() {
    git tag -a $1 -m 'v$1'
    git push --tags upstream
}

# Reset tmux window name after exiting remote host
# Add something like this to your ~/.ssh/config to set window name to the remote host's hostname
# after you SSH in
#
# Host * !*github* !*bitbucket*
#     PermitLocalCommand yes
#     LocalCommand if [[ "$TERM" == screen* && "%r" != "git" ]]; then printf "\033k%h\033\\"; fi
function ssh() {
    local current_name=$(tmux display-message -p '#W')
    local ssh_bin=$(which ssh)
    $ssh_bin "$@"
    [[ -n "$TMUX" ]] && tmux rename-window $current_name
}

function s() {
    ssh "$@"
}
