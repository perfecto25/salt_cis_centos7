# 3.4 TCP Wrappers

# 3.4.1 Ensure TCP Wrappers is installed
# Description:
# TCP Wrappers provides a simple access list and standardized logging method for services
# capable of supporting it. In the past, services that were called from inetd and xinetd
# supported the use of tcp wrappers. As inetd and xinetd have been falling in disuse, any
# service that can support tcp wrappers will have the libwrap.so library attached to it.
# Rationale:
# TCP Wrappers provide a good simple access list mechanism to services that may not have
# that support built in. It is recommended that all services that can support TCP Wrappers,

# 3.3.1 Ensure IPv6 router advertisements are not accepted
{% set rule = '(3.4.1)' %}
{{ rule }} Ensure tcpwrappers is installed:
    pkg.installed:
        - name: tcp_wrappers


#3.4.4 - 3.4.5 Ensure permissions on /etc/hosts.allow and deny are configured (Scored)
# The /etc/hosts.deny file contains network information that is used by many system
# applications and therefore must be readable for these applications to operate.
# Rationale:
# It is critical to ensure that the /etc/hosts.deny file is protected from unauthorized write
# access. Although it is protected by default, the file permissions could be changed either
# inadvertently or through malicious actions.
{% set rule = '(3.4.4)' %}
{{ rule }} Ensure permissions on /etc/hosts.allow are configured:
    file.managed:
        - name: /etc/hosts.allow
        - user: root
        - group: root
        - mode: 644
        - create: False
        - replace: False

{% set rule = '(3.4.5)' %}
{{ rule }} Ensure permissions on /etc/hosts.deny are configured:
    file.managed:
        - name: /etc/hosts.deny
        - user: root
        - group: root
        - mode: 644
        - create: False
        - replace: False
