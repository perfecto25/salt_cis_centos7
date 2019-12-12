# 6.1.10 Ensure no world writable files exist

{% set result = salt['cmd.run_all'](cmd="df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -0002", python_shell=True) %}


{% if result['stdout'] %}
(6.1.10) Ensure no world writable files exist:
    test.fail_without_changes:
        - name: "(6.1.10) world-writable files found: \n\n{{ result['stdout'].split() | yaml }}\n"
{% endif %}
