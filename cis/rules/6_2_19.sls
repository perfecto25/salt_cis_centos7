# 6.2.19 Ensure no duplicate group names exist

# Description:
# Although the groupadd program will not let you create a duplicate group name, it is
# possible for an administrator to manually edit the /etc/group file and change the group
# name.
# Rationale:
# If a group is assigned a duplicate group name, it will create and have access to files with the
# first GID for that group in /etc/group . Effectively, the GID is shared, which is a security
# problem.

{% set result = salt['cmd.script']('salt://{}/files/6_2_19'.format(slspath), cwd='/opt') %}

{% if result['stdout'] %}
(6.2.19) Ensure no duplicate group names exist:
    test.fail_without_changes:
        - name: "(6.2.19) Ensure no duplicate group names exist: \

                {{ result['stdout'] }} \

        "
{% endif %}