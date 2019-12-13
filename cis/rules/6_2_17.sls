# 6.2.17 Ensure no duplicate GIDs exist
# 
# Description:
# Although the groupadd program will not let you create a duplicate Group ID (GID), it is
# possible for an administrator to manually edit the /etc/group file and change the GID field.
# Rationale:
# User groups must be assigned unique GIDs for accountability and to ensure appropriate
# access protections.

{% set result = salt['cmd.script']('salt://{}/files/6_2_17'.format(slspath), cwd='/opt') %}

{% if result['stdout'] %}
(6.2.17) Ensure no duplicate GIDs exist:
    test.fail_without_changes:
        - name: "(6.2.17) Ensure no duplicate GIDs exist: \

                {{ result['stdout'] }} \

        "
{% endif %}