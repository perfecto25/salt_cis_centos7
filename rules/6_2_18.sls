# 6.2.18 Ensure no duplicate user names exist

# Description:
# Although the useradd program will not let you create a duplicate user name, it is possible
# for an administrator to manually edit the /etc/passwd file and change the user name.
# Rationale:
# If a user is assigned a duplicate user name, it will create and have access to files with the
# first UID for that username in /etc/passwd . For example, if "test4" has a UID of 1000 and a
# subsequent "test4" entry has a UID of 2000, logging in as "test4" will use UID 1000.
# Effectively, the UID is shared, which is a security problem.

{% set result = salt['cmd.script']('salt://{}/files/6_2_18'.format(slspath), cwd='/opt') %}

{% if result['stdout'] %}
(6.2.18) Ensure no duplicate user names exist:
    test.fail_without_changes:
        - name: "(6.2.18) Ensure no duplicate user names exist: \

                {{ result['stdout'] }} \
                
        "
{% endif %}