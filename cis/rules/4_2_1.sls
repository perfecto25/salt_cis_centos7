# 4.2.1 configure rsyslog
# 4.2.1.1 Ensure rsyslog Service is enabled
# 4.2.1.2 Ensure logging is configured
# 4.2.3 Ensure rsyslog installed

(4.2.1.1) rsyslog service enabled:
    service.enabled:
        - name: rsyslog

(4.2.1.2) rsyslog conf:
    file.managed:
        - name: /etc/rsyslog.d/salt.conf
        - source: salt://{{ slspath }}/files/4_2_rsyslog
        - user: root
        - group: root
        - mode: 644

(4.2.1.2) rsyslog service running:
    service.running:
        - name: rsyslog
        - watch:
            - file: /etc/rsyslog.d/salt.conf

(4.2.3) rsyslog package installed:
    pkg.installed:
        - name: rsyslog