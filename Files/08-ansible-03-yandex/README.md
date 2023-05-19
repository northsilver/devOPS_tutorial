# Playbook для установки Clickhouse,Vector,Lighthouse
## Содержание

- [Общение описание](#Общение-описание)  
- [Требования](#Требования)
- [Параметры и зависимости ](#Параметры-и-зависимости )
- [Play Install Clickhouse](#Play-Install-Clickhouse)
- [Play Install Vector](#Play-Install-Vector)
- [Play Install Lighthouse](#Play-Install-Lighthouse)

## Общение описание

Развернет на каждом из указанных хостов по одному приложению:

- Clickhouse
- Vector
- Lighthouse

#### Требования 
- Минимальные системные требования `CPU/RAM/Memory` - `2 core/ 2 gb / 20 gb`
- Плейбук оринеторван на ОС Centos7
- Для создания окружения использовался yandex cloud

#### Параметры и зависимости 
- IP развертки хостов нужно указать в файле [prod.yml](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-03-yandex/playbook/inventory/prod.yml)
- Приложения Clickhouse и Vector будут установлены как службы, Lighthouse будет установлен в `/usr/share/lighthouse`
- На хосте с Lighthouse будет запущен `nginx`
- Плейбук содержит три плея: Install Clickhouse , Install Vector, Install Lighthouse.

#### Теги
Тег | Описание
---------- | --------
сlickhouse | Установка Clickhouse
vector | Установка Vector
lighthouse | Установка Lighthouse

## Play Install Clickhouse.
### [Переменные](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-03-yandex/playbook/group_vars/clickhouse/vars.yml)
Переменная | Описание
---------- | --------
clickhouse_version | Требуемая к установке версия дистрибутива
clickhouse_packages | Список требуемых к установке пакетов
### Tasks:
1. Get clickhouse distrib - скачивает дистрибутив нужной версии.
2. Install clickhouse packages - устанавливает полученный дистрибутив.
   Через handler (Start clickhouse service) запускает service clickhouse. 
3. Pause for 10 seconds - пауза 10 секунд для перезапуска  clickhouse.
4. Create database - создаёт базу данных `logs`.
## Play Install Vector.
### [Переменные](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-03-yandex/playbook/group_vars/vector/vars.yml)
Переменная | Описание
---------- | --------
vector_version | Требуемая к установке версия дистрибутива
vector_path | Директория для дистрибутива Vector
vector_data_path | Директория для компонентов Vector
vector_config | Путь к файлу конфигурации

### Tasks:
1. Get Vector version - проверяет установлен ли vector.
2. Create directory vector - создает директорию для установки.
3. Get vector distrib - скачивает требуемую версию vector.
4. Configuring service vector - настраивает работу vector в качестве сервиса и запускает его.

## Play Install Lighthouse.
### [Переменные](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-03-yandex/playbook/group_vars/lighthouse/vars.yml)
Переменная | Описание
---------- | --------
nginx_repo_path | Путь для файла репозитория Nginx
nginx_root| Путь ко корневой директории Nginx
nginx_conf | Путь до конфига Nginx по умолчанию
lh_arch_dir_path | Директория для дистрибутива lighthouse
lh_arch_path | Путь для архива с дистрибутивом lighthouse
lh_uri_distr | Url для получения дистрибутива 

### Tasks:
Установка и настройка nginx:
1. [Add repositories nginx](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-03-yandex/playbook/templates/nginx.repo.j2) - создает по шаблону файл репозитория.
2. Install nginx - устанавливает nginx.
3. Configuring service nginx - настраивает работу nginx в качестве сервиса и запускает его.
Установка и настройка lighthouse:
1. Create directory lighthouse - создает директорию для lighthouse.
2. Get lighthouse distrib - скачивает дистрибутив lighthouse.
3. Install unzip - устанавливает unzip.
4. Unarchive lighthouse - распаковывает дистрибутив lighthouse.
5. [Apply nginx config](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-03-yandex/playbook/templates/nginx.conf.j2) - изменяет по шаблону конфиг nginx и перезапускает его.
