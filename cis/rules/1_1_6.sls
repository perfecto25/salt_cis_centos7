# 1.1.6 Ensure separate partition exists for /var
# Description:
# The /var directory is used by daemons and other system services to temporarily store
# dynamic data. Some directories created by these processes may be world-writable.

# Rationale:
# Since the /var directory may contain world-writable files and directories, there is a risk of
# resource exhaustion if it is not bound to a separate partition.

{% set rule = '(1.1.6)' %}

{% if salt['mount.is_mounted']('/var') %}

{{ rule }} /var on separate partition:
    test.succeed_without_changes:
        - name: {{ rule }} /var is already mounted on separate partition.

{% else %}

{{ rule }} /var on separate partition:
    test.fail_without_changes:
        - name: {{ rule }} /var needs to be mounted on a separate partition.

{% endif %}