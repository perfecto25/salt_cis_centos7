# 3.5 Uncommon Network Protocols

# The Linux kernel modules support several network protocols that are not commonly used.
# If these protocols are not needed, it is recommended that they be disabled in the kernel.
# Note: This should not be considered a comprehensive list of uncommon network protocols,
# you may wish to consider additions to those listed here for your environment.

{% set rule = '(3.5.1 - 3.5.4)' %}

{% set protocols = ['dccp', 'sctp', 'rds', 'tipc'] %}

{% for pr in protocols %}

{% set status = salt['cmd.run']('modprobe -n -v {}'.format(pr)) %}

{% if status == 'install /bin/true' %}

{{ rule }} {{ pr }} mounting is disabled:
    test.succeed_without_changes:
        - name: {{ rule }} {{ pr }} protocol is already disabled.

{% else %}

{{ rule }} {{ pr }} create modrobe blacklist:
    cmd.run:
        - name: touch /etc/modprobe.d/salt_cis.conf
        - unless: test -f /etc/modprobe.d/salt_cis.conf

{{ rule }} {{ pr }} disabled:
    file.replace:
        - name: /etc/modprobe.d/salt_cis.conf
        - pattern: "^install {{ pr }} /bin/true"
        - repl: install {{ pr }} /bin/true
        - append_if_not_found: True 
    cmd.run:
        - name: modprobe -r {{ pr }} && rmmod {{ pr }}
        - onlyif: "lsmod | grep {{ pr }}"

{% endif %}

{% endfor %}
