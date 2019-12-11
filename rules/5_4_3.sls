# 5.4.3 Ensure default group for the root account is GID 0

# Description:
# The usermod command can be used to specify which group the root user belongs to. This
# affects permissions of files that are created by the root user.
# Rationale:
# Using GID 0 for the root account helps prevent root -owned files from accidentally
# becoming accessible to non-privileged users.

(5.4.3) Ensure default group for the root account is GID 0:
    user.present:
        - name: root
        - uid: 0
        - gid: 0
        - allow_gid_change: True
