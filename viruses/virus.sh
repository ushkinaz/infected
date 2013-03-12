#!/bin/bash
# Workhorse. This script is executed on every to-be-infected host.

if [[ ! -x $(which git) ]]; then
	echo git not found, FAIL
	exit
fi


if [ -d /u05/$(whoami) ]; then
 export NETWORK_HOME="/u05/$(whoami)"
fi

# Possible rvm install paths:
# /usr/local/rvm/
# $HOME/.rvm/

if [[ -d $HOME/.rvm/bin ]]; then
 export rvm_path=$HOME/.rvm
elif [[ -d /usr/local/rvm/  ]]; then
 export rvm_path=/usr/local/rvm/
elif [[ -d $NETWORK_HOME/.rvm/bin ]]; then
 export rvm_path=$NETWORK_HOME/.rvm
fi

if [ ! -d $rvm_path/bin/ ]; then
	curl -L https://get.rvm.io | bash -s stable --ruby --gems=homesick,cheat,github
fi

source $rvm_path/scripts/rvm
rvm reload > /dev/null
rvm cleanup all

homesick clone https://github.com/ushkinaz/castle.git -q
homesick pull castle -q
homesick symlink castle -f -q

homesick clone https://github.com/ushkinaz/castle-vim7.git -q
homesick pull castle-vim7 -q
homesick symlink castle-vim7 -f -q


cd ~/.homesick/repos/castle/ && git reset --hard HEAD && git clean -dff && git pull --ff-only
cd ~/.homesick/repos/castle-vim7/ && git reset --hard HEAD && git clean -dff && git pull --ff-only

echo "+++Infected+++"

# vim: set filetype=sh :
