# 1.5.1 Ensure core dumps are restricted
# Description:
# A core dump is the memory of an executable program. It is generally used to determine
# why a program aborted. It can also be used to glean confidential information from a core
# file. The system provides the ability to set a soft limit for core dumps, but this can be
# overridden by the user.
# Rationale:
# Setting a hard limit on core dumps prevents users from overriding the soft variable. If core
# dumps are required, consider setting limits for user groups (see limits.conf(5) ). In
# addition, setting the fs.suid_dumpable variable to 0 will prevent setuid programs from
# dumping core.

{% set rule = '(1.5.1)' %}

{{ rule }} Core dump restrict:
    file.replace:
        - name: /etc/security/limits.conf
        - pattern: /^\* hard core 0/
        - repl: '* hard core 0'
        - append_if_not_found: True 

{{ rule }} Core dump dumpable:
    file.replace:
        - name: /etc/security/limits.conf
        - pattern: /^\fs.suid_dumpable = 0/
        - repl: 'fs.suid_dumpable = 0'
        - append_if_not_found: True

{{ rule }} Core dump dumpable sysctl:
    sysctl.present:
        - name: fs.suid_dumpable
        - value: 0