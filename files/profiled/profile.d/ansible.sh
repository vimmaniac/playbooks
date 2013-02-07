# /etc/ansible/playbooks/files/profiled/profile.d/ansible.sh
ANSIBLE_HOME=/etc/ansible/ansible

PREFIX_PYTHONPATH="$ANSIBLE_HOME/lib"
PREFIX_PATH="$ANSIBLE_HOME/bin"
PREFIX_MANPATH="$ANSIBLE_HOME/docs/man"

export PYTHONPATH=$PREFIX_PYTHONPATH:$PYTHONPATH
export PATH=$PREFIX_PATH:$PATH
export ANSIBLE_LIBRARY="$ANSIBLE_HOME/library"
export MANPATH=$PREFIX_MANPATH:$MANPATH

alias playbook="python26 /etc/ansible/ansible/bin/ansible-playbook --extra-vars \"hosts=`hostname`\" --connection=local"
alias playbook-update='cd /etc/ansible; git pull; git submodule update; cd -'
