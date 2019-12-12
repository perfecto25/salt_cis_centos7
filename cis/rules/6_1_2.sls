# 6.1.2 Ensure system file permissions


{% set rules = {
    '6.1.2': ['/etc/passwd', '644'],
    '6.1.3': ['/etc/shadow', '000'],
    '6.1.4': ['/etc/group', '644'],
    '6.1.5': ['/etc/gshadow', '000'],
    '6.1.6': ['/etc/passwd-', '644'],
    '6.1.7': ['/etc/shadow-', '000'],
    '6.1.8': ['/etc/group-', '644'],
    '6.1.7': ['/etc/gshadow-', '000']
} 
%}

{% for number, rule in rules.iteritems() %}
({{ number }}) Ensure permissions on {{ rule[0] }} are configured:
    file.managed:
        - name: {{ rule[0] }}
        - user: root
        - group: root
        - mode: {{ rule[1] }}
        - create: False
        - replace: False
{% endfor %}
