# 6.2.13 Ensure users' .netrc Files are not group or world accessible

# While the system administrator can establish secure permissions for users' .netrc files, the
# users can easily override these.
# Rationale:
# .netrc files may contain unencrypted passwords that may be used to attack other systems.

{% set result = salt['cmd.script']('salt://{}/files/6_2_13'.format(slspath), cwd='/opt') %}

{% if result['stdout'] %}
(6.2.13) Ensure users' .netrc Files are not group or world accessible:
    test.fail_without_changes:
        - name: "(6.2.13) Ensure users' .netrc Files are not group or world accessible: \

                {{ result['stdout'] }} \
                
        "
{% endif %}