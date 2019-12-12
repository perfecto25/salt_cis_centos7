# 6.2.12 Ensure no users have .netrc files

# Description:
# The .netrc file contains data for logging into a remote host for file transfers via FTP.
# Rationale:
# The .netrc file presents a significant security risk since it stores passwords in unencrypted
# form. Even if FTP is disabled, user accounts may have brought over .netrc files from other
# systems which could pose a risk to those systems.

{% set result = salt['cmd.script']('salt://{}/files/6_2_12'.format(slspath), cwd='/opt') %}

{% if result['stdout'] %}
(6.2.12) Ensure no users have .netrc files:
    test.fail_without_changes:
        - name: "(6.2.12) Ensure no users have .netrc files: \

                {{ result['stdout'] }} \
                
        "
{% endif %}