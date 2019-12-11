# 6.2.8 Ensure users' home directories permissions are 750 or more restrictive

# Description:
# While the system administrator can establish secure permissions for users' home
# directories, the users can easily override these.
# Rationale:
# Group or world-writable user home directories may enable malicious users to steal or
# modify other users' data or to gain another user's system privileges


{% do salt.log.error(slspath) -%}


{% set result = salt['cmd.script']('salt://{}/files/6_2_8'.format(slspath), cwd='/opt') %}


{% if result['stdout'] %}
(6.2.8) Ensure users' home directories permissions are 750 or more restrictive:
    test.fail_without_changes:
        - name: "(6.2.8) Ensure users' home directories permissions are 750 or more restrictive: \

                {{ result['stdout'] }} \
                
                "
{% endif %}
