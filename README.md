genenric playbooks
=========

Generic ansible playbooks that I include in more complex playbooks. My project layout works as such:

workspace/
  ansible/ (git submodule)
  playbooks/ (git submodule of this repo)
  playbooks-company/ (git submodule of company specific repo)
  hosts (ansible hosts file)

Each playbook consists of the following structure:

playbooks/
  <module>/
    files/
    templates/
    vars/
    tasks/
    play.yml

You can configure each module via:

playbooks/<module>/vars/main.yml

To execute the single playbook you can then run:

ansible-playbook playbooks/<module>/play.yml
