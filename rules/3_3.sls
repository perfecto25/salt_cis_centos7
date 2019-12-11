# 3.3 IPv6
# IPv6 is a networking protocol that supersedes IPv4. It has more routable addresses and has
# built in security. If IPv6 is to be used, follow this section of the benchmark to configure
# IPv6, otherwise disable IPv6.

# 3.3.1 Ensure IPv6 router advertisements are not accepted
{% set rule = '(3.3.1)' %}
{{ rule }} Ensure IPv6 router advertisements are not accepted (net.ipv6.conf.all.accept_ra):
    sysctl.present:
        - name: net.ipv6.conf.all.accept_ra
        - value: 0

{{ rule }} Ensure IPv6 router advertisements are not accepted (net.ipv6.conf.default.accept_ra):
    sysctl.present:
        - name: net.ipv6.conf.default.accept_ra
        - value: 0

# 3.3.2 Ensure IPv6 redirects are not accepted
{% set rule = '(3.3.2)' %}
{{ rule }} Ensure IPv6 redirects are not accepted (net.ipv6.conf.all.accept_redirects):
    sysctl.present:
        - name: net.ipv6.conf.all.accept_redirects
        - value: 0

{{ rule }} Ensure IPv6 redirects are not accepted (net.ipv4.conf.default.accept_redirects):
    sysctl.present:
        - name: net.ipv4.conf.default.accept_redirects
        - value: 0


# 3.3.3 Ensure IPv6 is disabled
{% set rule = '(3.3.3)' %}
{{ rule }} Disable IPv6 from default kernel:
    file.replace:
        - name: /etc/default/grub
        - pattern: '^GRUB_CMDLINE_LINUX="ipv6.disable=1"'
        - repl: 'GRUB_CMDLINE_LINUX="ipv6.disable=1"'
        - append_if_not_found: True

{{ rule }} update grub:
    cmd.run:
        - name: grub2-mkconfig > /boot/grub2/grub.cfg
        - onchanges:
            - file: /etc/default/grub