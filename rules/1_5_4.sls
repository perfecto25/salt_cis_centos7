# 1.5.4 Ensure prelink is disabled
# Description:
# prelink is a program that modifies ELF shared libraries and ELF dynamically linked
# binaries in such a way that the time needed for the dynamic linker to perform relocations
# at startup significantly decreases.
# Rationale:
# The prelinking feature can interfere with the operation of AIDE, because it changes
# binaries. Prelinking can also increase the vulnerability of the system if a malicious user is
# able to compromise a common library such as libc.

{% set rule = '(1.5.4)' %}

{{ rule }} remove prelink pkg:
    pkg.removed:
        - name: prelink
