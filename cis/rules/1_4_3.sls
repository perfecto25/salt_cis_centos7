# 1.4.3 Ensure authentication required for single user mode
# Description:
# Single user mode (rescue mode) is used for recovery when the system detects an issue
# during boot or by manual selection from the bootloader.
# Rationale:
# Requiring authentication in single user mode (rescue mode) prevents an unauthorized user
# from rebooting the system into single user to gain root privileges without credentials.

{% set rule = '(1.4.3)' %}

{{ rule }} Ensure authentication required for single user mode - Rescue:
    file.replace:
        - name: /usr/lib/systemd/system/rescue.service
        - pattern: "^ExecStart=.*"
        - repl: ExecStart=-/bin/sh -c "/sbin/sulogin; /usr/bin/systemctl --fail --no-block default"
        - append_if_not_found: True 
    
{{ rule }} Ensure authentication required for single user mode - Emergency:
    file.replace:
        - name: /usr/lib/systemd/system/emergency.service
        - pattern: "^ExecStart=.*"
        - repl: ExecStart=-/bin/sh -c "/sbin/sulogin; /usr/bin/systemctl --fail --no-block default"
        - append_if_not_found: True 