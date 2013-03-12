#!/bin/bash
# Make names of hosts pretty. If there is known 'nice' name for a host - store it on that host in file .bash_local.
# prettify [host]

if [[ "$1" != "" ]]; then
	hosts="$1"
else
	hosts=$(./known_hosts | grep -v 'vs-as')
fi

for host in $hosts
do
	pretty_name=$(echo "$host" | awk -F '.' '{ print $1}')
	group=$(echo "$host" | awk -F '.' '{ print $2}')

	if [[ $pretty_name == app* ]]; then
		pretty_name="${pretty_name:3}"
	fi

	if [[ $group == "d" || $group == "s" || $group == "e" ]]; then
		pretty_name=$pretty_name".$group"
	fi
	echo "== prettifying $host >> $pretty_name"
	ssh $host "echo 'export PRETTY_HOST_NAME=$pretty_name' > ~/.bash_local"
done
