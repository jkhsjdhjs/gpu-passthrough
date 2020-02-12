#!/usr/bin/env bash

sddm_uid="995"

# stop display manager
systemctl stop display-manager.service

# wait for all sddm processes to exit, because sddm doesn't wait for its helper process
while systemctl -q is-active "user@$sddm_uid.service"; do
    sleep 1
done

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
cat > /etc/X11/xorg.conf.d/20-intel.conf <<- EOM
Section "Device"
    Identifier      "Intel Graphics"
    Driver          "intel"
    BusID           "PCI:0:2:0"
EndSection
EOM

# start display manager
systemctl start display-manager.service
