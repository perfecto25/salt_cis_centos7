# 1.7.2 Ensure GDM login banner is configured (Scored)
# Description:
# GDM is the GNOME Display Manager which handles graphical login for GNOME based
# systems.
# Rationale:
# Warning messages inform users who are attempting to login to the system of their legal
# status regarding the system and must include the name of the organization that owns the
# system and any monitoring policies that are in place.

{% set rule = '(1.7.2)' %}

{% if salt['file.file_exists']("/etc/dconf/profile/gdm") %}

{% if not salt['file.contains']('/etc/dconf/profile/gdm', 'user-db:user') %}
{{ rule }} Ensure GDM login banner is configured:
    test.fail_without_changes:
        - name: "{{ rule }} GDM login banner is not set correctly: 'user-db:user'"

{% elif not salt['file.contains']('/etc/dconf/profile/gdm', 'system-db:gdm') %}
{{ rule }} Ensure GDM login banner is configured:
    test.fail_without_changes:
        - name: "{{ rule }} GDM login banner is not set correctly: 'system-db:gdm'"

{% elif not salt['file.contains']('/etc/dconf/profile/gdm', 'file-db:/usr/share/gdm/greeter-dconf-defaults') %}
{{ rule }} Ensure GDM login banner is configured:
    test.fail_without_changes:
        - name: "{{ rule }} GDM login banner is not set correctly: 'file-db:/usr/share/gdm/greeter-dconf-defaults'"
{% endif %}
{% endif %}
