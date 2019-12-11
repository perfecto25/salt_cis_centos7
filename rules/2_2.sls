# 2.2.2 - 2.2.4   Ensure packages are not installed
{% set rule = '(2.2.2 - 2.2.4)' %}
{% for pkg in [
    'xorg-x11-server-Xorg',
    'avahi-daemon',
    'cups'
] %}
{% if pkg not in salt['pillar.get']('cis_ignore:pkg') %}
{{ rule }} ensure package {{ pkg }} is not installed:
    pkg.removed:
        - name: {{ pkg }}
{% endif %}
{% endfor %}

# 2.2.5 -  Ensure services are disabled
{% set rule = '(2.2.5 - 2.2.21)' %}
{% for svc in [
    'dhcpd',
    'slapd',
    'nfs',
    'nfs-server',
    'rpcbind',
    'named',
    'vsftpd',
    'httpd',
    'dovecot',
    'smb',
    'squid',
    'snmpd',  
    'ypserv', 
    'rsh.socket',
    'rlogin.socket',
    'rexec.socket',
    'telnet.socket',
    'tftp.socket',
    'rsyncd',
    'ntalk'
] %}
{% if svc not in salt['pillar.get']('cis_ignore:service') %}
{{ rule }} Ensure services are disabled; {{ svc }}:
    service.disabled:
        - name: {{ svc }}
{% endif %}
{% endfor %}