# 4.1.4 - Ensure events that modify date and time information are collected
# 4.1.5 - Ensure events that modify user/group information are collected
# 4.1.6 - Ensure events that modify the system's network environment are collected
# 4.1.7 - Ensure events that modify the system's Mandatory Access are collected
# 4.1.8 Ensure login and logout events are collected
# 4.1.9 Ensure session initiation information is collected
# 4.1.10 Ensure discretionary access control permission modification events are collected
# 4.1.11 Ensure unsuccessful unauthorized file access attempts are collected
# 4.1.12 Ensure use of privileged commands is collected
# 4.1.13 Ensure successful file system mounts are collected
# 4.1.14 Ensure file deletion events by users are collected
# 4.1.15 Ensure changes to system administration scope (sudoers) is collected
# 4.1.16 Ensure system administrator actions (sudolog) are collected
# 4.1.17 Ensure kernel module loading and unloading is collected
# 4.1.18 Ensure the audit configuration is immutable


{% set rules = {
    '4.1.4': '-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change',
    '4.1.4': '-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change',
    '4.1.4': '-a always,exit -F arch=b64 -S clock_settime -k time-change',
    '4.1.4': '-a always,exit -F arch=b32 -S clock_settime -k time-change',
    '4.1.4': '-w /etc/localtime -p wa -k time-change',
    '4.1.5': '-w /etc/group -p wa -k identity',
    '4.1.5': '-w /etc/passwd -p wa -k identity',
    '4.1.5': '-w /etc/gshadow -p wa -k identity',
    '4.1.5': '-w /etc/shadow -p wa -k identity',
    '4.1.5': '-w /etc/security/opasswd -p wa -k identity',
    '4.1.6': '-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale',
    '4.1.6': '-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale',
    '4.1.6': '-w /etc/issue -p wa -k system-locale',
    '4.1.6': '-w /etc/issue.net -p wa -k system-locale',
    '4.1.6': '-w /etc/hosts -p wa -k system-locale',
    '4.1.6': '-w /etc/sysconfig/network -p wa -k system-locale',
    '4.1.6': '-w /etc/sysconfig/network-scripts/ -p wa -k system-locale',
    '4.1.7': '-w /etc/selinux/ -p wa -k MAC-policy',
    '4.1.7': '-w /usr/share/selinux/ -p wa -k MAC-policy',
    '4.1.8': '-w /var/log/lastlog -p wa -k logins',
    '4.1.8': '-w /var/run/faillock/ -p wa -k logins',
    '4.1.9': '-w /var/run/utmp -p wa -k session',
    '4.1.9': '-w /var/log/wtmp -p wa -k logins',
    '4.1.9': '-w /var/log/btmp -p wa -k logins',
    '4.1.10': '-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod',
    '4.1.10': '-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod',
    '4.1.10': '-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod',
    '4.1.10': '-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod',
    '4.1.10': '-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod',
    '4.1.10': '-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod',
    '4.1.11': '-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access',
    '4.1.11': '-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access',
    '4.1.11': '-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access',
    '4.1.11': '-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access',
    '4.1.13': '-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts',
    '4.1.13': '-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts',
    '4.1.14': '-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete',
    '4.1.14': '-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete',
    '4.1.15': '-w /etc/sudoers -p wa -k scope',
    '4.1.15': '-w /etc/sudoers.d/ -p wa -k scope',
    '4.1.16': '-w /var/log/sudo.log -p wa -k actions',
    '4.1.17': '-w /sbin/insmod -p x -k modules',
    '4.1.17': '-w /sbin/rmmod -p x -k modules',
    '4.1.17': '-w /sbin/modprobe -p x -k modules',
    '4.1.17': '-a always,exit -F arch=b64 -S init_module -S delete_module -k modules',
    '4.1.18': '-e 2'}
%}

/etc/audit/rules.d/audit.rules:
    cmd.run:
        - name: touch /etc/audit/rules.d/audit.rules
        - unless: test -f /etc/audit/rules.d/audit.rules

{% for number,rule in rules.iteritems() %}
{{ number }} - Audit rule "{{ rule }}":
    file.replace:
        - name: /etc/audit/rules.d/audit.rules
        - pattern: '^{{ rule }}'
        - repl: '{{ rule }}'
        - append_if_not_found: True
{% endfor %}

auditd_service:
    cmd.wait:
        - name: service auditd restart