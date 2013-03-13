#!/bin/bash
# update settings for a host

function update_repo {
	if [[ -d $1 ]]; then
		cd $1
		git reset --hard HEAD
		git clean -dff
		git pull --ff-only
	fi
}

update_repo ~/.homesick/repos/castle/
update_repo ~/.homesick/repos/castle-vim7/
