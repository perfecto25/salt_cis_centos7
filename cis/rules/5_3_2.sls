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

(5.3.2) Ensure lockout for failed password attempts are configured in /etc/pam.d/password-auth faillock:
    file.replace:
        - name: /etc/pam.d/password-auth
        - pattern: ^auth.*required.*pam_faillock.so.*preauth.*audit.*silent.*deny=5.*unlock_time=900
        - repl: auth    required    pam_faillock.so preauth audit   silent  deny=5  unlock_time=900
        - append_if_not_found: True

(5.3.2) Ensure lockout for failed password attempts are configured in /etc/pam.d/password-auth pam_unix:
    file.replace:
        - name: /etc/pam.d/password-auth
        - pattern: ^auth.*[success=1 default=bad].*pam_unix.so
        - repl: auth [success=1 default=bad] pam_unix.so
        - append_if_not_found: True

(5.3.2) Ensure lockout for failed password attempts are configured in /etc/pam.d/password-auth default=die:
    file.replace:
        - name: /etc/pam.d/password-auth
        - pattern: ^auth.*[default=die].*pam_faillock.so.*authfail.*audit.*deny=5.*unlock_time=900
        - repl: auth    [default=die]   pam_faillock.so authfail    audit   deny=5  unlock_time=900
        - append_if_not_found: True

(5.3.2) Ensure lockout for failed password attempts are configured in /etc/pam.d/password-auth authsucc:
    file.replace:
        - name: /etc/pam.d/password-auth
        - pattern: ^auth.*sufficient.*pam_faillock.so.*authsucc.*audit.*
        - repl: auth    sufficient  pam_faillock.so authsucc    audit   deny=5  unlock_time=900
        - append_if_not_found: True


(5.3.2) Ensure lockout for failed password attempts are configured in /etc/pam.d/system-auth faillock:
    file.replace:
        - name: /etc/pam.d/system-auth
        - pattern: ^auth.*required.*pam_faillock.so.*preauth.*audit.*silent.*deny=5.*unlock_time=900
        - repl: auth    required    pam_faillock.so preauth audit   silent  deny=5  unlock_time=900
        - append_if_not_found: True

(5.3.2) Ensure lockout for failed password attempts are configured in /etc/pam.d/system-auth pam_unix:
    file.replace:
        - name: /etc/pam.d/system-auth
        - pattern: ^auth.*[success=1 default=bad].*pam_unix.so
        - repl: auth [success=1 default=bad] pam_unix.so
        - append_if_not_found: True

(5.3.2) Ensure lockout for failed password attempts are configured in /etc/pam.d/system-auth default=die:
    file.replace:
        - name: /etc/pam.d/system-auth
        - pattern: ^auth.*[default=die].*pam_faillock.so.*authfail.*audit.*deny=5.*unlock_time=900
        - repl: auth    [default=die]   pam_faillock.so authfail    audit   deny=5  unlock_time=900
        - append_if_not_found: True

(5.3.2) Ensure lockout for failed password attempts are configured in /etc/pam.d/system-auth authsucc:
    file.replace:
        - name: /etc/pam.d/system-auth
        - pattern: ^auth.*sufficient.*pam_faillock.so.*authsucc.*audit.*
        - repl: auth    sufficient  pam_faillock.so authsucc    audit   deny=5  unlock_time=900
        - append_if_not_found: True
