# 4.1 Configure System Accounting
# System auditing, through auditd , allows system administrators to monitor their systems
# such that they can detect unauthorized access or modification of data. By default, auditd
# will audit SELinux AVC denials, system logins, account modifications, and authentication
# events. Events will be logged to /var/log/audit/audit.log . The recording of these events
# will use a modest amount of disk space on a system. If significantly more events are
# captured, additional on system or off system storage may need to be allocated.
# The recommendations in this section implement an audit policy that produces large
# quantities of logged data. In some environments it can be challenging to store or process
# these logs and as such they are marked as Level 2 for both Servers and Workstations. Note:
# For 64 bit systems that have arch as a rule parameter, you will need two rules: one for 64
# bit and one for 32 bit systems. For 32 bit systems, only one rule is needed.

# 4.1.1.1 Ensure audit log storage size is configured
{% set rule = '(4.1.1.1)' %}
{% if not salt['file.contains']('/etc/audit/auditd.conf', 'max_log_file') %}
{{ rule }} Ensure audit log storage size is configured:
    test.fail_without_changes:
        - name: "{{ rule }} /etc/audit/auditd.conf has no setting for: 'max_log_file'"
{% endif %}


# 4.1.1.2 Ensure system is disabled when audit logs are full
{% set rule = '(4.1.1.2)' %}
{{ rule }} Audit space_left_action:
    file.replace:
        - name: /etc/audit/auditd.conf
        - pattern: '^space_left_action = .*'
        - repl: 'space_left_action = {{ salt['pillar.get']('cis:default:auditd:space_left_action', 'email') }}'
        - append_if_not_found: True

{{ rule }} Audit action_mail_acct:
    file.replace:
        - name: /etc/audit/auditd.conf
        - pattern: '^action_mail_acct = .*'
        - repl: "action_mail_acct = {{ salt['pillar.get']('cis:default:action_mail_acct', 'root') }}"
        - append_if_not_found: True

{{ rule }} Audit admit space left action:
    file.replace:
        - name: /etc/audit/auditd.conf
        - pattern: '^admin_space_left_action = .*'
        - repl: "admin_space_left_action = {{ salt['pillar.get']('cis:default:auditd:admin_space_left_action', 'halt') }}"
        - append_if_not_found: True

# 4.1.1.3 Ensure audit logs are not automatically deleted
{% set rule = '(4.1.1.3)' %}
{{ rule }} Ensure audit logs are not automatically deleted:
    file.replace:
        - name: /etc/audit/auditd.conf
        - pattern: '^max_log_file_action = .*'
        - repl: "max_log_file_action = {{ salt['pillar.get']('cis:default:auditd:max_log_file_action', 'keep_logs') }}"
        - append_if_not_found: True