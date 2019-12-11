# 1.1.13 Ensure separate partition exists for /home
# Description:
# The /home directory is used to support disk storage needs of local users.
# Rationale:
# If the system is intended to support local users, create a separate partition for the /home
# directory to protect against resource exhaustion and restrict the type of files that can be
# stored under /home .

{% set rule = '(1.1.13)' %}

{% if salt['mount.is_mounted']('/home') %}

{{ rule }} /home on separate partition:
    test.succeed_without_changes:
        - name: {{ rule }} /home is already mounted on separate partition.

{% else %}

{{ rule }} /home on separate partition:
    test.fail_without_changes:
        - name: {{ rule }} /home needs to be mounted on a separate partition.

{% endif %}