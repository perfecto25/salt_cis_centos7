# 1.1.12 Ensure separate partition exists for /var/log/audit
# Description:
# The auditing daemon, auditd , stores log data in the /var/log/audit directory.
# Rationale:
# There are two important reasons to ensure that data gathered by auditd is stored on a
# separate partition: protection against resource exhaustion (since the audit.log file can
# grow quite large) and protection of audit data. The audit daemon calculates how much free
# space is left and performs actions based on the results. If other processes (such as syslog )
# consume space in the same partition as auditd , it may not perform as desired.

{% set rule = '(1.1.12)' %}

{% if salt['mount.is_mounted']('/var/log/audit') %}

{{ rule }} /var/log/audit on separate partition:
    test.succeed_without_changes:
        - name: {{ rule }} /var/log/audit is already mounted on separate partition.

{% else %}

{{ rule }} /var/log/audit on separate partition:
    test.fail_without_changes:
        - name: {{ rule }} /var/log/audit needs to be mounted on a separate partition.

{% endif %}