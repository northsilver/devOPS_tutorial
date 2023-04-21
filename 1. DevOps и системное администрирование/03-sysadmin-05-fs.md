- Задание 1

Узнайте о sparse (разряженных) файлах.
```text
Основное применение видимо для Торрентов и P2P
```
- Задание 2

Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?
```text
Нет не могут. Ссылка на один и тот же файл и inode, права не будут отличаться

vagrant@vagrant:/tmp$ touch file_for_link
vagrant@vagrant:/tmp$ ln file_for_link link_for_file
vagrant@vagrant:/tmp$ ls -ilh
total 20K
1835035 -rw-rw-r-- 2 vagrant vagrant    0 Nov 11 14:10 file_for_link
1835035 -rw-rw-r-- 2 vagrant vagrant    0 Nov 11 14:10 link_for_file
vagrant@vagrant:/tmp$ chmod  777 file_for_link 
vagrant@vagrant:/tmp$ ls -ilh
total 20K
1835035 -rwxrwxrwx 2 vagrant vagrant    0 Nov 11 14:10 file_for_link
1835035 -rwxrwxrwx 2 vagrant vagrant    0 Nov 11 14:10 link_for_file
```
- Задание 3

Сделайте vagrant destroy на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:
```text
vagrant@sysadm-fs:~$ lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
loop0                       7:0    0 67.2M  1 loop /snap/lxd/21835
loop1                       7:1    0 61.9M  1 loop /snap/core20/1328
loop2                       7:2    0 43.6M  1 loop /snap/snapd/14978
sda                         8:0    0   64G  0 disk 
├─sda1                      8:1    0    1M  0 part 
├─sda2                      8:2    0  1.5G  0 part /boot
└─sda3                      8:3    0 62.5G  0 part 
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm  /
sdb                         8:16   0  2.5G  0 disk 
sdc                         8:32   0  2.5G  0 disk 
```
- Задание 4

Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.
```text
Чуть напутал с номерами (2ой и 3), но вроде не критично
Device     Boot   Start     End Sectors  Size Id Type
/dev/sdb2          2048 4196351 4194304    2G 83 Linux
/dev/sdb3       4196352 5242879 1046528  511M 83 Linux
```
- Задание 5

Используя sfdisk, перенесите данную таблицу разделов на второй диск.
```text
Получилось только из под root
vagrant@sysadm-fs:~$ sudo sfdisk -d /dev/sdb | sfdisk --force /dev/sdc 
sfdisk: cannot open /dev/sdc: Permission denied
vagrant@sysadm-fs:~$ sudo i
sudo: i: command not found
vagrant@sysadm-fs:~$ sudo -i
root@sysadm-fs:~# sudo sfdisk -d /dev/sdb | sfdisk --force /dev/sdc 
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0x821d00fb.
/dev/sdc1: Created a new partition 2 of type 'Linux' and of size 2 GiB.
/dev/sdc3: Created a new partition 3 of type 'Linux' and of size 511 MiB.
/dev/sdc4: Done.

New situation:
Disklabel type: dos
Disk identifier: 0x821d00fb

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc2          2048 4196351 4194304    2G 83 Linux
/dev/sdc3       4196352 5242879 1046528  511M 83 Linux

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```
- Задание 6

Соберите mdadm RAID1 на паре разделов 2 Гб.
```text
root@sysadm-fs:~# sudo mdadm --detail /dev/md1
/dev/md1:
           Version : 1.2
     Creation Time : Fri Nov 11 14:49:34 2022
        Raid Level : raid1
        Array Size : 2094080 (2045.00 MiB 2144.34 MB)
     Used Dev Size : 2094080 (2045.00 MiB 2144.34 MB)
      Raid Devices : 2
     Total Devices : 2
       Persistence : Superblock is persistent

       Update Time : Fri Nov 11 14:49:44 2022
             State : clean 
    Active Devices : 2
   Working Devices : 2
    Failed Devices : 0
     Spare Devices : 0

Consistency Policy : resync

              Name : sysadm-fs:1  (local to host sysadm-fs)
              UUID : 24d7b57b:dbcffc72:38a8b151:b6c67f8a
            Events : 17

    Number   Major   Minor   RaidDevice State
       0       8       18        0      active sync   /dev/sdb2
       1       8       34        1      active sync   /dev/sdc2
```
- Задание 7

