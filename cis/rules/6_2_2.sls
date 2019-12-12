# 6.2.2 Ensure no legacy "+" entries exist in /etc/passwd

# Description:
# The character + in various files used to be markers for systems to insert data from NIS
# maps at a certain point in a system configuration file. These entries are no longer required
# on most systems, but may exist in files that have been imported from other platforms.
# Rationale:
# These entries may provide an avenue for attackers to gain privileged access on the system.


{% set result = salt['cmd.run_all'](cmd="grep '^\+:' /etc/passwd", python_shell=True) %}

{% if result['stdout'] %}
(6.2.2) Ensure no legacy "+" entries exist in /etc/passwd:
    test.fail_without_changes:
        - name: "(6.2.2) Ensure no legacy '+' entries exist in /etc/passwd: \n\n{{ result['stdout'].split() | yaml }}\n"
{% endif %}
