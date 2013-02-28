# /etc/ansible/playbooks/files/profiled/profile.d/ansible.sh

#
# Environment
#

ANSIBLE_ROOT=/etc/ansible
ANSIBLE_HOME=/etc/ansible/ansible

PREFIX_PYTHONPATH="$ANSIBLE_HOME/lib"
PREFIX_PATH="$ANSIBLE_HOME/bin"
PREFIX_MANPATH="$ANSIBLE_HOME/docs/man"
export PYTHONPATH=$PREFIX_PYTHONPATH:$PYTHONPATH
export PATH=$PREFIX_PATH:$PATH
export ANSIBLE_LIBRARY="$ANSIBLE_HOME/library"
export MANPATH=$PREFIX_MANPATH:$MANPATH





#
# Aliases
#

alias cf-update="cd ${ANSIBLE_ROOT}; git stash; git pull; git submodule update; cd -"
alias cf-viewstash="cd ${ANSIBLE_ROOT}; git stash show; cd -"





#
# Functions
#

# @param1 branch/environment
function cf-setenv() {
	if [ ! -z ${1} ]
	then
		cd ${ANSIBLE_ROOT}
		git checkout ${1}
		cd -
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
		echo 'cf-viewplay /path/to/playbook.yml'
	fi
}
# @param1 path to playbook
# @param2 optional dryrun mode
function cf-play() {
	if [ ! -z ${1} ]
	then
		python ${1} --extra-vars "hosts=`hostname`" --connection=local ${2}
	else
		echo 'cf-play /path/to/playbook.yml'
	fi
}
