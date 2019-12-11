#  1.1.8 - 1.1.10 
#  1.1.8 Ensure nodev option set on /var/tmp partition
#  1.1.9 Ensure nosuid option set on /var/tmp partition
#  1.1.10 Ensure noexec option set on /var/tmp partition
# Description:
# The nodev mount option specifies that the filesystem cannot contain special devices.
# Since the /var/tmp filesystem is not intended to support devices, set this option to ensure
# that users cannot attempt to create block or character special devices in /var/tmp .

# The nosuid mount option specifies that the filesystem cannot contain setuid files.
# Since the /var/tmp filesystem is only intended for temporary file storage, set this option to
# ensure that users cannot create setuid files in /var/tmp .

# The noexec mount option specifies that the filesystem cannot contain executable binaries.
# Since the /var/tmp filesystem is only intended for temporary file storage, set this option to
# ensure that users cannot run executable binaries from /var/tmp .

{% set rule = '(1.1.8)' %}


{% if salt['mount.is_mounted']('/var/tmp') %}

    {% set options = salt['mount.fstab']()['/var/tmp']['opts'] %}
    {% if 'nosuid' in options and 'noexec' in options and 'nodev' in options %}

{{ rule }} /var/tmp nosuid,nodev,noexec:
    test.succeed_without_changes:
        - name: {{ rule }} /var/tmp already set with nosuid,noexec,nodev.

    {% else %}

{{ salt['mount.remount']('/var/tmp', 'tmpfs', 'True') }}

{{ rule }} /var/tmp nosuid,nodev,noexec:
    file.directory:
        - name: /var/tmp
        - mode: 1777
        - user: root
        - group: root

    {% endif %}

{% else %}
{{ rule }} /var/tmp nosuid,nodev,noexec:
    test.fail_without_changes:
        - name: {{ rule }} /var/tmp is not mounted as separate partition, unable to check nosuid,nodev,noexec.
{% endif %}
