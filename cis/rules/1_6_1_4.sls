# 1.6.1.4 Ensure SETroubleshoot is not installed
# Description:
# The SETroubleshoot service notifies desktop users of SELinux denials through a user-
# friendly interface. The service provides important information around configuration errors,
# unauthorized intrusions, and other potential errors.
# Rationale:
# The SETroubleshoot service is an unnecessary daemon to have running on a server,
# especially if X Windows is disabled.

(1.6.1.4) remove setroubleshoot pkg:
    pkg.removed:
        - name: setroubleshoot
