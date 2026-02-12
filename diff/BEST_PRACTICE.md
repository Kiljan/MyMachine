# GLOBAL
1. Use LVM
2. Configure Firewalld
3. Mitigate security problems; for example:
```bash
mv /usr/bin/scp /usr/bin/scp.disabled
cat /usr/bin/scp
    !/bin/bash
	echo "ERROR! SCP is disabled due to security reasons. Try SSH, SFTP or RSYNC instead."
	exit 1
```

4. Change language
```bash
yum install glibc-langpack-en
localectl set-locale en_GB.utf8
```

5. Setup /etc/sysctl.d/ For example:
    1. Change tcp_keepalive: sysctl -w net.ipv4.tcp_keepalive_time=600 net.ipv4.tcp_keepalive_intvl=60 net.ipv4.tcp_keepalive_probes=20
    1. Set swapinnes to something like 5 %. Then the swap file will only be used when RAM usage is around 95 percent: vm.swappiness = 5
    1. Ensure address space layout randomization (ASLR) is enabled: sysctl kernel.randomize_va_space

6. Ensure XD/NX support is enabled
```bash
journalctl | grep 'protection: active'
```

7. Ensure journald is configured to write logfiles
```bash
mkdir -p /var/log/journal
chmod -R 751 /var/log/journal
systemctl restart systemd-journald
```

8. Set the auditd rules
9. Check services that should be off
```bash
systemctl list-unit-files | grep -i chargen
systemctl list-unit-files | grep -i daytime
systemctl list-unit-files | grep -i discard
systemctl list-unit-files | grep -i shell
systemctl list-unit-files | grep -i login
systemctl list-unit-files | grep -i exec
systemctl list-unit-files | grep -i talk
systemctl list-unit-files | grep -i telnet
systemctl list-unit-files | grep -i tftp
systemctl is-enabled coredump.service
systemctl is-enabled xinetd
```

10. Set mount points in fstab
11. Use chronyd insted of ntpd
12. Remove unused modules (for example cramfs, freevxfs, jffs2, hfs, hfsplus, squashfs, udf, vfat, dccp, sctp)
```bash
modprobe -n -v <mod_name>
lsmod | grep <mod_name>
rmmod <mod_name>
```

13. Ensure sticky bit is set on all world-writable directories
```bash
df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null
```

14. Ensure GPG keys are configured
```bash
rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n'
```

15. Ensure prelink is disabled
```bash
rpm -q prelink
```

16. Ensure SELinux are installed
```bash
getenforce
```

17. Ensure no unconfined daemons exist
```bash
ps -eZ | grep -E "initrc" | grep -E -v -w "tr|ps|grep|bash|awk"
```

18. Ensure local login warning banner is configured properly
```bash
echo "Authorized uses only. All activity may be monitored and reported!" > /etc/issue
```

19. Ensure remote login warning banner is configured properly
```bash
echo "Authorized uses only. All activity may be monitored and reported!" > /etc/issue.net
```

20. Ensure logrotate is configured
```bash
/etc/logrotate.conf and /etc/logrotate.d/*
```

21. Set up sshd

22. Audit SUID executables (best to perform on fresh install, for future reference/comparison of resoults)
```bash
df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000
```

23. Audit SGID executables (best to perform on fresh install, for future reference/comparison of resoults)
```bash
df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000
```

24. Ensure root is the only UID 0 account
```bash
awk -F: '($3 == 0) { print $1 }' /etc/passwd
```

# For OL8
https://docs.oracle.com/en/operating-systems/oracle-linux/8/osmanage/index.html
```bash
# Manage the number of kernels installed for Oracle Linux (8 and 9)

grubby --info=ALL | grep ^kernel	# check for actual kernel
cat /etc/yum.conf |grep limit		# set limit
	installonly_limit=3
dnf update -y 						# and then just update
grubby --info=ALL | grep ^kernel	# verify the resoult
```

# COMMANDS

1. History search
```bash
sudo sh -c 'for i in $(ls /home/*/.bash_history); do echo "======$i======" && cat $i; done'
for i in {1629..1631}; do history -d $i; done
```

2. Find on day
```bash
find . -type f -newermt 2022-09-26 ! -newermt 2022-09-27 | xargs du -shc
find . -type d -newermt 2022-09-01 | xargs du -shc
nice find /opt/logs -type d -newermt 2022-09-15 ! -newermt 2022-10-03 -print0 | xargs -0 tar cvzf /tmp/since20220915to20221003.tgz
```

3. List open files
```bash
[root@TEST ~]# lsof -i:27017
COMMAND   PID USER   FD   TYPE   DEVICE SIZE/OFF NODE NAME
mongod  72147 root    5u  IPv4 72222518      0t0  TCP TEST:27017->bs-iis-11.pe6300.local:65299 (ESTABLISHED)
mongod  72147 root   12u  IPv4 52016358      0t0  TCP *:27017 (LISTEN)
```

4. Xargs Power
```bash
# -I option for input
rpm -qa | sort > pkglist.txt && yum install $(cat /root/pkglist.txt|xargs)
ls somedir/ | grep "^s" | xargs -I {} chown peter:peter somedir/{}
```

5. rsync good practice
```bash
rsync -ve "ssh -p 65414" --progress  /home/user/lol.txt user@10.0.0.32:/home/user
rsync -ve "ssh -p 65414" --progress -rAlpX -n /home/user user@10.0.0.32:/tmp
rsync -ve "ssh -p 65414" --progress -rAlpX /home/user user@10.0.0.32:/tmp
```

6. firewalld rich rulee example
```bash
rule family="ipv4" source address="10.0.0.12/32" port port="6666" protocol="tcp" accept
```
