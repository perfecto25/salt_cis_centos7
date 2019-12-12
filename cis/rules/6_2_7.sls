# 6.2.7 Ensure all users' home directories exist

# Description
# Users can be defined in /etc/passwd without a home directory or with a home directory
# that does not actually exist.

# Rationale:
# If the user's home directory does not exist or is unassigned, the user will be placed in "/"
# and will not be able to write any files or have local environment variables set.

{% set result = salt['cmd.script']('salt://{}/files/6_2_7'.format(slspath), cwd='/opt') %}

{% if result['stdout'] %}
(6.2.7) Ensure all users home directories exist:
    test.fail_without_changes:
        - name: "(6.2.7) Ensure all users' home directories exist: \n\n
        
        Following dirs do not exist: \

                {{ result['stdout'] }} \n
                       
                "
{% endif %}
