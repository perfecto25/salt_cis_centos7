# 1.6.2 Ensure SELinux is installed
# Description:
# SELinux provides Mandatory Access Controls.
# Rationale:
# Without a Mandatory Access Control system installed only the default Discretionary Access
# Control system will be available.

{% set rule = '(1.6.2)' %}

{{ rule }} install SELinux pkg:
    pkg.installed:
        - name: libselinux
