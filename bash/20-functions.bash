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
    if ! $(git branch -a --list | grep -q "$1"); then
        echo "Branch $1 does not exist"
        return
    fi
    if ! $(git branch --merged | grep -q "$1"); then
        echo "$1 has not been merged to master yet"
        read -r -p "Are you sure you want to delete it? [y/N] " response
        if [[ ! "${response,,}" =~ ^(yes|y)$ ]]; then
            return
        fi
    fi
    git branch -D $1 && git push origin :$1
}


# Tag and push upstream
# gtag 1.2.3
# gtag 1.2.3 upstream
function gtag() {
    git tag -a $1 -m 'v$1'
    if [[ -n $2 ]]; then
      git push --tags $2
    elif
}
