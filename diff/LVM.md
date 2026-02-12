# LVM

When resizing a logical volume with the following command, it trays to resize it to the number of free extents, rather than the current size plus the number of free extents

```bash
lvextend -l 100%FREE <logvol path>
```

Use the + symbol in front of X%FREE to indicate the space should be added to the current size.

```bash
lvextend -l +100%FREE /dev/volgroup/logvol
```

## If there are no information about disk

```bash
for host in $( ls /sys/class/scsi_host/ );do echo "- - -" >/sys/class/scsi_host/$host/scan; done
```

# LVM process

```bash
vgdisplay
lsblk
fdisk /dev/sda # See the Disklabel. If it shows __dos__ that means it is MBR schema else GPT schema
fdisk /dev/sdb # make as previous one
lsblk
vgdisplay
vgextend centos /dev/sdb1
vgdisplay
lvdisplay
lvextend -l +100%FREE /dev/centos/var
xfs_growfs /dev/centos/var
```
