# NFS

## On server (10.10.10.24)

```bash
yum install nfs-utils
systemctl enable nfs.service
systemctl start nfs.service
```

```bash
vim /etc/exports
        /data 10.10.10.25(rw,sync,root_squash)
        /data 10.10.10.26(rw,sync,root_squash)
        /data 10.10.10.27(rw,sync,root_squash)
        # /data *(rw,sync,no_root_squash) 
        # * means everyware
        # no_root_squash only if nesesery because it gives owner right to share file
```

```bash
exportfs -a
showmount --exports localhost # or -e option

firewall-cmd --add-service=nfs --permanent
firewall-cmd --add-service=rpc-bind --permanent
firewall-cmd --add-service=mountd --permanent
firewall-cmd --reload
```

## On clients (10.10.10.25, 10.10.10.26, 10.10.10.27)

```bash
yum install nfs-utils
showmount --exports 10.10.10.24
```

```bash
vim /etc/fstab
        10.10.10.24:/data /data nfs defaults 0 0
```

```bash
mount -a
```
