#!/usr/bin/python2.7

import os
import sys

homedir = os.getenv('HOME')
sourcedir = os.path.dirname(os.path.abspath(sys.argv[0]))

def linkMap(linkinput, srcinput):
    """
    Return a 2-item tuple representing a symlink and its source target
    """
    linktarget = os.path.join(homedir, linkinput)
    linksource = os.path.join(sourcedir, srcinput)
    return (linktarget, linksource)

configs = [
    linkMap('.gitconfig', 'git/.gitconfig'),
    linkMap('.vimrc', 'vim/.vimrc'),
    linkMap('.bashrc', 'bash/.bashrc'),
    linkMap('.git-completion.sh', 'bash/git-completion.sh'),
    linkMap('.git-prompt.sh', 'bash/git-prompt.sh'),
    linkMap('.ps1-git-prompt.sh', 'bash/ps1-git-prompt.sh'),
]

for link, source in configs:
    if os.path.isfile(link) and not os.path.islink(link):
        print '{} already exists and is not a symlink.  Backing up to {}.bak'.format(link, link)
        os.rename(link, link + '.bak')
    elif os.path.islink(link):
        pass
    try:
        os.symlink(source, link)
        print 'Creating symlink: {} -> {}'.format(link, source)
    except OSError as e:
        print '{} already exists and is a symlink. Skipping'.format(link)
