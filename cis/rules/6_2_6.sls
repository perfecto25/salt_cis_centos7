# 6.2.6 Ensure root PATH integrity

# Description:
# The root user can execute any command on the system and could be fooled into executing
# programs unintentionally if the PATH is not set correctly.
# Rationale:
# Including the current working directory (.) or other writable directory in root 's executable
# path makes it likely that an attacker can gain superuser access by forcing an administrator
# operating as root to execute a Trojan horse program.

{% set result = salt['cmd.script']('salt://{}/files/6_2_6'.format(slspath), cwd='/opt') %}

{% if result['stdout'] %}
(6.2.6) Ensure root PATH integrity:
    test.fail_without_changes:
        - name: "(6.2.6) Ensure root PATH integrity: {{ result['stdout'] }}"
{% endif %}
