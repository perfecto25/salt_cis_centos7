# 6.1.14 Audit SGID executables

# Description:
# The owner of a file can set the file's permissions to run with the owner's or group's
# permissions, even if the user running the program is not the owner or a member of the
# group. The most common reason for a SGID program is to enable users to perform
# functions (such as changing their password) that require root privileges.
# Rationale:
# There are valid reasons for SGID programs, but it is important to identify and review such
# programs to ensure they are legitimate. Review the files returned by the action in the audit
# section and check to see if system binaries have a different md5 checksum than what from
# the package. This is an indication that the binary may have been replaced.

{% set result = salt['cmd.run_all'](cmd="df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -2000 | grep -v 'bin/wall\|bin/write\|bin/ssh-agent\|bin/screen\|bin/locate\|openssh/ssh-keysign'", python_shell=True) %}

{% if result['stdout'] %}
(6.1.14) Audit SGID executables:
    test.fail_without_changes:
        - name: "(6.1.14) SGID executables found: \n\n{{ result['stdout'].split() | yaml }}\n"
{% endif %}