Соберите mdadm RAID0 на второй паре маленьких разделов.
```text
root@sysadm-fs:~# sudo mdadm --detail /dev/md0 
/dev/md0:
           Version : 1.2
     Creation Time : Fri Nov 11 14:52:50 2022
        Raid Level : raid0
        Array Size : 1042432 (1018.00 MiB 1067.45 MB)
      Raid Devices : 2
     Total Devices : 2
       Persistence : Superblock is persistent

       Update Time : Fri Nov 11 14:52:50 2022
             State : clean 
    Active Devices : 2
   Working Devices : 2
    Failed Devices : 0
     Spare Devices : 0

            Layout : -unknown-
        Chunk Size : 512K

Consistency Policy : none

              Name : sysadm-fs:0  (local to host sysadm-fs)
              UUID : e031a0b1:88fa5312:00c21df5:ac6d8ae1
            Events : 0

    Number   Major   Minor   RaidDevice State
       0       8       19        0      active sync   /dev/sdb3
       1       8       35        1      active sync   /dev/sdc3
```
- Задание 8

Создайте 2 независимых PV на получившихся md-устройствах.
```text
root@sysadm-fs:~# pvcreate /dev/md0 /dev/md1
  Physical volume "/dev/md0" successfully created.
  Physical volume "/dev/md1" successfully created.
```
- Задание 9

Создайте общую volume-group на этих двух PV.
```text
root@sysadm-fs:~# vgcreate vg1 /dev/md0 /dev/md1
  Volume group "vg1" successfully created
root@sysadm-fs:~# vgdisplay 
  --- Volume group ---
  VG Name               ubuntu-vg
  System ID             
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  2
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                1
  Open LV               1
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               <62.50 GiB
  PE Size               4.00 MiB
  Total PE              15999
  Alloc PE / Size       7999 / <31.25 GiB
  Free  PE / Size       8000 / 31.25 GiB
  VG UUID               4HbbNB-kISH-fXeQ-qzbV-XeNd-At34-cCUUuJ
   
  --- Volume group ---
  VG Name               vg1
  System ID             
  Format                lvm2
  Metadata Areas        2
  Metadata Sequence No  1
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                0
  Open LV               0
  Max PV                0
  Cur PV                2
  Act PV                2
  VG Size               <2.99 GiB
  PE Size               4.00 MiB
  Total PE              765
  Alloc PE / Size       0 / 0   
  Free  PE / Size       765 / <2.99 GiB
  VG UUID               aeA5ZE-PgHd-qsOB-HFcv-0L2G-iQ9D-qry98k
```
- Задание 10

Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.
```text
root@sysadm-fs:~# lvcreate -L 100M vg1 /dev/md0
  Logical volume "lvol0" created.
root@sysadm-fs:~# vgs
  VG        #PV #LV #SN Attr   VSize   VFree 
  ubuntu-vg   1   1   0 wz--n- <62.50g 31.25g
  vg1         2   1   0 wz--n-  <2.99g  2.89g
root@sysadm-fs:~# lvs
  LV        VG        Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  ubuntu-lv ubuntu-vg -wi-ao---- <31.25g                                                    
  lvol0     vg1       -wi-a----- 100.00m 
```
- Задание 11

Создайте mkfs.ext4 ФС на получившемся LV.
```text
root@sysadm-fs:~# mkfs.ext4 /dev/vg1/lvol0
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
```
- Задание 12

Смонтируйте этот раздел в любую директорию, например, /tmp/new.
```text
root@sysadm-fs:~# mount /dev/vg1/lvol0 /tmp/new/
```
- Задание 13

Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz.
```text
root@sysadm-fs:~# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
--2022-11-11 15:11:30--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 23293093 (22M) [application/octet-stream]
Saving to: ‘/tmp/new/test.gz’

/tmp/new/test.gz                                   100%[===============================================================================================================>]  22.21M  4.71MB/s    in 5.2s    

2022-11-11 15:11:36 (4.28 MB/s) - ‘/tmp/new/test.gz’ saved [23293093/23293093]
```
- Задание 14

