# 1.1.14 Ensure nodev option set on /home 
# Description:
# The nodev mount option specifies that the filesystem cannot contain special devices.
# Rationale:
# Since the user partitions are not intended to support devices, set this option to ensure that
# users cannot attempt to create block or character special devices.

{% set rule = '(1.1.14)' %}

{% if salt['mount.is_mounted']('/home') %}

    {% set options = salt['mount.fstab']()['/home']['opts'] %}
    {% if 'nodev' in options %}

{{ rule }} /home nodev:
    test.succeed_without_changes:
        - name: {{ rule }} /home already set with nodev.

    {% else %}

{{ rule }} /home nodev:
    test.fail_without_changes:
        - name: {{ rule }} /home is not set with nodev option.
    
    {% endif %}

{% else %}

{{ rule }} /home nodev:
    test.fail_without_changes:
        - name: {{ rule }} /home is not mounted on separate partition, unable to check nodev.

{% endif %}
