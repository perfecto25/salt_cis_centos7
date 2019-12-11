# 6.2.14 Ensure no users have .rhosts files 

# Description:
# While no .rhosts files are shipped by default, users can easily create t hem.
# Rationale:
# This action is only meaningful if .rhosts support is permitted in the file /etc/pam.conf .
# Even though the .rhosts files are ineffective if support is disabled in /etc/pam.conf , they
# may have been brought over from other systems and could contain information useful to
# an attacker for those other systems.

{% set result = salt['cmd.script']('salt://{}/files/6_2_14'.format(slspath), cwd='/opt') %}

{% if result['stdout'] %}
(6.2.14) Ensure no users have .rhosts files:
    test.fail_without_changes:
        - name: "(6.2.14) Ensure no users have .rhosts files: \

                {{ result['stdout'] }} \
                
        "
{% endif %}