Прикрепите вывод lsblk.
```text
root@sysadm-fs:~# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 67.2M  1 loop  /snap/lxd/21835
loop1                       7:1    0 61.9M  1 loop  /snap/core20/1328
loop2                       7:2    0 43.6M  1 loop  /snap/snapd/14978
loop3                       7:3    0 63.2M  1 loop  /snap/core20/1695
loop4                       7:4    0   48M  1 loop  /snap/snapd/17336
loop5                       7:5    0 67.8M  1 loop  /snap/lxd/22753
sda                         8:0    0   64G  0 disk  
├─sda1                      8:1    0    1M  0 part  
├─sda2                      8:2    0  1.5G  0 part  /boot
└─sda3                      8:3    0 62.5G  0 part  
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk  
├─sdb2                      8:18   0    2G  0 part  
│ └─md1                     9:1    0    2G  0 raid1 
└─sdb3                      8:19   0  511M  0 part  
  └─md0                     9:0    0 1018M  0 raid0 
    └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new
sdc                         8:32   0  2.5G  0 disk  
├─sdc2                      8:34   0    2G  0 part  
│ └─md1                     9:1    0    2G  0 raid1 
└─sdc3                      8:35   0  511M  0 part  
  └─md0                     9:0    0 1018M  0 raid0 
    └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new
```
- Задание 15

Протестируйте целостность файла:
```text
root@sysadm-fs:~# gzip -t /tmp/new/test.gz
root@sysadm-fs:~# echo $?
0
```
- Задание 16

Используя pvmove, переместите содержимое PV с RAID0 на RAID1.
```text
root@sysadm-fs:~# pvmove /dev/md0
  /dev/md0: Moved: 32.00%
  /dev/md0: Moved: 100.00%
root@sysadm-fs:~# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 67.2M  1 loop  /snap/lxd/21835
loop1                       7:1    0 61.9M  1 loop  /snap/core20/1328
loop2                       7:2    0 43.6M  1 loop  /snap/snapd/14978
loop3                       7:3    0 63.2M  1 loop  /snap/core20/1695
loop4                       7:4    0   48M  1 loop  /snap/snapd/17336
loop5                       7:5    0 67.8M  1 loop  /snap/lxd/22753
sda                         8:0    0   64G  0 disk  
├─sda1                      8:1    0    1M  0 part  
├─sda2                      8:2    0  1.5G  0 part  /boot
└─sda3                      8:3    0 62.5G  0 part  
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk  
├─sdb2                      8:18   0    2G  0 part  
│ └─md1                     9:1    0    2G  0 raid1 
│   └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new
└─sdb3                      8:19   0  511M  0 part  
  └─md0                     9:0    0 1018M  0 raid0 
sdc                         8:32   0  2.5G  0 disk  
├─sdc2                      8:34   0    2G  0 part  
│ └─md1                     9:1    0    2G  0 raid1 
│   └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new
└─sdc3                      8:35   0  511M  0 part  
  └─md0                     9:0    0 1018M  0 raid0 
```
- Задание 17

Сделайте --fail на устройство в вашем RAID1 md.
```text
root@sysadm-fs:~# mdadm /dev/md1 --fail /dev/sdb2
mdadm: set /dev/sdb2 faulty in /dev/md1
root@sysadm-fs:~# mdadm --detail /dev/md1
/dev/md1:
           Version : 1.2
     Creation Time : Fri Nov 11 14:49:34 2022
        Raid Level : raid1
        Array Size : 2094080 (2045.00 MiB 2144.34 MB)
     Used Dev Size : 2094080 (2045.00 MiB 2144.34 MB)
      Raid Devices : 2
     Total Devices : 2
       Persistence : Superblock is persistent

       Update Time : Fri Nov 11 15:18:11 2022
             State : clean, degraded 
    Active Devices : 1
   Working Devices : 1
    Failed Devices : 1
     Spare Devices : 0

Consistency Policy : resync

              Name : sysadm-fs:1  (local to host sysadm-fs)
              UUID : 24d7b57b:dbcffc72:38a8b151:b6c67f8a
            Events : 19

    Number   Major   Minor   RaidDevice State
       -       0        0        0      removed
       1       8       34        1      active sync   /dev/sdc2

       0       8       18        -      faulty   /dev/sdb2
```
- Задание 18

Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.
```text
root@sysadm-fs:~# dmesg | grep md1
[ 1748.932754] md/raid1:md1: not clean -- starting background reconstruction
[ 1748.932755] md/raid1:md1: active with 2 out of 2 mirrors
[ 1748.932795] md1: detected capacity change from 0 to 2144337920
[ 1748.941064] md: resync of RAID array md1
[ 1759.211188] md: md1: resync done.
[ 3465.316113] md/raid1:md1: Disk failure on sdb2, disabling device.
               md/raid1:md1: Operation continuing on 1 devices.
```
- Задание 19

Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:
```text
root@sysadm-fs:~# gzip -t /tmp/new/test.gz && echo $?
0
```
- Задание 20

Погасите тестовый хост, vagrant destroy.
```text
==> default: Discarding saved state of VM...
==> default: Destroying VM and associated drives...
```