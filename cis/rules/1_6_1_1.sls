# 1.6.1.1 Ensure SELinux is not disabled in bootloader configuration
# Description:
# Configure SELINUX to be enabled at boot time and verify that it has not been overwritten
# by the grub boot parameters.
# Rationale:
# SELinux must be enabled at boot time in your grub configuration to ensure that the
# controls it provides are not overridden.

{% set rule = '(1.6.1.1)' %}
{% set selinux= salt['cmd.run_all'](cmd="grep '^\s*linux' /boot/grub2/grub.cfg | grep 'selinux=0\|enforcing=0'", python_shell=True)['stdout'] %}

{% if not selinux %}
{{ rule }} Ensure SELinux is not disabled in bootloader configuration:
    test.succeed_without_changes:
        - name: "{{ rule }} SELinux is enabled in bootloader"
{% else %}
{{ rule }} Ensure SELinux is not disabled in bootloader configuration:
    test.fail_without_changes:
        - name: "{{ rule }} SELinux is disabled in bootloader, check /etc/default/grub file"
{% endif %}


# 1.6.1.2 Ensure the SELinux state is enforcing
# Description:
# Set SELinux to enable when the system is booted.
# Rationale:
# SELinux must be enabled at boot time in to ensure that the controls it provides are in effect
# at all times.
{% set rule = '(1.6.1.2)' %}
{{ rule }} SELinux is enforcing:
    selinux.mode:
        - name: enforcing


# Description:
# Configure SELinux to meet or exceed the default targeted policy, which constrains daemons
# and system software only.
# Rationale:
# Security configuration requirements vary from site to site. Some sites may mandate a
# policy that is stricter than the default policy, which is perfectly acceptable. This item is
# intended to ensure that at least the default recommendations are met.
{% set rule = '(1.6.1.3)' %}
{{ rule }} SELinux type is targeted:
    file.replace:
        - name: /etc/selinux/config
        - pattern: "^SELINUXTYPE=*.$"
        - repl: "SELINUXTYPE=targeted"
        - append_if_not_found: True 

