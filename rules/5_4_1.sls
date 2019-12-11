# 5.4.1.1 Ensure password expiration is 365 days or less
# 5.4.1.2 Ensure minimum days between password changes is 7 or more
# 5.4.1.3 Ensure password expiration warning days is 7 or more
# 5.4.1.4 Ensure inactive password lock is 30 days or less

(5.4.1.1) Ensure password expiration is 365 days or less:
    file.replace:
        - name: /etc/login.defs
        - pattern: ^PASS_MAX_DAYS.*
        - repl: PASS_MAX_DAYS   90
        - append_if_not_found: True

(5.4.1.2) Ensure minimum days between changes is 7 or more:
    file.replace:
        - name: /etc/login.defs
        - pattern: ^PASS_MIN_DAYS.*
        - repl: PASS_MIN_DAYS   7
        - append_if_not_found: True

(5.4.1.3) Ensure password expiration warning days is 7 or more:
    file.replace:
        - name: /etc/login.defs
        - pattern: ^PASS_WARN_AGE.*
        - repl: PASS_WARN_AGE   7
        - append_if_not_found: True

{% set inactive = salt['cmd.run_all'](cmd="useradd -D | grep INACTIVE | awk -F= {'print $2'}", python_shell=True) %}
{% if inactive['stdout'] | int > 30 %}
(5.4.1.4) Ensure inactive password lock is 30 days or less:
    cmd.run:
        - name: useradd -D -f 30
{% endif %}

