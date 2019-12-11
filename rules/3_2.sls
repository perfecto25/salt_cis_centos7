# 3.2 Network Parameters (Host and Router)
# The following network parameters are intended for use on both host only and router
# systems. A system acts as a router if it has at least two interfaces and is configured to
# perform routing functions.

# 3.2.1  Ensure source routed packets are not accepted
{% set rule = '(3.2.1)' %}
{{ rule }} Ensure source routed packets are not accepted (net.ipv4.conf.all.accept_source_route):
    sysctl.present:
        - name: net.ipv4.conf.all.accept_source_route
        - value: 0

{{ rule }} Ensure source routed packets are not accepted (net.ipv4.conf.default.accept_source_route):
    sysctl.present:
        - name: net.ipv4.conf.default.accept_source_route
        - value: 0

# 3.2.2  Ensure ICMP redirects are not accepted
{% set rule = '(3.2.2)' %}
{{ rule }} Ensure ICMP redirects are not accepted (net.ipv4.conf.all.accept_redirects):
    sysctl.present:
        - name: net.ipv4.conf.all.accept_redirects
        - value: 0

{{ rule }} Ensure ICMP redirects are not accepted (net.ipv4.conf.default.accept_redirects):
    sysctl.present:
        - name: net.ipv4.conf.default.accept_redirects
        - value: 0


# 3.2.3  Ensure secure ICMP redirects are not accepted
{% set rule = '(3.2.3)' %}
{{ rule }} Ensure secure ICMP redirects are not accepted (net.ipv4.conf.all.secure_redirects):
    sysctl.present:
        - name: net.ipv4.conf.all.secure_redirects
        - value: 0

{{ rule }} Ensure secure ICMP redirects are not accepted (net.ipv4.conf.default.secure_redirects):
    sysctl.present:
        - name: net.ipv4.conf.default.secure_redirects
        - value: 0

# 3.2.4 Ensure suspicious packets are logged
{% set rule = '(3.2.4)' %}
{{ rule }} Log suspicious packets (net.ipv4.conf.all.log_martians):
    sysctl.present:
        - name: net.ipv4.conf.all.log_martians
        - value: 1

{{ rule }} Log suspicious packets (net.ipv4.conf.default.log_martians):
    sysctl.present:
        - name: net.ipv4.conf.default.log_martians
        - value: 1

# 3.2.5 Ensure broadcast ICMP requests are ignored
{% set rule = '(3.2.5)' %}
{{ rule }} Ensure broadcast ICMP requests are ignored (net.ipv4.icmp_echo_ignore_broadcasts):
    sysctl.present:
        - name: net.ipv4.icmp_echo_ignore_broadcasts
        - value: 1

# 3.2.6 Ensure bogus ICMP responses are ignored
{% set rule = '(3.2.6)' %}
{{ rule }} Ensure bogus ICMP responses are ignored (net.ipv4.icmp_ignore_bogus_error_responses):
    sysctl.present:
        - name: net.ipv4.icmp_ignore_bogus_error_responses
        - value: 1
    
# 3.2.6 Ensure Reverse Path Filtering is enabled
{% set rule = '(3.2.7)' %}
{{ rule }} Ensure Reverse Path Filtering is enabled (net.ipv4.conf.all.rp_filter):
    sysctl.present:
        - name: net.ipv4.conf.all.rp_filter
        - value: 1

{{ rule }} Ensure Reverse Path Filtering is enabled (net.ipv4.conf.default.rp_filter):
    sysctl.present:
        - name: net.ipv4.conf.default.rp_filter
        - value: 1


# 3.2.8 Ensure TCP SYN Cookies is enabled
{% set rule = '(3.2.8)' %}
{{ rule }} Ensure TCP SYN Cookies is enabled (net.ipv4.tcp_syncookies):
    sysctl.present:
        - name: net.ipv4.tcp_syncookies
        - value: 1
