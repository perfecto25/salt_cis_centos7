# 1.5.3 Ensure address space layout randomization (ASLR) is enabled
# Description:
# Address space layout randomization (ASLR) is an exploit mitigation technique which
# randomly arranges the address space of key data areas of a process.
# Rationale:
# Randomly placing virtual memory regions will make it difficult to write memory page
# exploits as the memory placement will be consistently shifting.

{% set rule = '(1.5.3)' %}

{{ rule }} randomize VA space:
    sysctl.present:
        - name: kernel.randomize_va_space
        - value: 2