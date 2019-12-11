# 1.1.7 Ensure separate partition exists for /var/tmp
# Description:
# The /var/tmp directory is a world-writable directory used for temporary storage by all
# users and some applications.

# Rationale:
# Since the /var/tmp directory is intended to be world-writable, there is a risk of resource
# exhaustion if it is not bound to a separate partition. In addition, making /var/tmp its own
# file system allows an administrator to set the noexec option on the mount, making
# /var/tmp useless for an attacker to install executable code. It would also prevent an
# attacker from establishing a hardlink to a system setuid program and wait for it to be
# updated. Once the program was updated, the hardlink would be broken and the attacker
# would have his own copy of the program. If the program happened to have a security
# vulnerability, the attacker could continue to exploit the known flaw.

{% set rule = '(1.1.7)' %}

{% if salt['mount.is_mounted']('/var/tmp') %}

{{ rule }} /var/tmp on separate partition:
    test.succeed_without_changes:
        - name: {{ rule }} /var/tmp is already mounted on separate partition.

{% else %}

{{ rule }} /var/tmp on separate partition:
    test.fail_without_changes:
        - name: {{ rule }} /var/tmp needs to be mounted on a separate partition.

{% endif %}