#!/usr/bin/env bash

# stop display manager
systemctl stop display-manager.service

# unbind virtual console
echo 0 > /sys/class/vtconsole/vtcon1/bind

# unbind EFI-framebuffer
echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/unbind

# detach GPU
virsh nodedev-detach pci_0000_01_00_0
virsh nodedev-detach pci_0000_01_00_1

# bind virtual console to available gpu (only intel available)
echo 1 > /sys/class/vtconsole/vtcon1/bind

# enable Xorg intel config (so Xorg only detects the intel gpu)
mv /etc/X11/xorg.conf.d/20-intel.conf{.disabled,}

# start display manager
systemctl start display-manager.service
