# 6.2.11 Ensure no users have .forward files

# Description:
# The .forward file specifies an email address to forward the user's mail to.
# Rationale:
# Use of the .forward file poses a security risk in that sensitive data may be inadvertently
# transferred outside the organization. The .forward file also poses a risk as it can be used to
# execute commands that may perform unintended actions.

{% set result = salt['cmd.script']('salt://{}/files/6_2_11'.format(slspath), cwd='/opt') %}

{% if result['stdout'] %}
(6.2.11) Ensure no users have .forward files:
    test.fail_without_changes:
        - name: "(6.2.11) Ensure no users have .forward files: \

                {{ result['stdout'] }} \
                
        "
{% endif %}