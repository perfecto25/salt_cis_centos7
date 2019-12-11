# 1.1.15 - 1.1.17 
#  1.1.15 Ensure nodev option set on /dev/shm partition
#  1.1.16 Ensure nosuid option set on /dev/shm partition
#  1.1.17 Ensure noexec option set on /dev/shm partition

# Description:
# The nodev mount option specifies that the filesystem cannot contain special devices.
# Rationale:
# Since the /dev/shm filesystem is not intended to support devices, set this option to ensure
# that users cannot attempt to create special devices in /dev/shm partitions.


# Description:
# The nosuid mount option specifies that the filesystem cannot contain setuid files.
# Rationale:
# Setting this option on a file system prevents users from introducing privileged programs
# onto the system and allowing non-root users to execute them.

# Description:
# The noexec mount option specifies that the filesystem cannot contain executable binaries.
# Rationale:
# Setting this option on a file system prevents users from executing programs from shared
# memory. This deters users from introducing potentially malicious software on the system.

{% set rule = '(1.1.15)' %}

{% if salt['mount.is_mounted']('/dev/shm') %}

    {% set options = salt['mount.active']()['/dev/shm']['opts'] %}
    {% if 'nosuid' in options and 'noexec' in options and 'nodev' in options %}

{{ rule }} /dev/shm nosuid,nodev,noexec:
    test.succeed_without_changes:
        - name: {{ rule }} /dev/shm already set with nosuid,noexec,nodev.

    {% else %}


{{ rule }} unmount /dev/shm:
    mount.unmounted:
        - name: tmpfs
        - device: /dev/shm    

{{ rule }} remount /dev/shm:
    mount.mounted:
        - name: /dev/shm
        - device: /dev/shm
        - fstype: tmpfs
        - mkmnt: True
        - opts:  defaults,nodev,noexec,nosuid
        - persist: True
        - user: root

    {% endif %}

{% else %}

{{ rule }} /dev/shm separate partition with nodev,nosuid,noexec:
    mount.mounted:
    - name: /dev/shm
    - device: tmpfs
    - fstype: tmpfs 
    - mkmnt: True
    - persist: True
    - user: root
    - opts:
        - defaults
        - nodev
        - nosuid
        - noexec

{% endif %}
