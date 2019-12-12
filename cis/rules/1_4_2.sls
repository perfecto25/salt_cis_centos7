# 1.4.2 Ensure bootloader password is set
# # Description:
# Setting the boot loader password will require that anyone rebooting the system must enter
# a password before being able to set command line boot parameters
# Rationale:
# Requiring a boot password upon execution of the boot loader will prevent an unauthorized
# user from entering boot parameters or changing the boot partition. This prevents users
# from weakening security (e.g. turning off SELinux at boot time).

{% set rule = '(1.4.2)' %}


{% if salt['file.search']("/boot/grub2/grub.cfg", "^GRUB2_PASSWORD") %}

{{ rule }} Ensure bootloader password is set:
    test.succeed_without_changes:
        - name: {{ rule }} Bootloader password is set
{% else %}

{{ rule }} Ensure bootloader password is set:
    test.fail_without_changes:
        - name: {{ rule }} set a bootloader password by running 'grub2-setpassword'
{% endif %}
