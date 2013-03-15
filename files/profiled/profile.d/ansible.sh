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

alias cf-updateplays="cd ${ANSIBLE_ROOT}; git add .; git stash; git pull --rebase; git submodule update; cd - >/dev/null 2>&1"
alias cf-popstash="cd ${ANSIBLE_ROOT}; git stash pop; cd - >/dev/null 2>&1"
alias cf-viewstash="cd ${ANSIBLE_ROOT}; git stash show; cd - >/dev/null 2>&1"
alias cf-viewenv="cd ${ANSIBLE_ROOT}; git branch -l; cd - >/dev/null 2>&1"





#
# Functions
#

# @param1 branch/environment
function cf-setenv() {
	if [ ! -z ${1} ]
	then
		cd ${ANSIBLE_ROOT}
		git checkout ${1}
		cd - >/dev/null 2>&1
	else
		echo 'cf-env [master|develop]'
	fi
}
# @param1 path to playbook
function cf-viewplay() {
	if [ ! -z ${1} ]
	then
		cf-play ${1} "--check --diff"
	else
		echo 'cf-viewplay /path/to/playbook.yml || playbook'
	fi
}
# @param1 path to playbook
# @param2 optional dryrun mode
function cf-play() {
	if [ ! -z ${1} ]
	then
		# try to look in strategybooks first
		if [ -f ${ANSIBLE_ROOT}/strategybooks/${1}.yml ]
		then
			${ANSIBLE_HOME}/bin/ansible-playbook ${ANSIBLE_ROOT}/strategybooks/${1}.yml --extra-vars "hosts=`hostname`" --connection=local ${2}
			return $?
		fi

		# now try to look in playbooks
		if [ -f ${ANSIBLE_ROOT}/playbooks/${1}.yml ]
		then
			${ANSIBLE_HOME}/bin/ansible-playbook ${ANSIBLE_ROOT}/playbooks/${1}.yml --extra-vars "hosts=`hostname`" --connection=local ${2}
			return $?
		fi

		# defaults to executing explicit playbook path
		${ANSIBLE_HOME}/bin/ansible-playbook ${1} --extra-vars "hosts=`hostname`" --connection=local ${2}
		return $?
	else
		echo 'cf-play /path/to/playbook.yml || playbook'
	fi
}
