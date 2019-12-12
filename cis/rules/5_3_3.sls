# 5.3.3 - Ensure password reuse is limited

# The /etc/security/opasswd file stores the users' old passwords and can be checked to
# ensure that users are not recycling recent passwords.

# Rationale:
# Forcing users not to reuse their past 5 passwords make it less likely that an attacker will be
# able to guess the password.


(5.3.3) Ensure password reuse is limited in /etc/pam.d/password-auth:
    file.replace:
        - name: /etc/pam.d/password-auth
        - pattern: ^password.*sufficient.*pam_unix.so.*remember=5
        - repl: password sufficient pam_unix.so remember=5
        - append_if_not_found: True

(5.3.3) Ensure password reuse is limited in /etc/pam.d/system-auth:
    file.replace:
        - name: /etc/pam.d/system-auth
        - pattern: ^password.*sufficient.*pam_unix.so.*remember=5
        - repl: password sufficient pam_unix.so remember=5
        - append_if_not_found: True
