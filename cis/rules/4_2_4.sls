# 4.2.4 Ensure permissions on all logfiles are configured

{% set result = salt['cmd.script']('salt://{}/files/4_2_4'.format(slspath), cwd='/opt', args=opts['test']) %}

{% if result['stdout'] %}
(4.2.4) ensure proper permissions on log files:
    test.fail_without_changes:
        - name: "(4.2.4) Ensure proper permissions on log files: \

                {{ result['stdout'] }} \
                
        "
{% endif %}