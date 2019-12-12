# 6.2.9 Ensure users own their home directories

# Description:
# The user home directory is space defined for the particular user to set local environment
# variables and to store personal files.

# Rationale:
# Since the user is accountable for files stored in the user home directory, the user must be
# the owner of the directory.

{% set result = salt['cmd.script']('salt://{}/files/6_2_9'.format(slspath), cwd='/opt') %}

{% if result['stdout'] %}
(6.2.9) Ensure users own their home directories:
    test.fail_without_changes:
        - name: "(6.2.9) Ensure users own their home directories: \

                {{ result['stdout'] }} \
                
        "
{% endif %}
