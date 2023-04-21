- Задание 1 

Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```text
route-views>show ip route 95.161.90.208   
Routing entry for 95.161.90.0/24
  Known via "bgp 6447", distance 20, metric 0
  Tag 6939, type external
  Last update from 64.71.137.241 1d18h ago
  Routing Descriptor Blocks:
  * 64.71.137.241, from 64.71.137.241, 1d18h ago
      Route metric is 0, traffic share count is 1
      AS Hops 2
      Route tag 6939
      MPLS label: none

route-views>show bgp 95.161.90.208     
BGP routing table entry for 95.161.90.0/24, version 2580324768
Paths: (4 available, best #3, table default)
  Not advertised to any peer
  Refresh Epoch 1
  1351 6939 42065, (aggregated by 65500 185.26.72.2)
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      path 7FE18B2401C8 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20130 6939 42065, (aggregated by 65500 185.26.72.2)
    140.192.8.16 from 140.192.8.16 (140.192.8.16)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      path 7FE0ABA82210 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  6939 42065, (aggregated by 65500 185.26.72.2)
    64.71.137.241 from 64.71.137.241 (216.218.252.164)
      Origin IGP, localpref 100, valid, external, atomic-aggregate, best
      path 7FE037232BE8 RPKI State valid
      rx pathid: 0, tx pathid: 0x0
  Refresh Epoch 1
  3303 6939 42065, (aggregated by 65500 185.26.72.2)
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 3303:1006 3303:1021 3303:1030 3303:3067 6939:7337 6939:8752 6939:9002
      path 7FE0E915C900 RPKI State valid
      rx pathid: 0, tx pathid: 0
```
- Задание 2

Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.
```text
ivan@ivan-ThinkPad-X395:~$ ifconfig 
dummy0: flags=195<UP,BROADCAST,RUNNING,NOARP>  mtu 1500
        inet 192.168.0.150  netmask 255.255.255.0  broadcast 0.0.0.0
        inet6 fe80::200:ff:fe11:1111  prefixlen 64  scopeid 0x20<link>
        ether 00:00:00:11:11:11  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 4  bytes 280 (280.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ivan@ivan-ThinkPad-X395:~$ ip route show
default via 192.168.0.1 dev wlp1s0 proto dhcp metric 600 
169.254.0.0/16 dev wlp1s0 scope link metric 1000 
192.168.0.0/24 dev wlp1s0 proto kernel scope link src 192.168.0.108 metric 600 
172.16.0.0/16 dev wlp1s0 proto kernel scope link src 192.168.0.108 metric 100 
10.117.0.0/24 dev wlp1s0 proto kernel scope link src 192.168.0.108 metric 100
```
- Задание 3

Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.
```text
systemd-r - системный DNS
cupsd - сервис печати
java - ява

ivan@ivan-ThinkPad-X395:~$ sudo lsof -i -P -n | grep LISTEN
systemd-r  560 systemd-resolve   14u  IPv4  31882      0t0  TCP 127.0.0.53:53 (LISTEN)
cupsd      953            root    6u  IPv6  33097      0t0  TCP [::1]:631 (LISTEN)
cupsd      953            root    7u  IPv4  33098      0t0  TCP 127.0.0.1:631 (LISTEN)
java      4896            ivan   12u  IPv6  69673      0t0  TCP 127.0.0.1:6942 (LISTEN)
java      4896            ivan   49u  IPv6  66114      0t0  TCP 127.0.0.1:63342 (LISTEN)
```
- Задание 4 

Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?
```text
Опять же DNS и печать
Avahi-daemon - система обеспечивающая обнаружение сервисов в локальной сети

ivan@ivan-ThinkPad-X395:~$ ss -ua
State                  Recv-Q                 Send-Q                                        Local Address:Port                                   Peer Address:Port                  Process                
UNCONN                 0                      0                                                   0.0.0.0:631                                         0.0.0.0:*                                            
UNCONN                 0                      0                                                   0.0.0.0:37308                                       0.0.0.0:*                                            
UNCONN                 0                      0                                                   0.0.0.0:mdns                                        0.0.0.0:*                                            
UNCONN                 0                      0                                             127.0.0.53%lo:domain                                      0.0.0.0:*                                            
ESTAB                  0                      0                                      192.168.0.108%wlp1s0:bootpc                                  192.168.0.1:bootps                                       
UNCONN                 0                      0                                                      [::]:49911                                          [::]:*                                            
UNCONN                 0                      0                                                      [::]:mdns                                           [::]:*                                    

ivan@ivan-ThinkPad-X395:~$ sudo netstat -tulpn 
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      560/systemd-resolve 
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      953/cupsd           
tcp6       0      0 127.0.0.1:6942          :::*                    LISTEN      4896/java           
tcp6       0      0 ::1:631                 :::*                    LISTEN      953/cupsd           
tcp6       0      0 127.0.0.1:63342         :::*                    LISTEN      4896/java           
udp        0      0 0.0.0.0:631             0.0.0.0:*                           1750/cups-browsed   
udp        0      0 0.0.0.0:37308           0.0.0.0:*                           786/avahi-daemon: r 
udp        0      0 0.0.0.0:5353            0.0.0.0:*                           786/avahi-daemon: r 
udp        0      0 127.0.0.53:53           0.0.0.0:*                           560/systemd-resolve 
udp6       0      0 :::49911                :::*                                786/avahi-daemon: r 
udp6       0      0 :::5353                 :::*                                786/avahi-daemon: r 
```
- Задание 5

Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.
```text
Отдельным файлом
```