# 5.3.2 - Ensure lockout for failed password attempts is configured

# Description:
# Lock out users after n unsuccessful consecutive login attempts. The first sets of changes are
# made to the PAM configuration files. The second set of changes are applied to the program
# specific PAM configuration file. The second set of changes must be applied to each program
# that will lock out users. Check the documentation for each secondary program for
# instructions on how to configure them to work with PAM.
# Set the lockout number to the policy in effect at your site.

# Rationale:
# Locking out user IDs after n unsuccessful consecutive login attempts mitigates brute force
# password attacks against your system


{% set result = salt['cmd.script']('salt://{}/files/5_3_2'.format(slspath), cwd='/opt', args=opts['test']) %}

{% if result['stdout'] %}
(5.3.2) Ensure lockout for failed password attempts is configured:
    test.fail_without_changes:
        - name: "(5.3.2) Ensure lockout for failed password attempts is configured: \

                {{ result['stdout'] }} \

        "
{% endif %}
