# 1.1.21 Ensure sticky bit is set on all world-writable directories
# Description:
# Setting the sticky bit on world writable directories prevents users from deleting or
# renaming files in that directory that are not owned by them.
# Rationale:
# This feature prevents the ability to delete or rename files in world writable directories
# (such as /tmp ) that are owned by another user.


{% set rule = '(1.1.21)' %}

{% set sbit = salt['cmd.run_all'](cmd="df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null", python_shell=True) %}

{% if not sbit %}

{{ rule }} no world writeable directories found:
    test.succeed_without_changes:
        - name: {{ rule }} no world-writeable directories found.

{% else %}

{% set www_dirs = sbit['stdout'].split('\n') %}

{% for dir in www_dirs %}
{% if dir %}
{{ rule }} {{ dir }} set sticky bit:
    file.directory:
        - name: {{ dir }}
        - dir_mode: 1777
{% endif %}        
{% endfor %}

{% endif %}