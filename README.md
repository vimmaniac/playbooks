# Community Playbooks

Reusable playbooks users can leverage to build upon. Included is a LAMP playbook demonstrating the various building blocks used. Lamp is tunable from either their respective application config files and or through variables via ansible's host_vars/group_vars and or directly in the application's playbook.

What you can additionally do is extend this lamp playbook and include it in your custom playbook(s) to work with your existing needs.

Thoughts and contributions are much appreciated so that we can have a rich user community that do not all have the same wheel. ;)

## Usage

    $ ansible-playbook playbooks/lamp.yml

or

    $ ansible-playbook playbooks/lamp.yml --tags "mysql"

or 

    $ ansible-playbook playbooks/lamp.yml --tags "apache.cfg"

Tags is documented in lamp.yml with the various support for fine grain lamp management. 
