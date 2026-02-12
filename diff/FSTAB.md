# /etc/fstab mount options

```bash
/dev/mapper/ol-root     /                       xfs     defaults        0 0
UUID=ea51af0f-356d-4968-af6a-84abbb95a5f2 /boot xfs     defaults        0 0
UUID=F5BA-76B9          /boot/efi               vfat    umask=0077,shortname=winnt 0 2
/dev/mapper/ol-home     /home                   xfs     defaults,rw,nosuid,nodev,noexec,noatime,nodiratime 0 0
/dev/mapper/ol-tmp      /tmp                    tmpfs   defaults,rw,nosuid,nodev,noexec,noatime,nodiratime 0 0
/dev/mapper/ol-var      /var                    xfs     defaults,rw,nosuid,nodev,noexec,noatime,nodiratime        0 0
/dev/mapper/ol-var_log  /var/log                xfs     defaults,rw,nosuid,nodev,noexec,noatime,nodiratime 0 0
/dev/mapper/olvg-var_tmp       /var/tmp         xfs     rw,nosuid,nodev,noexec,noatime,nodiratime 0 0
/dev/mapper/olvg-var_log_audit /var/log/audit   xfs     rw,nosuid,nodev,noexec,noatime,nodiratime 0 0
/dev/mapper/ol-swap     none                    swap    defaults        0 0
```
