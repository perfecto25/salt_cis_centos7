# 1.6.1.5 Ensure the MCS Translation Service (mcstrans) is not installed
# Description:
# The mcstransd daemon provides category label information to client processes requesting
# information. The label translations are defined in /etc/selinux/targeted/setrans.conf
# Rationale:
# Since this service is not used very often, remove it to reduce the amount of potentially
# vulnerable code running on the system.

(1.6.1.5) remove mcstrans pkg:
    pkg.removed:
        - name: mcstrans
