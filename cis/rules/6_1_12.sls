# 6.1.12 Ensure no ungrouped files or directories exist
# Description:
# Sometimes when administrators delete users or groups from the system they neglect to
# remove all files owned by those users or groups.

# Rationale:
# A new user who is assigned the deleted user's user ID or group ID may then end up
# "owning" these files, and thus have more access on the system than was intended.

{% set result = salt['cmd.run_all'](cmd="df --local -P | awk {'if (NR!=1) print $6'} | grep -v '/run' |  xargs -I '{}' find '{}' -xdev -nogroup", python_shell=True) %}

{% if result['stdout'] %}
(6.1.12) Ensure no ungrouped files or directories exist:
    test.fail_without_changes:
        - name: "(6.1.12) Un-grouped files found: \n\n{{ result['stdout'].split() | yaml }}\n"
{% endif %}
