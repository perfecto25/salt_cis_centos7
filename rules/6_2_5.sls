# 6.2.5 Ensure root is the only UID 0 account

# Description:
# Any account with UID 0 has superuser privileges on the system.
# Rationale:
# This access must be limited to only the default root account and only from the system
# console. Administrative access must be through an unprivileged account using an approved
# mechanism as noted in Item 5.6 Ensure access to the su command is restricted.

{% set result = salt['cmd.run_all'](cmd="cat /etc/passwd | awk -F: '($3 == 0) { print $1 }'", python_shell=True) %}

{% if not result['stdout'] == 'root' %}
(6.2.5) Ensure root is the only UID 0 account:
    test.fail_without_changes:
        - name: "(6.2.5) Ensure root is the only UID 0 account: \n\n{{ result['stdout'].split() | yaml }}\n"
{% endif %}