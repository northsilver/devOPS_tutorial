- Задание 1

Какой системный вызов делает команда cd?
```text
CD = chdir("/tmp")
```
- Задание 2
 
Попробуйте использовать команду file на объекты разных типов в файловой системе. Например:
```text
openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
```
- Задание 3

Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).
```text
Создать файловый дескриптор и перенаправить поток в него вместо удаленного файла

Использовал Vi, 4 дескриптор удалил предварительно
vagrant@vagrant:$ lsof -p 1641
COMMAND  PID    USER   FD   TYPE DEVICE SIZE/OFF    NODE NAME
........
vi      1641 vagrant  4u    REG  253,0     4096 1835010 /tmp/.test.log (deleted)
vagrant@vagrant:$ echo '' >/proc/1641/fd/4"
```

- Задание 4

Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?
```text
Нет, только находятся в таблице процессов
```
- Задание 5

- В iovisor BCC есть утилита opensnoop:
```text
root@vagrant:~# /usr/sbin/opensnoop-bpfcc 
PID    COMM               FD ERR PATH
641    irqbalance          6   0 /proc/interrupts
641    irqbalance          6   0 /proc/stat
641    irqbalance          6   0 /proc/irq/20/smp_affinity
641    irqbalance          6   0 /proc/irq/0/smp_affinity
641    irqbalance          6   0 /proc/irq/1/smp_affinity
641    irqbalance          6   0 /proc/irq/8/smp_affinity
641    irqbalance          6   0 /proc/irq/12/smp_affinity
641    irqbalance          6   0 /proc/irq/14/smp_affinity
641    irqbalance          6   0 /proc/irq/15/smp_affinity
899    vminfo              6   0 /var/run/utmp
633    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
633    dbus-daemon        20   0 /usr/share/dbus-1/system-services
633    dbus-daemon        -1   2 /lib/dbus-1/system-services
633    dbus-daemon        20   0 /var/lib/snapd/dbus-1/system-services/
```

- Задание 6

Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС.
```text
uname()
Part of the utsname information is also accessible  via  /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.
```
- Задание 7

Чем отличается последовательность команд через ; и через && в bash? 
   Есть ли смысл использовать в bash &&, если применить set -e?
```text
&& - оператор при котором вторая часть отработает только в случае успеха, ;  - разделитель последовательных команд
test -d /tmp/some_dir ; echo Hi - последовательное выполнение
test -d /tmp/some_dir && echo Hi - echo отработает только при успешном завершении команды test
set -e - прервет сессию при любом значении исполняемых команд кроме 0 в конвейере, кроме последней.
&&  вместе с set -e- не имеет смысла, потому что при ошибке выполнение команд прекратиться. 
```

- Задание 8

Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?
```text
set -e -прерывает выполнение исполнения при ошибке любой команды кроме последней
set -u -неустановленные/не заданные параметры и переменные считаются как ошибки
set -o pipefail -возвращает код возврата набора/последовательности команд
set -x -вывод трейса простых команд

Нужен для повышения детализации выполнения команд.
```
- Задание 9

Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. В man ps ознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).
```text
Ss - interruptible sleep
R - running or runnable

Дополнительные символы это характеристики, например приоритет.
```