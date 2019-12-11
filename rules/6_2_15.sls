# 6.2.15 Ensure all groups in /etc/passwd exist in /etc/group

# Description:
# Over time, system administration errors and changes can lead to groups being defined in
# /etc/passwd but not in /etc/group .
# Rationale:
# Groups defined in the /etc/passwd file but not in the /etc/group file pose a threat to
# system security since group permissions are not properly managed.

{% set result = salt['cmd.script']('salt://{}/files/6_2_15'.format(slspath), cwd='/opt') %}

{% if result['stdout'] %}
(6.2.15) Ensure all groups in /etc/passwd exist in /etc/group:
    test.fail_without_changes:
        - name: "(6.2.15) Ensure all groups in /etc/passwd exist in /etc/group: \

                {{ result['stdout'] }} \
                
        "
{% endif %}