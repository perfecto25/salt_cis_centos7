# 1.5.2 Ensure XD/NX support is enabled
# Description:
# Recent processors in the x86 family support the ability to prevent code execution on a per
# memory page basis. Generically and on AMD processors, this ability is called No Execute
# (NX), while on Intel processors it is called Execute Disable (XD). This ability can help
# prevent exploitation of buffer overflow vulnerabilities and should be activated whenever
# possible. Extra steps must be taken to ensure that this protection is enabled, particularly on
# 32-bit x86 systems. Other processors, such as Itanium and POWER, have included such
# support since inception and the standard kernel for those platforms supports the feature.
# Rationale:
# Enabling any feature that can protect against buffer overflow attacks enhances the security
# of the system.

{% set rule = '(1.5.2)' %}

{% set nx = salt['cmd.run_all'](cmd="dmesg | grep 'Execute Disable' | awk -F':' '{print $2}' | tr -d ' '", python_shell=True)['stdout'] %}

{% if nx == 'active' %}
{{ rule }} Ensure XD/NX support is enabled:
    test.succeed_without_changes:
        - name: "{{ rule }} XD/NX support is already enabled"
{% else %}
{{ rule }} Ensure XD/NX support is enabled:
    test.fail_without_changes:
        - name: "{{ rule }} XD/NX support needs to be enabled"
{% endif %}