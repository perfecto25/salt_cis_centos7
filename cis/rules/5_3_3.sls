# 5.3.3 - Ensure password reuse is limited

# The /etc/security/opasswd file stores the users' old passwords and can be checked to
# ensure that users are not recycling recent passwords.

# Rationale:
# Forcing users not to reuse their past 5 passwords make it less likely that an attacker will be
# able to guess the password.


{% set result = salt['cmd.script']('salt://{}/files/5_3_3'.format(slspath), cwd='/opt', args=opts['test']) %}

{% if result['stdout'] %}
(5.3.3) Ensure password reuse is limited in /etc/pam.d/password and system auth:
    test.fail_without_changes:
        - name: "(5.3.3) Ensure password reuse is limited in /etc/pam.d/password and system auth: \

                {{ result['stdout'] }} \

        "
{% endif %}