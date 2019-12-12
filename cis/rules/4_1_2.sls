# 4.1.2 Ensure auditd service is enabled

{% set rule = '(4.1.2)' %}
{{ rule }} auditd service enabled:
    service.enabled:
        - name: auditd
