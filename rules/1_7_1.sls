# 1.7.1.1 Ensure message of the day is configured properly
# Description:
# The contents of the /etc/motd file are displayed to users after login and function as a
# message of the day for authenticated users.
# Unix-based systems have typically displayed information about the OS release and patch
# level upon logging in to the system. This information can be useful to developers who are
# developing software for a particular OS platform. If mingetty(8) supports the following
# options, they display operating system information: \m - machine architecture \r -
# operating system release \s - operating system name \v - operating system version
# Rationale:
# Warning messages inform users who are attempting to login to the system of their legal
# status regarding the system and must include the name of the organization that owns the
# system and any monitoring policies that are in place. Displaying OS and patch level
# information in login banners also has the side effect of providing detailed system
# information to attackers attempting to target specific exploits of a system. Authorized users
# can easily get this information by running the " uname -a " command once they have logged in

{% set rule = '(1.7.1.1)' %}
{% set flags = ['\\v', '\m', '\s', '\\r'] %}
{% for flag in flags %}
{% if salt['file.contains']("/etc/motd", flag) %}
{{ rule }} Ensure /etc/motd is configured correctly ({{ flag }}):
    test.fail_without_changes:
        - name: "{{ rule }} /etc/motd contains OS release information"
{% endif %}
{% endfor %}



# 1.7.1.2 Ensure local login warning banner is configured properly
# Description:
# The contents of the /etc/issue file are displayed to users prior to login for local terminals.
# Unix-based systems have typically displayed information about the OS release and patch
# level upon logging in to the system. This information can be useful to developers who are
# developing software for a particular OS platform. If mingetty(8) supports the following
# options, they display operating system information: \m - machine architecture \r -
# operating system release \s - operating system name \v - operating system version
# Rationale:
# Warning messages inform users who are attempting to login to the system of their legal
# status regarding the system and must include the name of the organization that owns the
# system and any monitoring policies that are in place. Displaying OS and patch level
# information in login banners also has the side effect of providing detailed system
# information to attackers attempting to target specific exploits of a system. Authorized users
# can easily get this information by running the " uname -a " command once they have logged
# in
{% set rule = '(1.7.1.2)' %}
{% set flags = ['\\v', '\m', '\s', '\\r'] %}
{% for flag in flags %}
{% if salt['file.contains']("/etc/issue", flag) %}
{{ rule }} Ensure /etc/issue is configured correctly ({{ flag }}):
    test.fail_without_changes:
        - name: "{{ rule }} /etc/issue contains OS release information"
{% endif %}
{% endfor %}


# 1.7.1.3 Ensure remote login warning banner is configured properly
# Description:
# The contents of the /etc/issue.net file are displayed to users prior to login for remote
# connections from configured services.
# Unix-based systems have typically displayed information about the OS release and patch
# level upon logging in to the system. This information can be useful to developers who are
# developing software for a particular OS platform. If mingetty(8) supports the following
# options, they display operating system information: \m - machine architecture \r -
# operating system release \s - operating system name \v - operating system version
# Rationale:
# Warning messages inform users who are attempting to login to the system of their legal
# status regarding the system and must include the name of the organization that owns the
# system and any monitoring policies that are in place. Displaying OS and patch level
# information in login banners also has the side effect of providing detailed system
# information to attackers attempting to target specific exploits of a system. Authorized users
# can easily get this information by running the " uname -a " command once they have logged
# in.
{% set rule = '(1.7.1.3)' %}
{% set flags = ['\\v', '\m', '\s', '\\r'] %}
{% for flag in flags %}
{% if salt['file.contains']("/etc/issue.net", flag) %}
{{ rule }} Ensure /etc/issue.net is configured correctly ({{ flag }}):
    test.fail_without_changes:
        - name: "{{ rule }} /etc/issue.net contains OS release information"
{% endif %}
{% endfor %}


# 1.7.1.4 Ensure permissions on /etc/motd are configured (Not Scored)
# Description:
# The contents of the /etc/motd file are displayed to users after login and function as a
# message of the day for authenticated users.
# Rationale:
# If the /etc/motd file does not have the correct ownership it could be modified by
# unauthorized users with incorrect or misleading information.
{% set rule = '(1.7.1.4)' %}
{{ rule }} Ensure permissions on /etc/motd are configured:
    file.managed:
        - name: /etc/motd
        - user: root
        - group: root
        - mode: 644
        - create: False
        - replace: False

# 1.7.1.5 Ensure permissions on /etc/issue are configured
# Description:
# The contents of the /etc/issue file are displayed to users prior to login for local terminals.
# Rationale:
# If the /etc/issue file does not have the correct ownership it could be modified by
# unauthorized users with incorrect or misleading information.
{% set rule = '(1.7.1.5)' %}
{{ rule }} Ensure permissions on /etc/issue are configured:
    file.managed:
        - name: /etc/issue
        - user: root
        - group: root
        - mode: 644
        - create: False
        - replace: False

# 1.7.1.6 Ensure permissions on /etc/issue.net are configured
# Description:
# The contents of the /etc/issue.net file are displayed to users prior to login for remote
# connections from configured services.
# Rationale:
# If the /etc/issue.net file does not have the correct ownership it could be modified by
# unauthorized users with incorrect or misleading information.
{% set rule = '(1.7.1.6)' %}
{{ rule }} Ensure permissions on /etc/issue.net are configured:
    file.managed:
        - name: /etc/issue.net
        - user: root
        - group: root
        - mode: 644
        - create: False
        - replace: False
