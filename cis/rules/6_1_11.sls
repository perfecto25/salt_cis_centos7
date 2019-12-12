# 6.1.11 Ensure no unowned files or directories exist

# Description:
# Sometimes when administrators delete users from the password file they neglect to
# remove all files owned by those users from the system.
# Rationale:
# A new user who is assigned the deleted user's user ID or group ID may then end up
# "owning" these files, and thus have more access on the system than was intended.

{% set result = salt['cmd.run_all'](cmd="df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser -ls | awk {'print $11'}", python_shell=True) %}

{% if result['stdout'] %}
(6.1.11) Ensure no unowned files or directories exist:
    test.fail_without_changes:
        - name: "(6.1.11) Un-owned files found: \n\n{{ result['stdout'].split() | yaml }}\n"
{% endif %}
