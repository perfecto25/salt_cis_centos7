# CIS CentOS 7 Benchmark, v2.2.0  (12-27-2017)

Centos 7 CIS benchmark checks and remediation using Saltstack configuration management.

All rules are based on the CIS Centos 7 Benchmark v2.2.0

To check your hosts for CIS compliance, run this State on your end points and pass the flag test=true. If test=true is omitted, this formula will attempt to remediate any inconsistent results it finds. CIS benchmark does its best to remediate basic things like file permissions, process and service control and user management. On other rules it will just issue a warning if something is not compliant. 

CIS formula cannot remediate automatically:

- mounting of separate partitions like /home (too many variables, ie size and FS type of mount, etc, this needs to be done manually by the sysadmin)
- missing user home directories


## Prerequisites
you will need the following yum packages installed on your Centos 7 host

1. policycoreutils
1. policycoreutils-python
1. augeas

## To check a host for CIS compliance

    salt [target] state.sls cis test=true

## Skip a Rule for all hosts,
to skip a specific Rule + remediation for a specific rule for all hosts, simply set the rule to False in the  ```init.sls```

    {% set rules = {
        '1.1.1':   { 'Disable unused filesystems':                                          False },
        '1.1.2':   { 'Ensure separate partition exists for /tmp':                           False },


## Ignore Rules, Package or Service checks on a per-host basis

to remove a service, package, filesystem or protocol from CIS check/compliance, or to skip a specific Rule check on an individual host, add a pillar to the minion,

    cis:
        ignore:
            rules: ['1.4.2', '2.1.1.4']
            services: ['smb', 'nfs']
            packages: ['samba', 'httpd']
            filesystems: ['squashfs']
            protocols: ['rds']

by default, CIS state will apply the benchmark-recommended value settings for each check, for example 

    # Rule 4.1.1.2 Ensure system is disabled when audit logs are full
    admin_space_left_action = {{ salt['pillar.get']('cis:default:auditd:admin_space_left_action', 'halt') }}"

it will apply the default 'halt' for admin_space_left_action parameter in /etc/audit/auditd.conf.

to specify a per-host value for these settings, add a pillar for the host
    
    cis:
        default:
            auditd:
                admin_space_left_action: SUSPEND

To see the full list of parameters that can be provided via pillar, see 'sample.pillar.sls'


---
## Sample compliance test results
```
----------
          ID: (6.2.19) Ensure no duplicate group names exist
    Function: test.fail_without_changes
        Name: (6.2.19) Ensure no duplicate group names exist: 

>>> Duplicate Group Name (jsmith): 5020 5026 

----------
          ID: (6.2.9) Ensure users own their home directories
    Function: test.fail_without_changes
        Name: (6.2.9) Ensure users own their home directories: 

>>> /home/rhlowe - does not exist.
>>> /home/sim is owned by: mreider.
>>> /home/kvar is owned by: root.
>>> /opt/sophos-av is owned by: root.
>>> /home/rstudio-server - does not exist. 

----------
          ID: (1.1.7) /var/tmp on separate partition
    Function: test.fail_without_changes
        Name: (1.1.7) /var/tmp needs to be mounted on a separate partition.
      Result: False
     Comment: If we weren't testing, this would be a failure!

----------
          ID: (6.2.14) Ensure no users have .rhosts files
    Function: test.fail_without_changes
        Name: (6.2.14) Ensure no users have .rhosts files: 

>>> The home directory (/home/rstudio-server) of user rstudio-server does not exist. 

      Result: False
     Comment: If we weren't testing, this would be a failure!

----------
          ID: (4.2.4) ensure proper permissions on log files
    Function: file.directory
        Name: /var/log
      Result: None
     Comment: The following files will be changed:
              /var/log/tuned: mode - 0640
              /var/log/anaconda: mode - 0640
              /var/log/chrony: mode - 0640
              /var/log/httpd: mode - 0640
              /var/log/audit: mode - 0640
              /var/log: mode - 0640
              /var/log/lightdm: mode - 0640
              /var/log/rhsm: mode - 0640
              /var/log/salt: mode - 0640
              /var/log/cups: mode - 0640
              /var/log/sa: mode - 0640
              /var/log/rstudio-server: mode - 0640
              /var/log/qemu-ga: mode - 0640
     Started: 14:05:17.621236
    Duration: 7.675 ms
     Changes:   
              ----------
              /var/log:
                  ----------
                  mode:
                      0640
              /var/log/anaconda:
                  ----------
                  mode:
                      0640
              /var/log/audit:
                  ----------
                  mode:
                      0640
              /var/log/chrony:
                  ----------
                  mode:
                      0640
              /var/log/cups:
                  ----------
                  mode:
                      0640
              /var/log/httpd:
                  ----------
                  mode:
                      0640
              /var/log/lightdm:
                  ----------
                  mode:
                      0640
              /var/log/qemu-ga:
                  ----------
                  mode:
                      0640
              /var/log/rhsm:
                  ----------
                  mode:
                      0640
              /var/log/rstudio-server:
                  ----------
                  mode:
                      0640
              /var/log/sa:
                  ----------
                  mode:
                      0640
              /var/log/salt:
                  ----------
                  mode:
                      0640
              /var/log/tuned:
                  ----------
                  mode:
                      0640

----------
          ID: (3.3.3) Disable IPv6 from default kernel
    Function: file.replace
        Name: /etc/default/grub
      Result: True
     Comment: Changes were made
     Started: 14:23:33.878796
    Duration: 4.108 ms
     Changes:   
              ----------
              diff:
                  --- 
                  +++ 
                  @@ -7,3 +7,4 @@
                   GRUB_CMDLINE_LINUX="console=tty0 crashkernel=auto console=ttyS0,115200"
                   GRUB_DISABLE_RECOVERY="true"
                   GRUB_CMDLINE_LINUX="audit=1"
                  +GRUB_CMDLINE_LINUX="ipv6.disable=1"
----------
          ID: (3.3.3) update grub
    Function: cmd.run
        Name: grub2-mkconfig > /boot/grub2/grub.cfg
      Result: True
     Comment: Command "grub2-mkconfig > /boot/grub2/grub.cfg" run
     Started: 14:23:33.885399
    Duration: 2649.027 ms
     Changes:   
              ----------
              pid:
                  7580
              retcode:
                  0
              stderr:
                  Generating grub configuration file ...
                  Found linux image: /boot/vmlinuz-3.10.0-1062.4.3.el7.x86_64
                  Found initrd image: /boot/initramfs-3.10.0-1062.4.3.el7.x86_64.img
                  Found linux image: /boot/vmlinuz-3.10.0-1062.4.1.el7.x86_64
                  Found initrd image: /boot/initramfs-3.10.0-1062.4.1.el7.x86_64.img
                  Found linux image: /boot/vmlinuz-3.10.0-957.27.2.el7.x86_64
                  Found initrd image: /boot/initramfs-3.10.0-957.27.2.el7.x86_64.img
                  Found linux image: /boot/vmlinuz-3.10.0-957.1.3.el7.x86_64
                  Found initrd image: /boot/initramfs-3.10.0-957.1.3.el7.x86_64.img
                  Found linux image: /boot/vmlinuz-0-rescue-05cb8c7b39fe0f70e3ce97e5beab809d
                  Found initrd image: /boot/initramfs-0-rescue-05cb8c7b39fe0f70e3ce97e5beab809d.img
                  done
              stdout:


```