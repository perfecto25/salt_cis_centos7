# Sample Pillar showing all possible values that can be configured for CIS compliance

cis:
    ignore:
        
        rules: ['1.1.1', '1.1.2', '1.1.3', '1.1.6', '1.1.7', '1.1.8', '1.1.11', '1.1.12', '1.1.13', '1.1.14', '1.1.15', '1.1.21', '1.1.22', '1.2.2', '1.3', '1.4.1', '1.4.2', '1.4.3', '1.5.1', '1.5.2', '1.5.3', '1.5.4', '1.6.1.1', '1.6.1.4', '1.6.1.5', '1.6.1.6', '1.6.2', '1.7.1', '1.7.2', '2.1', '2.2.1.1', '2.2.15', '2.2', '2.3', '3.2', '3.3', '3.4', '3.5', '4.1.1', '4.1.2', '4.1.3', '4.1.4', '4.2.1', '4.2.4', '5.1', '5.2', '5.3.1', '5.3.2', '5.3.3', '5.3.4', '5.4.1', '5.4.2', '5.4.3', '5.4.4', '5.4.5', '5.6', '6.1.2', '6.1.10', '6.1.11', '6.1.12', '6.1.13', '6.1.14', '6.2.1', '6.2.2', '6.2.3', '6.2.4', '6.2.5', '6.2.6', '6.2.7', '6.2.8', '6.2.9', '6.2.10', '6.2.11', '6.2.12', '6.2.13', '6.2.14', '6.2.15', '6.2.16', '6.2.17', '6.2.18', '6.2.19']

        services: ['chargen-dgram', 'chargen-stream', 'daytime-dgram', 'daytime-stream', 'discard-dgram', 'discard-stream', 'echo-dgram', 'echo-stream', 'time-dgram', 'time-stream', 'tftp', 'xinetd', 'dhcpd', 'slapd', 'nfs', 'nfs-server', 'rpcbind', 'named', 'vsftpd', 'httpd', 'dovecot', 'smb', 'squid', 'snmpd', 'ypserv', 'rsh.socket', 'rlogin.socket', 'rexec.socket', 'telnet.socket', 'tftp.socket', 'rsyncd', 'ntalk' ]
        
        packages: ['ypbind', 'telnet', 'rsh', 'talk', 'avahi-daemon','cups', 'openldap-clients', 'xorg-x11-server-Xorg', 'samba']
        
        protcols: ['dccp', 'sctp', 'rds', 'tipc']
        
        filesystems: ['cramfs', 'freevxfs', 'jffs2', 'hfs', 'hfsplus', 'squashfs', 'udf', 'vfat']

    default:
        auditd:
            space_left_action: email
            action_mail_acct: root
            admin_space_left_action: SUSPEND
            max_log_file_action: ROTATE
        password:
            pass_max_days: 90
            pass_min_days: 7
            pass_warn_age: 7
        shell:
            timeout: 600
