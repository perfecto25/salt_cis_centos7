#  1.1.22 Disable Automounting
# Description:
# autofs allows automatic mounting of devices, typically including CD/DVDs and USB drives.
# Rationale:
# With automounting enabled anyone with physical access could attach a USB drive or disc
# and have its contents available in system even if they lacked permissions to mount it
# themselves.

{% set rule = '(1.1.22)' %}

{% if salt['service.enabled']('autofs') %}

{{ rule }} disable automounting:
    service.disabled:
        - name: autofs

{% else %}

{{ rule }} disable automounting:
    test.succeed_without_changes:
        - name: {{ rule }} automounting of devices is already disabled.

{% endif %}