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

{% set result = salt['cmd.script']('salt://{}/files/5_3_4'.format(slspath), cwd='/opt', args=opts['test']) %}

{% if result['stdout'] %}
(5.3.4) Ensure password hashing algorith is SHA-512:
    test.fail_without_changes:
        - name: "(5.3.4) Ensure password hashing algorith is SHA-512: \

                {{ result['stdout'] }} \

        "
{% endif %}
