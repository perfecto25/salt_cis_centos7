# 2.3 Service Clients
# A number of insecure services exist. While disabling the servers prevents a local attack
# against these services, it is advised to remove their clients unless they are required.

# 2.3.1 - 2.3.5   Ensure packages are not installed
{% set rule = '(2.3.1 - 2.3.5)' %}
{% for pkg in [
    'ypbind',
    'telnet',
    'rsh',
    'talk',
    'openldap-clients'
] %}
{% if pkg not in salt['pillar.get']('cis:ignore:packages') %}
{{ rule }} ensure package {{ pkg }} is not installed:
    pkg.removed:
        - name: {{ pkg }}
{% endif %}
{% endfor %}