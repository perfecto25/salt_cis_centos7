# 1.1.11 Ensure separate partition exists for /var/log
# Description:
# The /var/log directory is used by system services to store log data .
# Rationale:
# There are two important reasons to ensure that system logs are stored on a separate
# partition: protection against resource exhaustion (since logs can grow quite large) and
# protection of audit data.

{% set rule = '(1.1.11)' %}

{% if salt['mount.is_mounted']('/var/log') %}

{{ rule }} /var/log on separate partition:
    test.succeed_without_changes:
        - name: {{ rule }} /var/log is already mounted on separate partition.

{% else %}

{{ rule }} /var/log on separate partition:
    test.fail_without_changes:
        - name: {{ rule }} /var/log needs to be mounted on a separate partition.

{% endif %}