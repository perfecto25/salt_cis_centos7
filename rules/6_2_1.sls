# 6.2.1 Ensure password fields are not empty

# Description:
# An account with an empty password field means that anybody may log in as that user
# without providing a password.
# 
# Rationale:
# All accounts must have passwords or be locked to prevent the account from being used by
# an unauthorized user.


{% set result = salt['cmd.run_all'](cmd="cat /etc/shadow | awk -F: '($2 == \"\" ) { print $1}'", python_shell=True) %}

{% if result['stdout'] %}
(6.2.1) Ensure password fields are not empty:
    test.fail_without_changes:
        - name: "(6.2.1) Ensure password fields are not empty: \n\n{{ result['stdout'].split() | yaml }}\n"
{% endif %}
