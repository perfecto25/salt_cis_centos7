# 6.2.3 Ensure no legacy "+" entries exist in /etc/shadow

# Description:
# The character + in various files used to be markers for systems to insert data from NIS
# maps at a certain point in a system configuration file. These entries are no longer required
# on most systems, but may exist in files that have been imported from other platforms.
# Rationale:
# These entries may provide an avenue for attackers to gain privileged access on the system.

{% if salt['file.search']('/etc/shadow', '^\+') %}

(6.2.3) Ensure no legacy "+" entries exist in /etc/shadow:
    file.replace:
        - name: /etc/shadow
        - pattern: '^\+'
        - repl: ""
        - append_if_not_found: False

{% endif %}
