# Playbook
Cодержит три плея: Install Clickhouse , Install Vector, Install Lighthouse.
## Install Clickhouse.
### [Переменные](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-03-yandex/playbook/group_vars/clickhouse/vars.yml)
Определяют версию clickhouse и устанавливаемые пакеты.
### Tasks:
1. Get clickhouse distrib - скачивает дистрибутив нужной версии.
2. Install clickhouse packages - устанавливает полученный дистрибутив.
   Через handler (Start clickhouse service) запускает service clickhouse. 
3. Pause for 10 seconds - пауза 10 секунд для перезапуска  clickhouse.
4. Create database - создаёт базу данных `logs`.
## Install Vector.
### [Переменные](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-03-yandex/playbook/group_vars/vector/vars.yml)
Определяют версию clickhouse и устанавливаемые пакеты.
### Tasks:
1. Get Vector version - проверяет установлен ли vector.
2. Create directory vector - создает директорию для установки.
3. Get vector distrib - скачивает требуемую версию vector.
4. Configuring service vector - настраивает работу vector в качестве сервиса и запускает его.

Для создания окружения использовался yandex cloud.
## Install Lighthouse.
### [Переменные](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/08-ansible-03-yandex/playbook/group_vars/lighthouse/vars.yml)
Определяют следующие параметры nginx:
1. Путь для файла репозитория.
2. Путь ко корневой директории.
3. Путь до конфига по умолчанию.

Определяют следующие параметры lighthouse:
1. Директорию для дистрибутива.
2. Путь для архива с дистрибутивом.
3. Url для получения дистрибутива.
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
