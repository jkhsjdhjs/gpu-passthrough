#!/usr/bin/env bash

# stop display manager
systemctl stop display-manager

# unbind virtual console from intel gpu
echo 0 > /sys/class/vtconsole/vtcon1/bind

# disable intel Xorg config
rm -f /etc/X11/xorg.conf.d/20-intel.conf

# re-attach gpu
virsh nodedev-reattach pci_0000_01_00_1
virsh nodedev-reattach pci_0000_01_00_0

# run nvidia-xconfig to fix gpu
nvidia-xconfig --query-gpu-info > /dev/null 2>&1

# rebind virtual console to nvidia gpu
echo 1 > /sys/class/vtconsole/vtcon1/bind

# rebind EFI-framebuffer
echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

# start display manager
systemctl start display-manager
