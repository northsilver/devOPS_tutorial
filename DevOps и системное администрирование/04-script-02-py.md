- Задание 1

Какое значение будет присвоено переменной c?
> будет ошибка потому что не получилось сложить число и стороку.

Как получить для переменной c значение 12?
> сделать из а строку - c=str(a)+b

Как получить для переменной c значение 3?
> сделать из б целое число - c=a+int(b)

- Задание 2

```python
import os

bash_command = ["cd ~/proj/devOPS_tutorial", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        dir = os.path.dirname(os.path.abspath(__file__))
        print("Path:" + dir,"Files:" + prepare_result)
```
Вывод скрипта

```bash
Path:/home/ivan/proj/devOPS_tutorial Files:"4.2.\320\230\321\201\320\277\320\276\320\273\321\214\320\267\320\276\320\262\320\260\320\275\320\270\320\265_Python_\320\264\320\273\321\217_\321\200\320\265\321\210\320\265\320\275\320\270\321\217_\321\202\320\270\320\277\320\276\320\262\321\213\321\205_DevOps_\320\267\320\260\320\264\320\260\321\207.md"
````

- Задание 3

```python
import os
import sys

dir = os.getcwd()
if len(sys.argv)>=2:
    dir = sys.argv[1]
bash_command = ["cd "+dir, "git status 2>&1"]

print('\033[37m')
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('fatal') != -1:
        print('\033[31m Catalog \033[1m '+dir+'\033[0m\033[31m dosen"t have GIT repo\033[0m')    
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified: ', '')
        print("Path:" + dir,"Files:" + prepare_result)
print('\033[0m')
```

Вывод скрипта

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial$ python3 test3.py ~/proj/devOPS_tutorial/
j/devOPS_tutorial/ Files:  "4.2.\320\230\321\201\320\277\320\276\320\273\321\214\320\267\320\276\320\262\320\260\320\275\320\270\320\265_Python_\320\264\320\273\321\217_\321\200\320\265\321\210\320\265\320\275\320\270\321\217_\321\202\320\270\320\277\320\276\320\262\321\213\321\205_DevOps_\320\267\320\260\320\264\320\260\321\207.md"
````

Если нет репозитория

```bash
 ivan@ivan-ThinkPad-X395:~/proj$ python3 test3.py 
 Catalog  /home/ivan/proj dosen"t have GIT repo
````


- Задание 4

```python
import socket as s
import time as t
import datetime as dt

count = 1
wait = 2
servers = {'drive.google.com':'', 'mail.google.com':'','google.com':''}
init=0

while 1==1 : 
  for host in servers:
    ip = s.gethostbyname(host)
    if ip != servers[host]:
      if count==1 and init !=1:
        print(str(dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S")) + ' [ERROR] ' + str(host) + ' IP mistmatch: '+ servers[host]+ ' ' +ip)
      servers[host]=ip
  t.sleep(wait)
```
Результат вывода
```bash
ivan@ivan-ThinkPad-X395:~/proj$ python3 test4.py 
2022-12-27 22:32:42 [ERROR] drive.google.com IP mistmatch:  209.85.233.194
2022-12-27 22:32:42 [ERROR] mail.google.com IP mistmatch:  64.233.161.18
2022-12-27 22:32:42 [ERROR] google.com IP mistmatch:  74.125.205.101
2022-12-27 22:32:44 [ERROR] mail.google.com IP mistmatch: 64.233.161.18 64.233.161.19
2022-12-27 22:32:44 [ERROR] google.com IP mistmatch: 74.125.205.101 74.125.205.139
2022-12-27 22:32:46 [ERROR] google.com IP mistmatch: 74.125.205.139 74.125.205.100
2022-12-27 22:32:48 [ERROR] mail.google.com IP mistmatch: 64.233.161.19 64.233.161.83
2022-12-27 22:32:48 [ERROR] google.com IP mistmatch: 74.125.205.100 74.125.205.101
2022-12-27 22:32:50 [ERROR] mail.google.com IP mistmatch: 64.233.161.83 64.233.161.19
2022-12-27 22:32:50 [ERROR] google.com IP mistmatch: 74.125.205.101 74.125.205.138
2022-12-27 22:32:52 [ERROR] mail.google.com IP mistmatch: 64.233.161.19 64.233.161.17
2022-12-27 22:32:52 [ERROR] google.com IP mistmatch: 74.125.205.138 74.125.205.113
```