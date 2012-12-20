# Community Playbooks

Reusable playbooks users can leverage to build upon. Included is a LAMP playbook demonstrating the various building blocks included that is tunable from either their respective application config files and or through variables via ansible's host_vars/group_vars and or directly in playbooks.

## Usage

    $ ansible-playbook playbooks/lamp.yml

or

    $ ansible-playbook playbooks/lamp.yml --tags "mysql"

or 

    $ ansible-playbook playbooks/lamp.yml --tags "apache.cfg"

Tags is documented in lamp.yml with the various support for fine grain lamp management. 
