# 2.1 Disable unnecessary services
# Description:
# inetd is a super-server daemon that provides internet services and passes connections to
# configured services. While not commonly used inetd and any unneeded inetd based
# services should be disabled if possible.

{% set rule = '(2.1)' %}

{% for svc in [
    'chargen-dgram', 
    'chargen-stream', 
    'daytime-dgram', 
    'daytime-stream', 
    'discard-dgram', 
    'discard-stream', 
    'echo-dgram', 
    'echo-stream', 
    'time-dgram', 
    'time-stream', 
    'tftp', 
    'xinetd' 
] %}

{% if svc not in salt['pillar.get']('cis:ignore:services') %}
{{ rule }} Disable xinetd service; {{ svc }}:
    service.disabled:
        - name: {{ svc }}
{% endif %}
{% endfor %}