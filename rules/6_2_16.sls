# 6.2.16 Ensure no duplicate UIDs exist

# Description:
# Although the useradd program will not let you create a duplicate User ID (UID), it is
# possible for an administrator to manually edit the /etc/passwd file and change the UID
# field.
# Rationale:
# Users must be assigned unique UIDs for accountability and to ensure appropriate access
# protections.

{% set result = salt['cmd.script']('salt://{}/files/6_2_16'.format(slspath), cwd='/opt') %}

{% if result['stdout'] %}
(6.2.16) Ensure no duplicate UIDs exist:
    test.fail_without_changes:
        - name: "(6.2.16) Ensure no duplicate UIDs exist: \

                {{ result['stdout'] }} \
                
        "
{% endif %}