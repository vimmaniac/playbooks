# Community Playbooks

Reusable playbooks users can leverage to build upon. Included is a LAMP playbook demonstrating the various building blocks used. Lamp is tunable from either their respective application config files and or through variables via ansible's host_vars/group_vars and or directly in the application's playbook. Application configs are included by first available starting with ansible_fqdn, host_group, datacentre, down to defaults. Within those levels you also have the option to create and use your very own private configuration paths configured in vars/global.yml.

If you want, you can also nest the lamp playbook to include a more specific setup that your environment requires. You can add/remove tasks to the base playbook to suite your platform requirements. I've taken extra steps to ensure that these are generic enough configurations so all one would have to do is start with a simpler base and simply add/include prebuilt tasks/playbooks to build more complex appliances. I'm currently using this repo as my own building block in production to provision our company datacentres and cloud instances. This model can be used in both push/pull and or just a glorifed ssh loop style management.

The playbooks here were tested and used on CentOS 5/6. Feel free to include logic to support more distrabutions.

Thoughts and contributions are much appreciated so that we can have a rich user community that do not all have the same wheel. ;)

Contact james@callfire.com for help getting started.

## Usage

    $ ansible-playbook playbooks/lamp.yml

or

    $ ansible-playbook playbooks/lamp.yml --tags "mysql"

or 

    $ ansible-playbook playbooks/lamp.yml --tags "mysql.cfg"

Some default sub-tags used in my playbooks for fine grain push management include:

    - pkgs
    - cfg
    - init

This comes in handy if you just want to sync configuration files without any additional processes that come from a playbook.
