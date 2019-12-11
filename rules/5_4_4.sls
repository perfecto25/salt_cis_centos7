# 5.4.4 Ensure default user umask is 027 or more restrictive

# Description:
# The default umask determines the permissions of files created by users. The user creating
# the file has the discretion of making their files and directories readable by others via the
# chmod command. Users who wish to allow their files and directories to be readable by
# others by default may choose a different default umask by inserting the umask command
# into the standard shell configuration files ( .profile , .bashrc , etc.) in their home
# directories.
# Rationale:
# Setting a very secure default value for umask ensures that users make a conscious choice
# about their file permissions. A default umask setting of 077 causes files and directories
# created by users to not be readable by any other user on the system. A umask of 027 would
# make files and directories readable by users in the same Unix group, while a umask of 022
# would make files readable by every user on the system.

{% set umask = salt['cmd.run_all'](cmd="grep umask /etc/bashrc | grep 027", python_shell=True) %}

{% if not umask['stdout'] %}
(5.4.4) Ensure default user umask is 027 or more restrictive:
    test.fail_without_changes:
        - name: "(5.4.4) Umask needs to be set with 027 in /etc/bashrc"
{% endif %}
