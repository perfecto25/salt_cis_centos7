# 5.4.2 Ensure system accounts are non-login
# Description:
# There are a number of accounts provided with CentOS 7 that are used to manage
# applications and are not intended to provide an interactive shell.
# Rationale:
# It is important to make sure that accounts that are not being used by regular users are
# prevented from being used to provide an interactive shell. By default CentOS 7 sets the
# password field for these accounts to an invalid string, but it is also recommended that the
# shell field in the password file be set to /sbin/nologin . This prevents the account from
# potentially being used to run any commands.


{% set accounts = salt['cmd.run_all'](cmd="egrep -v \"^\+\" /etc/passwd | awk -F: '($1!=\"root\" && $1!=\"sync\" && $1!=\"shutdown\" && $1!=\"halt\" && $3<1000 && $7!=\"/sbin/nologin\" && $7!=\"/bin/false\") {print}'", python_shell=True) %}

{% if accounts['stdout'] %}
(5.4.2) Ensure system accounts are non-login:
    test.fail_without_changes:
        - name: "(5.4.2) The following system accounts have login shells: \n\n{{ accounts['stdout'] }}\n"
{% endif %}


