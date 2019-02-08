#!/usr/bin/env bash

while IFS= read -rd '' iommu_group; do
    echo "IOMMU group $(basename "$iommu_group")";
    for device in "$iommu_group"/devices/*; do
        echo -n $'\t';
        lspci -nns "$(basename "$device")";
    done;
done< <(sort -nzt '/' -k 5 <(find /sys/kernel/iommu_groups/ -maxdepth 1 -mindepth 1 -type d -print0))
