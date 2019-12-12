# 5.3.4 - Ensure password hashing algorith is SHA-512

# Description:
# The commands below change password encryption from md5 to sha512 (a much stronger
# hashing algorithm). All existing accounts will need to perform a password change to
# upgrade the stored hashes to the new algorithm.

# Rationale:
# The SHA-512 algorithm provides much stronger hashing than MD5, thus providing
# additional protection to the system by increasing the level of effort for an attacker to
# successfully determine passwords.
# Note that these change only apply to accounts configured on the local system


(5.3.4) Ensure password hash is SHA-512 in password-auth:
    file.replace:
        - name: /etc/pam.d/password-auth
        - pattern: ^password.*sufficient.*pam_unix.so.*sha512
        - repl: password    sufficient  pam_unix.so sha512
        - append_if_not_found: True

(5.3.4) Ensure password hash is SHA-512 in system-auth:
    file.replace:
        - name: /etc/pam.d/system-auth
        - pattern: ^password.*sufficient.*pam_unix.so.*sha512
        - repl: password    sufficient  pam_unix.so sha512
        - append_if_not_found: True
