# 4.2.4 Ensure permissions on all logfiles are configured

(4.2.4) ensure proper permissions on log files:
    file.directory:
        - name: /var/log
        - file_mode: 640
        - recurse:
            - mode

