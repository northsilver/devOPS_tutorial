- Задание 1

Создадим директорию на хостовой машине и создадим докер и html файлы
```bash
vagrant@sysadm-fs:~$ mkdir devOPS_tutorial 
vagrant@sysadm-fs:~/devOPS_tutorial$ touch Dockerfile
vagrant@sysadm-fs:~/devOPS_tutorial$ touch index.html
```

Содержание докер файла
```bash
FROM nginx
COPY index.html /usr/share/nginx/html
```

Создадим образ 
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ sudo docker build -t test-netology .
```

Проверим список образов
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ sudo docker images -a
REPOSITORY                    TAG       IMAGE ID       CREATED             SIZE
test-netology                 latest    ba87a11a3dc1   About an hour ago   142MB
nginx                         latest    9eee96112def   33 hours ago        142MB
```

Запустим контейнер с пробросом порта на виртуальную машину
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ sudo docker run -d -p 80:80 ba87a11a3dc1
```

Убедимся, что он запущен
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ sudo docker ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED             STATUS             PORTS                               NAMES
dc7f5e811de0   ba87a11a3dc1   "/docker-entrypoint.…"   About an hour ago   Up About an hour   0.0.0.0:80->80/tcp, :::80->80/tcp   pensive_northcutt
```

Проверим что страница видна
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ curl 127.0.0.1:80
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```

Загрузим репозиторий на докерхаб
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ sudo docker push northsilver/devops-tutorial:ver0.1
```
- Задание 2
```text
* Высоконагруженное монолитное java веб-приложение - виртуальная машина  
* Nodejs веб-приложение - контейнер    
* Мобильное приложение c версиями для Android и iOS - контейнер 
* Шина данных на базе Apache Kafka - физическая машина   
* Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana - иртуальная машина с контейнерами 
* Мониторинг-стек на базе Prometheus и Grafana - виртуальная машина с контейнерами    
* MongoDB, как основное хранилище данных для java-приложения - физическая машина  
* Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry - виртуальная машина с контейнерами
```

- Задание 3

Создадим файл в директории на хостовой машине
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ cd data/
vagrant@sysadm-fs:~/devOPS_tutorial/data$ touch 1.txt
vagrant@sysadm-fs:~/devOPS_tutorial/data$ ls -la
total 8
drwxrwxr-x 2 vagrant vagrant 4096 Feb  5 20:04 .
drwxrwxr-x 3 vagrant vagrant 4096 Feb  5 19:58 ..
-rw-rw-r-- 1 vagrant vagrant    0 Feb  5 20:04 1.txt
```

Создаем первый контейнер в интерактивном режиме, проверяем наличие файла и создаем свой
```bash
vagrant@sysadm-fs:~/devOPS_tutorial$ sudo docker run -v /home/vagrant/devOPS_tutorial/data:/home/data -it centos
[root@58aced499335 /]# cd home/data/
[root@58aced499335 data]# ls -la
total 8
drwxrwxr-x 2 1000 1000 4096 Feb  5 19:08 .
drwxr-xr-x 1 root root 4096 Feb  5 20:02 ..
[root@58aced499335 data]# ls -la
total 8
drwxrwxr-x 2 1000 1000 4096 Feb  5 20:04 .
drwxr-xr-x 1 root root 4096 Feb  5 20:02 ..
-rw-rw-r-- 1 1000 1000    0 Feb  5 20:04 1.txt
[root@58aced499335 data]# touch centos.txt
```

Создаем второй контейнер в интерактивном режиме, проверяем наличие файла и создаем свой
```bash
vagrant@sysadm-fs:~$ sudo docker run -v /home/vagrant/devOPS_tutorial/data:/home/data -it debian
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
699c8a97647f: Pull complete 
Digest: sha256:92277f7108c432febe41beffd367dbb6dac60b9fbfe517c77208e6457eafe22b
Status: Downloaded newer image for debian:latest
root@82b5e94d3f81:/# cd home/data/
root@82b5e94d3f81:/home/data# ls -la
total 8
drwxrwxr-x 2 1000 1000 4096 Feb  5 19:08 .
drwxr-xr-x 1 root root 4096 Feb  5 20:03 ..
root@82b5e94d3f81:/home/data# ls -la
total 8
drwxrwxr-x 2 1000 1000 4096 Feb  5 20:04 .
drwxr-xr-x 1 root root 4096 Feb  5 20:03 ..
-rw-rw-r-- 1 1000 1000    0 Feb  5 20:04 1.txt
root@82b5e94d3f81:/home/data# touch debian.txt
```

Проверяем на хостовой машине
```bash
vagrant@sysadm-fs:~/devOPS_tutorial/data$ ls -la
total 8
drwxrwxr-x 2 vagrant vagrant 4096 Feb  5 20:04 .
drwxrwxr-x 3 vagrant vagrant 4096 Feb  5 19:58 ..
-rw-rw-r-- 1 vagrant vagrant    0 Feb  5 20:04 1.txt
-rw-r--r-- 1 root    root       0 Feb  5 20:04 centos.txt
-rw-r--r-- 1 root    root       0 Feb  5 20:04 debian.txt
```

Запуск контейнеров в режиме демона
```bash
 sudo  docker run -d \
  -it \
  --name ivan-centos \
  -v /home/vagrant/devOPS_tutorial/data:/home/data \
  centos:latest
```

```bash
 sudo  docker run -d \
  -it \
  --name ivan-debian \
  -v /home/vagrant/devOPS_tutorial/data:/home/data \
  debian:latest
 ```