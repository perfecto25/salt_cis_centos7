# 1.2.2 - 1.2.3  GPG Checks

# 1.2.2 Ensure GPG keys are configured
# Description:
# Most packages managers implement GPG key signing to verify package integrity during
# installation.
# Rationale:
# It is important to ensure that updates are obtained from a valid source to protect against
# spoofing that could lead to the inadvertent installation of malware on the system.
{% set rule = '(1.2.2)' %}
{{ rule }} ensure GPG keys are configured:
    cmd.run:
        - name: "rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n'"


# 1.2.3 Ensure GPG check is globally activated
# Description:
# The gpgcheck option, found in the main section of the /etc/yum.conf and individual
# /etc/yum/repos.d/* files determines if an RPM package's signature is checked prior to its
# installation.
# Rationale:
# It is important to ensure that an RPM's package signature is always checked prior to
# installation to ensure that the software is obtained from a trusted source.
{% set rule = '(1.2.3)' %}
{{ rule }} GPG check globally activated:
    file.line:
        - name: /etc/yum.conf
        - content: 'gpgcheck=1'
        - match: /^gpgcheck=0$/
        - mode: Replace

{% set yumfiles = '/etc/yum.repos.d' | list_files %}

{% for file in yumfiles %}
{% if not file == '/etc/yum.repos.d' %}
"{{ rule }} GPG check activated on {{ file }}":
    file.replace:
        - name: "{{ file }}"
        - pattern: 'gpgcheck=0'
        - repl: 'gpgcheck=1'
        - append_if_not_found: True
        
{% endif %}
{% endfor %}

