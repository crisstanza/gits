#!/bin/bash
clear ; cd "$(dirname "${0}")"

HOST=git@github.com
OWNER=crisstanza

PROJECTS=()
PROJECTS+=('gits')

upgrade() {
	sudo add-apt-repository -y ppa:git-core/ppa
	sudo apt-get update
	sudo apt-get install git -y
}

setLocalUser() {
	for PROJECT in ${PROJECTS[*]} ; do
		cd ${PROJECT} ; pwd ;
		git config user.email "crisstanza@users.noreply.github.com"
		git config user.name "Cris Stanza"
		git config -l --local | grep user.
		echo ; cd ..
	done
}

keygen() {
	ssh-keygen -t ed25519 ; echo
	cat ~/.ssh/id_ed25519.pub ; echo
}

aliases() {
	git config --global alias.co checkout
	git config --global alias.br branch
	git config --global alias.ci commit
	git config --global alias.st status
	git config --global alias.sw switch
	git config --global alias.lr 'log --raw'
}

clone() {
	for PROJECT in ${PROJECTS[*]} ; do
		git clone ${HOST}:${OWNER}/${PROJECT}.git ; echo
	done
}

log() {
	for PROJECT in ${PROJECTS[*]} ; do
		cd ${PROJECT} ; pwd ; echo
		git log -n 6 --oneline ; echo ; echo ; cd ..
	done
}

pull() {
	for PROJECT in ${PROJECTS[*]} ; do
		cd ${PROJECT} ; pwd ; echo
		git pull ; echo ; echo ; cd ..
	done
}

status() {
	for PROJECT in ${PROJECTS[*]} ; do
		cd ${PROJECT} ; pwd ; echo
		git status -sb ; echo ; echo ; cd ..
	done
}

versions() {
	echo "node: $(node --version)"
	echo "npm: $(npm --version)"
	echo "nvm: $(nvm --version)"
	echo "npx: $(npx --version)"
	echo "git: $(git --version)"
}

if [ ${#} -eq 0 ] ; then
	echo -e "\nUsage: ${0} [COMMANDS]\n\nAvailable commands:"
	cat `basename ${0}` | grep '()\s{' | while read COMMAND ; do echo " - ${COMMAND::-4}" ; done
else
	for COMMAND in "${@}" ; do "${COMMAND}" ; done
fi
