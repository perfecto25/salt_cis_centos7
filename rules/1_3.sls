# 1.3.1 - 1.3.2  File System Integrity Checks

# 1.3.1 Ensure AIDE is installed
# Description:
# AIDE takes a snapshot of filesystem state including modification times, permissions, and
# file hashes which can then be used to compare against the current state of the filesystem to
# detect modifications to the system.
# Rationale:
# By monitoring the filesystem state compromised files can be detected to prevent or limit
# the exposure of accidental or malicious misconfigurations or modified binaries.
{% set rule = '(1.3.1)' %}

{% if salt['pkg.version']('aide') %}
{{ rule }} ensure AIDE package is installed:
    test.succeed_without_changes:
        - name: {{ rule }} AIDE package is installed
{% else %}
{{ rule }} ensure AIDE package is installed:
    pkg.installed:
        - name: aide
{% endif %}

# 1.3.2 Ensure filesystem integrity is regularly checked
# Description:
# Periodic checking of the filesystem integrity is needed to detect changes to the filesystem.
# Rationale:
# Periodic file checking allows the system administrator to determine on a regular basis if
# critical files have been changed in an unauthorized fashion.
{% set rule = '(1.3.2)' %}
{% set crons = salt['cron.list_tab']('root')['crons'] %}
{% set cron_present = 'no' %}

{% for cron in crons %}
{% if 'aide' in cron['cmd'] %}
    {% set cron_present = 'yes' %}
{% endif %}
{% endfor %}

{% if cron_present == 'yes' %}
{{ rule }} ensure filesystem integrity is checked:
    test.succeed_without_changes:
        - name: AIDE cron is present
{% else %}
{{ rule }} ensure filesystem integrity is checked:
    test.fail_without_changes:
        - name: AIDE cron is not present
{% endif %}