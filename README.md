# gpu-passthrough
A collection of links regarding gpu passthrough

PCIe device power cycle: https://unix.stackexchange.com/questions/73908/how-to-reset-cycle-power-to-a-pcie-device  
Pass primary GPU to VM + patch vBIOS: https://github.com/joeknock90/Single-GPU-Passthrough  
Pass GPU to VM and back without X restart using DRI3 drivers: https://arseniyshestakov.com/2016/03/31/how-to-pass-gpu-to-vm-and-back-without-x-restart/  
GPU passthrough without restart: https://www.reddit.com/r/VFIO/comments/93c4s7/passing_nvidia_card_between_host_and_guest_and_to/  
Passing primary nvidia gpu to vm (proprietary drivers) with X restart: https://bbs.archlinux.org/viewtopic.php?id=233959  
Collection of information and scripts regarding gpu passthrough: https://gitlab.com/YuriAlek/vfio  
Arch Wiki article: https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF  
GPU hotplug: https://gist.github.com/ArseniyShestakov/dc152d080c65ebaa6781

### amd reset bug
The AMD reset bug is an issue in qemu with many AMD cards.
Apparently qemu fails to correctly reset the card on guest shutdown/reboot which causes the card to not be usable anymore until host reboot.  
https://vfio.blogspot.com/2015/04/progress-on-amd-front.html  
https://www.reddit.com/r/VFIO/comments/5tf62v/who_still_experiences_the_amd_reset_bug/  
https://www.reddit.com/r/VFIO/comments/52ij8j/the_amdresetbug_will_it_ever_be_fixedwhere_to/  
https://www.reddit.com/r/VFIO/comments/angluw/restart_vs_shutdown_of_vm/

Possible solution:  
https://forum.level1techs.com/t/linux-host-windows-guest-gpu-passthrough-reinitialization-fix/121097  
https://forums.unraid.net/topic/69373-graphics-card-reset-issue-amd/?tab=comments#comment-635252  

### could be interesting
| command | comment | source |
| --- | --- | --- |
| `cat /sys/kernel/debug/dri/1/amdgpu_gpu_recover` | gpu recovery | [1](https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/issues/11#issuecomment-450696825), [2](https://dri.freedesktop.org/docs/drm/gpu/amdgpu.html) |

### kvm_set_msr_common
When launching some games (e.g. L.A. Noire) in a VM with CPU model set to 'host-model' the game may crash and the following errors get logged by the kernel: https://gist.github.com/jkhsjdhjs/f45046d7dbec02d5a0dc9136319f222a  
This is caused by the NVIDIA driver (apparently only on Windows 10) trying to use some MSRs (Model Specific Registers) of the host CPU the VCPU doesn't support.
`ignore_msrs` is already set to 1 here (check with `cat /sys/module/kvm/parameters/ignore_msrs`).  
It could be fixed by changing the CPU model. However I haven't had the time to test which CPU model works yet.  
https://www.reddit.com/r/VFIO/comments/4kagkv/nvidia_system_unstable_windows_10_qemukvmvgapass/d3dldyj/  
EDIT: Changing the CPU model results either in the VM not booting or the errors still occuring.
