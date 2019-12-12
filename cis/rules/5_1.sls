# 5.1.1 - Ensure cron daemon is enabled
# 5.1.2 - Ensure permissions on /etc/crontab are configured
# 5.1.3 - Ensure permissions on /etc/cron.hourly are configured
# 5.1.4 - Ensure permissions on /etc/cron.daily are configured
# 5.1.5 - Ensure permissions on /etc/cron.weekly are configured
# 5.1.6 - Ensure permissions on /etc/cron.monthly are configured
# 5.1.7 - Ensure permissions on /etc/cron.d are configured

(5.1.1) Ensure cron daemon is enabled:
    service.running:
        - name: crond
        - enable: True

(5.1.2) Ensure permissions on /etc/crontab are configured:
    file.managed:
        - name: /etc/crontab
        - mode: 600
        - user: root
        - group: root
        - replace: False

{% set rules = {
    'cron.hourly':  '5.1.3', 
    'cron.daily':   '5.1.4', 
    'cron.weekly':  '5.1.5', 
    'cron.monthly': '5.1.6', 
    'cron.d':       '5.1.7'
} %}

{% for rule,number in rules.iteritems() %}

({{ number }}) Ensure permissions on /etc/{{ rule }} are configured:
    file.directory:
        - name: /etc/{{ rule }}
        - dir_mode: 700
        - user: root
        - group: root
{% endfor %}

