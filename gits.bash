#!/bin/bash
clear ; cd "$(dirname "${0}")"

HOST=git@github.com
OWNER=crisstanza

PROJECTS=()
PROJECTS+=('gits')

keygen() {
	ssh-keygen -t ed25519 ; echo
	cat ~/.ssh/id_ed25519.pub ; echo
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

if [ ${#} -eq 0 ] ; then
	echo -e "Usage: ${0} [COMMANDS]\nAvailable commands:"
	cat `basename ${0}` | grep '()\s{' | while read COMMAND ; do echo " - ${COMMAND::-4}" ; done
else
	for COMMAND in "${@}" ; do "${COMMAND}" ; done
fi
