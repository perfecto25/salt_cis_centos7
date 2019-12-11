# 1.1.2 Ensure separate partition exists for /tmp
# Description:
# The /tmp directory is a world-writable directory used for temporary storage by all users
# and some applications.

# Rationale:
# Since the /tmp directory is intended to be world-writable, there is a risk of resource
# exhaustion if it is not bound to a separate partition. In addition, making /tmp its own file
# system allows an administrator to set the noexec option on the mount, making /tmp useless
# for an attacker to install executable code. It would also prevent an attacker from
# establishing a hardlink to a system setuid program and wait for it to be updated. Once the
# program was updated, the hardlink would be broken and the attacker would have his own
# copy of the program. If the program happened to have a security vulnerability, the attacker
# could continue to exploit the known flaw

{% set rule = '(1.1.2)' %}

{% if salt['mount.is_mounted']('/tmp') %}

{{ rule }} /tmp on separate partition:
    test.succeed_without_changes:
        - name: {{ rule }} /tmp is already mounted on separate partition.

{% else %}

{{ rule }} tmp mount unmask:
    service.unmasked:
        - name: tmp.mount

{{ rule }} tmp mount enabled:
    service.enabled:
        - name: tmp.mount

{{ rule }} tmp mount config:
    file.managed:
        - name: /etc/systemd/system/local-fs.target.wants/tmp.mount
        - source: salt://{{ slspath }}/files/1_1_2_tmp_mount
        - user: root
        - group: root
        - mode: 644

{{ rule }} /tmp on separate partition:
    mount.mounted:
    - name: /tmp
    - device: tmpfs
    - fstype: tmpfs 
    - mkmnt: True
    - persist: True
    - opts:
        - nodev
        - nosuid
        - noexec
{% endif %}