# Community Playbooks

Generic ansible playbooks that I include in more complex playbooks. This is an atempt to create reusable playbooks where the community can clone and contribute just like puppet and chef communities. I know there has been discussions in the google groups for pros and cons for generic playbooks and I feel that a good design will compensate for the argument made against shared playbooks.

Goals that make this design work is the separation of:

* Configurable/tunable variables
* Extendable playbooks
* Base playbooks are stripped of specific business concerns

## Use Cases

If the above design goals are met, we should be able to execute the following uses:

* Execute individual standalone playbooks
* Extending playbooks for specific business requirements
* Compositing playbooks into a strategy
* Works for both push/pull models

## Design Architecture

This structure allows us to better archieve our goals. The variable ${ansible_home} can be pointed at /etc/ansible or anywhere you wish deployed on your hosts. This will allow you to implement either push/pull methods without the pain or agony of trying to tailer the playbooks to work where you want them installed. The playbooks will use paths configured in the global playbook.

* My project layout works as such:

```
${ansible_home}/
  ansible/ (git submodule; project origin)
  playbooks/ (git submodule; public playbooks)
  strategybooks/ (git submodule; composition of extended playbooks)
  hosts (ansible hosts file)
```

The project structure above uses git submodules heavily so we keep track of known working ansible/playbooks/playbooks-extended tree so you can always move forward with new feature support or freeze at a good working deployment snapshot. This approach works for both those that want a stable snapshot or those that want to stay on the bleeding edge with ansible's progression. At any point if something breaks while implementing a new feature from ansible, you can always rollback to a known state where your playbooks last worked.

* Each playbook consists of the following structure:

```
${ansible_home}/playbooks/
  <module>/
    files/
    templates/
    vars/main.yml
    tasks/main.yml
    play.yml
```

The playbooks layout above allows us to use assumptions about the layout so that we can assemble strategies to extend or build composite playbooks (strategies). This uses the same idea in programming idioms like java beans and reflections. Structures are good because we need to rely on reproducable layouts to generate variables and such to bootstrap our strategies. It is nice that ansible is flexible, allowing us to do as we please to fit our needs. We all know this will lead to CHAOS with confusing/conflicting goals that are not cohesive and loosly coupled. If I sound like a software engineer, that's because I was one for nearly 10 yrs and sysadmin longer than that. That makes me a good candidate as a DEVOPS?

## Configuring playbooks or strategies

Configure you the global playbook for either standalone playbooks or extended playbooks (strategies) to bootstrap the directory paths that are used in each playbook. I will include a best practices section for implementing clean playbook designs so we don't end up with unreusable playbooks much like the puppet and chef equivalence of community modules/receipes.

* You can configure the global playbooks setting by copying template.yml to main.yml:

    $ cp ${playbooks_home}/global/vars/template.yml ${playbooks_home}/global/vars/main.yml
    $ vi ${playbooks_home}/global/vars/main.yml

* You can configure each module via:
${playbooks_home}/<module>/vars/main.yml

* To execute the single playbook you can then run:

    $ ansible-playbook playbooks/<module>/play.yml

* To execute a strategy you can run:

    $ ansible-playbook playbooks-mycompany/sandbox/play.yml

## Best Practices

* Playbook directory structure
* Variable naming conventions
* Checklist on how to achieve design goals
