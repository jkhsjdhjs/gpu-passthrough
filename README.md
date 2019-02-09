# gpu-passthrough
A collection of links regarding gpu passthrough

PCIe device power cycle: https://unix.stackexchange.com/questions/73908/how-to-reset-cycle-power-to-a-pcie-device  
Pass primary GPU to VM + patch vBIOS: https://github.com/joeknock90/Single-GPU-Passthrough  
Pass GPU to VM and back without X restart using DRI3 drivers: https://arseniyshestakov.com/2016/03/31/how-to-pass-gpu-to-vm-and-back-without-x-restart/  
GPU passthrough without restart: https://www.reddit.com/r/VFIO/comments/93c4s7/passing_nvidia_card_between_host_and_guest_and_to/  
Passing primary nvidia gpu to vm (proprietary drivers) with X restart: https://bbs.archlinux.org/viewtopic.php?id=233959  
Collection of information and scripts regarding gpu passthrough: https://gitlab.com/YuriAlek/vfio
Arch Wiki article: https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF

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
