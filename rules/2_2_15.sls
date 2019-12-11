# 2.2.15 Ensure mail transfer agent is configured for local-only mode
# Description:
# Mail Transfer Agents (MTA), such as sendmail and Postfix, are used to listen for incoming
# mail and transfer the messages to the appropriate user or mail server. If the system is not
# intended to be a mail server, it is recommended that the MTA be configured to only process
# local mail.
# Rationale:
# The software for all Mail Transfer Agents is complex and most have a long history of
# security issues. While it is important to ensure that the system can process local mail
# messages, it is not necessary to have the MTA's daemon listening on a port unless the
# server is intended to be a mail server that receives and processes mail from other systems.
{% set listen = salt['cmd.run_all'](cmd="netstat -an | grep LIST | grep ':25[[:space:]]' | awk '{print $4}' | awk -F':' '{print $1}' | tr -d '\\n'", python_shell=True)['stdout'] %}

{% set rule = '(2.2.15)' %}
{% if not listen == '127.0.0.1' %}
{{ rule }} update Postfix to listen on localhost:
    file.replace:
        - name: /etc/postfix/main.cf
        - pattern: "^inet_interfaces.*$"
        - repl: "inet_interfaces = loopback-only"
        - append_if_not_found: True 
        - onlyif: test -f /etc/postfix/main.cf

{{ rule }} restart postfix:
    service.running:
        - name: postfix
        - restart: True
        - watch:
            - file: /etc/postfix/main.cf

{% else %}
{{ rule }} Ensure mail transfer agent is configured for local-only mode:
    test.succeed_without_changes:
        - name: "{{ rule }} MTP agent listening on localhost"
{% endif %}