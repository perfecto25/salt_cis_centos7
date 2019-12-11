# 6.2.10 Ensure users' dot files are not group or world writable

# Description:
# While the system administrator can establish secure permissions for users' "dot" files, the
# users can easily override these.
# Rationale:
# Group or world-writable user configuration files may enable malicious users to steal or
# modify other users' data or to gain another user's system privileges.

{% set result = salt['cmd.script']('salt://{}/files/6_2_10'.format(slspath), cwd='/opt') %}

{% if result['stdout'] %}
(6.2.10) Ensure users' dot files are not group or world writable:
    test.fail_without_changes:
        - name: "(6.2.10) Ensure users' dot files are not group or world writable: \

                {{ result['stdout'] }} \
                
        "
{% endif %}