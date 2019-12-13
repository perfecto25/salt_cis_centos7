# 1.1.1 Disable unused filesystems

# *************************  1.1.1.1 - 1.1.1.8
# Ensure mounting of cramfs, freevxfs, jffs2, hfs, hfsplus, squashfs, udf, FAT filesystems is disabled
# Rationale:
# Removng support for unneeded filesystem types reduces the local attack surface of the
# system. If this filesystem type is not needed, disable it.

{% set rule = '(1.1.1)' %}

{% set filesystems = ['cramfs', 'freevxfs', 'jffs2', 'hfs', 'hfsplus', 'squashfs', 'udf', 'vfat'] %}

{% for fs in filesystems %}
{% if not fs in salt['pillar.get']('cis:ignore:filesystems') %}
{% set status = salt['cmd.run']('modprobe -n -v {}'.format(fs)) %}
{% if status == 'install /bin/true' %}

{{ rule }} {{ fs }} mounting is disabled:
    test.succeed_without_changes:
        - name: {{ rule }} {{ fs }} mounting is already disabled.

{% else %}

{{ rule }} {{ fs }} create modrobe blacklist:
    cmd.run:
        - name: touch /etc/modprobe.d/salt_cis.conf
        - unless: test -f /etc/modprobe.d/salt_cis.conf

{{ rule }} {{ fs }} disabled:
    file.replace:
        - name: /etc/modprobe.d/salt_cis.conf
        - pattern: "^install {{ fs }} /bin/true"
        - repl: install {{ fs }} /bin/true
        - append_if_not_found: True 
    cmd.run:
        - name: modprobe -r {{ fs }} && rmmod {{ fs }}
        - onlyif: "lsmod | grep {{ fs }}"

{% endif %}
{% endif %}
{% endfor %}
