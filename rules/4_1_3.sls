# 4.1.3 Ensure auditing for processes that start prior to auditd is enabled
# Description:
# Configure grub so that processes that are capable of being audited can be audited even if
# they start up prior to auditd startup.
# Rationale:
# Audit events need to be captured on processes that start up prior to auditd , so that
# potential malicious activity cannot go undetected.

{% set rule = '(4.1.3)' %}
{% if salt['file.search']('/etc/default/grub', '^GRUB_CMDLINE_LINUX="audit=1"') %}

{{ rule }} Ensure auditing for processes that start prior to audit is enabled:
    test.succeed_without_changes:
        - name: {{ rule }} Auditing enabled for processes that start prior to auditd
{% else %}


# 4.1.1.3 Ensure audit logs are not automatically deleted
{% set rule = '(4.1.3)' %}
{{ rule }} Ensure auditing for processes that start prior to audit is enabled:
    file.replace:
        - name: /etc/default/grub
        - pattern: '^GRUB_CMDLINE_LINUX="audit=1"'
        - repl: 'GRUB_CMDLINE_LINUX="audit=1"'
        - append_if_not_found: True
    cmd.run:
        - name: grub2-mkconfig -o /boot/grub2/grub.cfg
{% endif %}
