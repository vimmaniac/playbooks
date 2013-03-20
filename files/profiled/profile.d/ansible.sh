# /etc/ansible/playbooks/files/profiled/profile.d/ansible.sh

#
# Environment
#

ANSIBLE_ROOT=/etc/ansible
ANSIBLE_HOME=/etc/ansible/ansible

PREFIX_PYTHONPATH="${ANSIBLE_HOME}/lib"
PREFIX_PATH="${ANSIBLE_HOME}/bin"
PREFIX_MANPATH="${ANSIBLE_HOME}/docs/man"
export PYTHONPATH=${PREFIX_PYTHONPATH}:${PYTHONPATH}
export PATH=${PREFIX_PATH}:${PATH}
export ANSIBLE_LIBRARY="${ANSIBLE_HOME}/library"
export MANPATH=${PREFIX_MANPATH}:${MANPATH}





#
# Aliases
#

alias cf-system-updateplays="cd ${ANSIBLE_ROOT}; git add .; git stash; git pull --rebase; git submodule update; cd - >/dev/null 2>&1"
alias cf-system-popstash="cd ${ANSIBLE_ROOT}; git stash pop; cd - >/dev/null 2>&1"
alias cf-system-viewstash="cd ${ANSIBLE_ROOT}; git stash show; cd - >/dev/null 2>&1"
alias cf-system-viewenv="cd ${ANSIBLE_ROOT}; git branch -l; cd - >/dev/null 2>&1"





#
# Global variables
#

export PLAYBOOK_PATH=""





#
# Functions
#

# @param1 playbook
function _searchplay() {
	if [ ! -z ${1} ]
	then
		# try to look in strategybooks first
		[ -f ${ANSIBLE_ROOT}/strategybooks/${1}.yml ] && PLAYBOOK_PATH="${ANSIBLE_ROOT}/strategybooks/${1}.yml" && return 0

		# now try to look in playbooks
		[ -f ${ANSIBLE_ROOT}/playbooks/${1}.yml ] && PLAYBOOK_PATH="${ANSIBLE_ROOT}/playbooks/${1}.yml" && return 0

		# defaults to executing explicit playbook path
		PLAYBOOK_PATH="${1}" && return 0
	fi
	return 1
}
# @param1 branch/environment
function cf-sys-setenv() {
	if [ ! -z ${1} ]
	then
		cd ${ANSIBLE_ROOT}
		git checkout ${1}
		cd - >/dev/null 2>&1
	else
		echo 'cf-sys-setenv [master|develop]'
	fi
}
# @param1 playbook
# @param2 additional ansible-playbook params
function cf-sys-viewplay() {
	if [ ! -z ${1} ]
	then
		_searchplay "${1}" && ${ANSIBLE_HOME}/bin/ansible-playbook ${PLAYBOOK_PATH} --check --diff --extra-vars "hosts=`hostname`" --connection=local ${@:2}
	else
		echo 'cf-sys-viewplay [/path/to/playbook.yml|playbook] ...' && return 1
	fi
	return $?
}
# @param1 playbook
# @param2 additional ansible-playbook params
function cf-sys-play() {
	if [ ! -z ${1} ]
	then
		_searchplay "${1}" && ${ANSIBLE_HOME}/bin/ansible-playbook ${PLAYBOOK_PATH} --extra-vars "hosts=`hostname`" --connection=local ${@:2}
	else
		echo 'cf-sys-play [/path/to/playbook.yml|playbook] ...' && return 1
	fi
	return $?
}
# @param1 playbook
# @param2 hostname
# @param3 additional ansible-playbook params
function cf-sys-viewplayremote() {
	if [ ! -z ${1} ] && [ ! -z ${2} ]
	then
		_searchplay "${1}" && ${ANSIBLE_HOME}/bin/ansible-playbook ${PLAYBOOK_PATH} --check --diff --extra-vars "hosts=${2}" ${@:3}
	else
		echo 'cf-sys-viewplayremote [/path/to/playbook.yml|playbook] [hostname] ...' && return 1
	fi
	return $?
}
# @param1 playbook
# @param2 hostname
# @param3 additional ansible-playbook params
function cf-sys-playremote() {
	if [ ! -z ${1} ] && [ ! -z ${2} ]
	then
		_searchplay "${1}" && ${ANSIBLE_HOME}/bin/ansible-playbook ${PLAYBOOK_PATH} --extra-vars "hosts=${2}" ${@:3}
	else
		echo 'cf-sys-playremote [/path/to/playbook.yml|playbook] [hostname] ...' && return 1
	fi
	return $?
}
