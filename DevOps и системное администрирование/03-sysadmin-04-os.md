1) На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:
        поместите его в автозагрузку,
        предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
        удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.


vagrant@vagrant:/etc/systemd$ ps -e |grep node_exporter
   3359 ?        00:00:00 node_exporter
vagrant@vagrant:/etc/systemd$ sudo systemctl stop node_exporter
vagrant@vagrant:/etc/systemd$ ps -e |grep node_exporter
vagrant@vagrant:/etc/systemd$ sudo systemctl start node_exporter
vagrant@vagrant:/etc/systemd$ ps -e |grep node_exporter
   3422 ?        00:00:00 node_exporter

Конфигурация:
vagrant@vagrant:/etc/systemd$ cat /etc/systemd/node_exporter.service
[Unit]
Description=Prometheus Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
EnvironmentFile=/usr/local/node_exporter

[Install]
WantedBy=default.target

Добавляется переменная MYOPTION 
vagrant@vagrant:/tmp$ sudo cat /proc/642/environ 
LANG=en_US.UTF-8PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/binHOME=/home/node_exporterLOGNAME=node_exporterUSER=node_exporterINVOCATION_ID=98137e97648c4eeba8c35e64f4e0ba15JOURNAL_STREAM=9:23076MYOPTION=NEW_VALUE

2) Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

CPU:
    node_cpu_seconds_total{cpu="0",mode="idle"} 339.79
    node_cpu_seconds_total{cpu="0",mode="system"} 8.64
    node_cpu_seconds_total{cpu="0",mode="user"} 7.87
    process_cpu_seconds_total
    
Memory:
    node_memory_MemAvailable_bytes
    
Disk:
    node_disk_io_time_seconds_total{device="sda"} 
    node_disk_read_bytes_total{device="sda"} 
    node_disk_read_time_seconds_total{device="sda"} 
    node_disk_write_time_seconds_total{device="sda"}
    
Network:
    node_network_receive_errs_total{device="eth0"} 
    node_network_receive_bytes_total{device="eth0"} 
    node_network_transmit_bytes_total{device="eth0"}
    node_network_transmit_errs_total{device="eth0"}


3) Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata).

    После успешной установки:
        в конфигурационном файле /etc/netdata/netdata.conf в секции [web] замените значение с localhost на bind to = 0.0.0.0,
        добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте vagrant reload:

    config.vm.network "forwarded_port", guest: 19999, host: 19999

    После успешной перезагрузки в браузере на своем ПК (не в виртуальной машине) вы должны суметь зайти на localhost:19999. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.

Локальная машина:
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Vagrant$ sudo lsof -i :19999
COMMAND     PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
firefox    2605 ivan  122u  IPv4 123374      0t0  TCP localhost:46932->localhost:19999 (ESTABLISHED)
firefox    2605 ivan  124u  IPv4 120510      0t0  TCP localhost:46940->localhost:19999 (ESTABLISHED)
firefox    2605 ivan  130u  IPv4 126101      0t0  TCP localhost:46944->localhost:19999 (ESTABLISHED)
firefox    2605 ivan  131u  IPv4 118632      0t0  TCP localhost:46952->localhost:19999 (ESTABLISHED)
VBoxHeadl 12057 ivan   20u  IPv4 122210      0t0  TCP localhost:19999 (LISTEN)
VBoxHeadl 12057 ivan   28u  IPv4 120509      0t0  TCP localhost:19999->localhost:46932 (ESTABLISHED)
VBoxHeadl 12057 ivan   29u  IPv4 123375      0t0  TCP localhost:19999->localhost:46940 (ESTABLISHED)
VBoxHeadl 12057 ivan   30u  IPv4 123376      0t0  TCP localhost:19999->localhost:46944 (ESTABLISHED)
VBoxHeadl 12057 ivan   31u  IPv4 123378      0t0  TCP localhost:19999->localhost:46952 (ESTABLISHED)

VM:
vagrant@vagrant:~$ sudo lsof -i :19999
COMMAND PID    USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
netdata 638 netdata    4u  IPv4  21320      0t0  TCP *:19999 (LISTEN)
netdata 638 netdata   51u  IPv4  27893      0t0  TCP vagrant:19999->_gateway:46944 (ESTABLISHED)



4) Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

Да
vagrant@vagrant:~$ dmesg | grep virtualiz
[    0.002378] CPU MTRRs all blank - virtualized system.
[    0.066686] Booting paravirtualized kernel on KVM
[    0.269528] Performance Events: PMU not available due to virtualization, using software events only.
[    3.041896] systemd[1]: Detected virtualization oracle.


5) Как настроен sysctl fs.nr_open на системе по-умолчанию? Определите, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?
vagrant@vagrant:~$ /sbin/sysctl -n fs.nr_open
1048576
vagrant@vagrant:~$ cat /proc/sys/fs/file-max 
9223372036854775807



6) Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.

Запустил
vagrant@vagrant:~$ sudo unshare --fork --pid --mount-proc sleep 1h

Переключился
vagrant@vagrant:/tmp$ ps -e |grep sleep
   2077 pts/0    00:00:00 sleep
vagrant@vagrant:/tmp$ nsenter --target 2077 --pid --mount
nsenter: cannot open /proc/2077/ns/pid: Permission denied
vagrant@vagrant:/tmp$ sudo nsenter --target 2077 --pid --mount
root@vagrant:/# ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0   7228   516 pts/0    S+   17:07   0:00 sleep 1h
root           2  0.0  0.4   8960  4072 pts/1    S    17:08   0:00 -bash
root          13  0.0  0.3  10612  3308 pts/1    R+   17:09   0:00 ps aux


7) Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации.
Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

Эта функция, которая параллельно пускает два своих экземпляра. Каждый пускает ещё по два и т.д
Ограничение кол-ва процессов пользователя - 1000:
[ 2105.410944] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-3.scope
Можно изменить через ulimit -u