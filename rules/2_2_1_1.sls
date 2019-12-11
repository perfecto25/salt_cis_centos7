# 2.2.1.1 Ensure time synchronization is in use
# Description:
# ntp is a daemon which implements the Network Time Protocol (NTP). It is designed to
# synchronize system clocks across a variety of systems and use a source that is highly
# accurate. More information on NTP can be found at http://www.ntp.org. ntp can be
# configured to be a client and/or a server.
# This recommendation only applies if ntp is in use on the system.
# Rationale:
# If ntp is in use on the system proper configuration is vital to ensuring time synchronization
# is working properly.
{% set rule = '(2.2.1.1)' %}

{% set ntp = salt['cmd.run']('rpm -q ntp') %}
{% set chrony = salt['cmd.run']('rpm -q chrony') %}

{% if ntp == 'package ntp is not installed'  %}
{% if chrony == 'package chrony is not installed'  %}
{{ rule }} install Chrony:
    pkg.installed:  
        - name: chrony
{% else %}
# Configure Chrony options
{% set rule = '(2.2.1.3)' %}
{{ rule }} configure ntp.conf:
    file.replace:
        - name: /etc/chrony.conf
        - pattern: 'OPTIONS="-u chrony"'
        - repl: 'OPTIONS="-u chrony"'
        - append_if_not_found: True
{% endif %}
{% else %}
{% set rule = '(2.2.1.2)' %}
{{ rule }} configure ntp.conf restrict -4:
    file.replace:
        - name: /etc/ntp.conf
        - pattern: "^restrict -4 default kod nomodify notrap nopeer noquery"
        - repl: "restrict -4 default kod nomodify notrap nopeer noquery"
        - append_if_not_found: True 

{{ rule }} configure ntp.conf restrict -6:
    file.replace:
        - name: /etc/ntp.conf
        - pattern: "^restrict -6 default kod nomodify notrap nopeer noquery"
        - repl: "restrict -6 default kod nomodify notrap nopeer noquery"
        - append_if_not_found: True 

{% endif %}