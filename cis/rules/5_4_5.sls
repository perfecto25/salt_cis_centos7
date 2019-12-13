# 5.4.5 Ensure default user shell timeout is 900 seconds or less

# Description:
# The default TMOUT determines the shell timeout for users. The TMOUT value is measured in
# seconds.
# Rationale:
# Having no timeout value associated with a shell could allow an unauthorized user access to
# another user's shell session (e.g. user walks away from their computer and doesn't lock the
# screen). Setting a timeout value at least reduces the risk of this happening.

(5.4.5) Ensure default user shell timeout is 900 seconds or less in /etc/bashrc:
    file.replace:
        - name: /etc/bashrc
        - pattern: ^TMOUT=.*
        - repl: TMOUT={{ salt['pillar.get']('cis:default:shell:timeout', 600) }}
        - append_if_not_found: True

(5.4.5) Ensure default user shell timeout is 900 seconds or less in /etc/profile:
    file.replace:
        - name: /etc/profile
        - pattern: ^TMOUT=.*
        - repl: TMOUT={{ salt['pillar.get']('cis:default:shell:timeout', 600) }}
        - append_if_not_found: True