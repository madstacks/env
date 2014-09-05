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
    scp -o strictHostKeyChecking=no ${HOME}/.ssh/id_rsa.pub ${host}:my_rsa.pub >/dev/null 2>&1
    ssh -t -t -o strictHostKeyChecking=no $host \
        "sudo su -c \"cat ${HOME}/my_rsa.pub >> /root/.ssh/authorized_keys\" ; rm my_rsa.pub"
}


# delete a local and remote git branch
rmbranch()
{
    git branch -D $1 && git push origin :$1
}


# Tag and push upstream
gtag()
{
    git tag -a $1 -m 'v$1'
    git push --tags upstream
}
