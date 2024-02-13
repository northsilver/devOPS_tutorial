# Дипломный практикум в Yandex.Cloud

## Цели:

1. Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.
2. Запустить и сконфигурировать Kubernetes кластер.
3. Установить и настроить систему мониторинга.
4. Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.
5. Настроить CI для автоматической сборки и тестирования.
6. Настроить CD для автоматического развёртывания приложения.


## Оглавление
* [Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.](#1)
* [Запустить и сконфигурировать Kubernetes кластер.](#2)
* [Установить и настроить систему мониторинга.](#3)
* [Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.](#4)
* [Настроить CI для автоматической сборки и тестирования/Настроить CD для автоматического развёртывания приложения.](#5)


<a id="1"></a> 
## Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.

### Подготовка инструментов для работы YC

Проверить настройки и получить токен

```bash
ivan@ivan-ThinkPad-X395:~ yc config list
token: y0_*******_grrDio0
cloud-id: b1gs6fqvan6645otctmr
folder-id: b1gl8p7gd9kjf5d599cd
compute-default-zone: ru-central1-a
ivan@ivan-ThinkPad-X395:~ yc iam create-token
t1.9eue*****jkETavwBg
ivan@ivan-ThinkPad-X395:~ export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
export YC_ZONE=$(yc config get compute-default-zone)
```

Токен добавить в variables.tf

Данные от сервисной учетки использовать в переменных окружения

```bash
export AWS_ACCESS_KEY_ID=YCAJE7SQ***EljKTimBEUD
export AWS_SECRET_ACCESS_KEY=YCMOXozu7Yj3eyHN***_CioWIld4KBdTkvP
```

Все файлы по созданию структуры находятся [тут](https://github.com/northsilver/devOPS_tutorial/tree/master/Files/diplom/terraform)

Скриншот успешного создания остальной структуры

![структура](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202024-02-13%2022-03-35.png)

<a id="2"></a> 
## Запустить и сконфигурировать Kubernetes кластер.

Использовал ansible playbook [запустил с помощью скрипта install-kubernetes-with-kubespray.sh](https://github.com/northsilver/devOPS_tutorial/tree/master/Files/diplom/ansible)

Скриншот успешной развертки

![k8s](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202024-02-13%2022-06-37.png)

<a id="3"></a> 
## Установить и настроить систему мониторинга.

Использовал HELM и пакет ![prometheus](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202024-02-13%2022-07-44.png)

Готовый результат ![grafana](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202024-02-13%2019-21-49.png)

<a id="4"></a> 
## Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.

Собрал, загрузил на докер и репозиторий, к сожалению скриншот обновления версии не сохранился, видно по комитам в репозитории

[Репозиторий](https://github.com/northsilver/webapp-ipcheck-devops)
[Dockerhub](https://hub.docker.com/repository/docker/northsilver/webapp-ipcheck-devops/general)

![app](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202024-02-13%2019-21-27.png)
![dockerhub](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202024-02-13%2021-05-06.png)

<a id="5"></a> 
## Настроить CI для автоматической сборки и тестирования / Настроить CD для автоматического развёртывания приложения.

Создал [Репозиторий](https://github.com/northsilver/ci-cd)

Использовал GitHub Action, манифесты в репозитории

CI
![CI](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202024-02-13%2021-06-40.png)

CD
![CD](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202024-02-13%2021-44-59.png)

DockerHub
![Docker](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202024-02-13%2021-45-09.png)