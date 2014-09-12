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
    linkMap('.gitconfig', 'git/gitconfig'),
    linkMap('.vimrc', 'vim/vimrc'),
    linkMap('.bash', 'bash'),
    linkMap('.bashrc', 'bash/bashrc'),
    linkMap('.ansible.cfg', 'ansible/ansible.cfg'),
    linkMap('.tmux.conf', 'tmux/tmux.conf'),
    linkMap('.config/powerline', 'powerline'),
]

for link, source in configs:
    if os.path.isfile(link) and not os.path.islink(link):
        print('{} already exists and is not a symlink.  Backing up to {}.bak'.format(link, link))
        os.rename(link, link + '.bak')
    elif os.path.islink(link):
        pass
    try:
        os.symlink(source, link)
        print('Creating symlink: {} -> {}'.format(link, source))
    except OSError as e:
        print('{} already exists and is a symlink. Skipping'.format(link))
