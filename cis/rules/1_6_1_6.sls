# 1.6.1.6 Ensure no unconfinded daemons exist
# Description:
# Daemons that are not defined in SELinux policy will inherit the security context of their
# parent process.
# Rationale:
# Since daemons are launched and descend from the init process, they will inherit the
# security context label initrc_t . This could cause the unintended consequence of giving
# the process more permission than it requires.

{% set rule = '(1.6.1.6)' %}

{% set retval = salt['cmd.run_all'](cmd="ps -eZ | egrep 'initrc' | egrep -vw 'tr|ps|egrep|bash|awk' | tr ':' ' ' |awk '{ print $NF }'", python_shell=True)['stdout'] %}


{% if not retval %}
{{ rule }} Ensure no unconfied daemons exist:
    test.succeed_without_changes:
        - name: "{{ rule }} No unconfined daemons exist"
{% else %}
{{ rule }} Ensure no unconfined daemons exist:
    test.fail_without_changes:
        - name: "{{ rule }} unconfined daemons found: {{ retval }} "
{% endif %}