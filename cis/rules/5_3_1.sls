# 5.3.1 - Ensure password creation requirements are configured

#  The pam_pwquality.so module checks the strength of passwords. It performs checks such
#  as making sure a password is not a dictionary word, it is a certain length, contains a mix of
#  characters (e.g. alphabet, numeric, other) and more. The following are definitions of the
#  pam_pwquality .so options.
#  - try_first_pass - retrieve the password from a previous stacked PAM module. If not available, then prompt the user for a password.
#  - retry=3 - Allow 3 tries before sending back a failure.

#  The following options are set in the /etc/security/pwquality.conf file:
#  - minlen = 14 - password must be 14 characters or more
#  - dcredit = -1 - provide at least one digit
#  - ucredit = -1 - provide at least one uppercase character
#  - ocredit = -1 - provide at least one special character
#  - lcredit = -1 - provide at least one lowercase character
#  The settings shown above are one possible policy. Alter these values to conform to your
#  own organization's password policies.

{% set result = salt['cmd.script']('salt://{}/files/5_3_1'.format(slspath), cwd='/opt', args=opts['test']) %}

{% if result['stdout'] %}
(5.3.1) Ensure password creation requirements are configured in /etc/pam.d/password-auth:
    test.fail_without_changes:
        - name: "(5.3.1) Ensure password creation requirements are configured in /etc/pam.d/password-auth: \

                {{ result['stdout'] }} \

        "
{% endif %}

(5.3.1) Ensure password creation requirements are configured for minlen:
    file.replace:
        - name: /etc/security/pwquality.conf
        - pattern: ^minlen = 14
        - repl: minlen = 14
        - append_if_not_found: True

(5.3.1) Ensure password creation requirements are configured for dcredit:
    file.replace:
        - name: /etc/security/pwquality.conf
        - pattern: ^dcredit = -1
        - repl: dcredit = -1
        - append_if_not_found: True

(5.3.1) Ensure password creation requirements are configured for ucredit:
    file.replace:
        - name: /etc/security/pwquality.conf
        - pattern: ^ucredit = -1
        - repl: ucredit = -1
        - append_if_not_found: True

(5.3.1) Ensure password creation requirements are configured for ocredit:
    file.replace:
        - name: /etc/security/pwquality.conf
        - pattern: ^ocredit = -1
        - repl: ocredit = -1
        - append_if_not_found: True

(5.3.1) Ensure password creation requirements are configured for lcredit:
    file.replace:
        - name: /etc/security/pwquality.conf
        - pattern: ^lcredit = -1
        - repl: lcredit = -1
        - append_if_not_found: True