# 5.6 Ensure access to the su command is restricted

# Description:
# The su command allows a user to run a command or shell as another user. The program
# has been superseded by sudo , which allows for more granular control over privileged
# access. Normally, the su command can be executed by any user. By uncommenting the
# pam_wheel.so statement in /etc/pam.d/su , the su command will only allow users in the
# wheel group to execute su .
# Rationale:
# Restricting the use of su , and using sudo in its place, provides system administrators better
# control of the escalation of user privileges to execute privileged commands. The sudo utility
# also provides a better logging and audit mechanism, as it can log each command executed
# via sudo , whereas su can only record that a user executed the su program.

(5.6) Ensure access to the su command is restricted:
    file.replace:
        - name: /etc/pam.d/su
        - pattern: .*auth.*required.*pam_wheel.so.*use_uid
        - repl: auth    required    pam_wheel.so    use_uid
        - append_if_not_found: True
