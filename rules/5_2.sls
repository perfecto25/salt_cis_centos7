# 5.2.1 - Ensure permissions on /etc/ssh/sshd_config

(5.2.1) Ensure permissions on /etc/ssh/sshd_config are configured:
    file.managed:
        - name: /etc/ssh/sshd_config
        - mode: 600
        - user: root
        - group: root
        - replace: False

{% set rules = {
    '5.2.2': 'Protocol 2',
    '5.2.3': 'LogLevel INFO',
    '5.2.4': 'X11Forwarding no',
    '5.2.5': 'MaxAuthTries 3',
    '5.2.6': 'IgnoreRhosts yes',
    '5.2.7': 'HostbasedAuthentication no',
    '5.2.8': 'PermitRootLogin no',
    '5.2.9': 'PermitEmptyPassword no',
    '5.2.10': 'PermitUserEnvironment no',
    '5.2.11': 'ClientAliveInterval 300',
    '5.2.12': 'ClientAliveCountMax 0',
    '5.2.13': 'LoginGraceTime 60',
    '5.2.15': 'Banner /etc/issue.net'
}
%}

{% for number, rule in rules.iteritems() %}
{% if not salt['file.contains_regex']("/etc/ssh/sshd_config", rule) %}
({{ number }}) Ensure SSH configuration:
    test.fail_without_changes:
        - name: "({{ number }}) /etc/ssh/sshd_config does not have '{{ rule }}' entry"
{% endif %}
{% endfor %}