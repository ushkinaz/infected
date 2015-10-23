#!/bin/bash
# Workhorse. This script is executed on every to-be-infected host.
# vim: set filetype=sh :

function fetch_castle {
	homeshick clone https://github.com/$1/$2 -q
	homeshick pull $2 -q
	homeshick link $2 -f -q
}

if [[ ! -x $(which git) ]]; then
	echo git not found, FAIL
	exit 1
fi

if [[ ! -d  $HOME/.homesick/repos/homeshick ]]; then
	git clone https://github.com/andsens/homeshick $HOME/.homesick/repos/homeshick
fi

source $HOME/.homesick/repos/homeshick/homeshick.sh

type -t homeshick || exit 1

fetch_castle ushkinaz castle
fetch_castle ushkinaz castle-vim7
fetch_castle ushkinaz castle-zsh


if [[ -d ~/.homeshick/repos/castle-zsh/home/.zprezto ]]; then
	cd ~/.homeshick/repos/castle-zsh/home/.zprezto
	git submodule update --recursive
fi
