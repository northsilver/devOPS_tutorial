- Задание 1

- Изучите файл .gitignore. В каком terraform файле допустимо сохранить личную, секретную информацию?
```text
personal.auto.tfvars
```
Выполните код проекта. Найдите в State-файле секретное содержимое созданного ресурса random_password. Пришлите его в качестве ответа.
```text
в файле terraform.tfstate
"result": "Wd8VupiEkG1qWeP1",
```
Раскомментируйте блок кода, примерно расположенный на строчках 29-42 файла main.tf. Выполните команду terraform -validate. Объясните в чем заключаются намеренно допущенные ошибки? Исправьте их.
```text
resource "docker_image" {  - нет имени ресурса
resource "docker_container" "1nginx" {  - название не может начинаться с числа
```
Выполните код. В качестве ответа приложите вывод команды docker ps
```text
ivan@ivan-ThinkPad-X395:~$ sudo docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
cf39c328043a   ac232364af84   "/docker-entrypoint.…"   5 seconds ago   Up 4 seconds   0.0.0.0:8000->80/tcp   example_Wd8VupiEkG1qWeP1

```
Замените имя docker-контейнера в блоке кода на hello_world, выполните команду terraform apply -auto-approve. Объясните своими словами, в чем может быть опасность применения ключа -auto-approve ?
```text
ivan@ivan-ThinkPad-X395:~$ sudo docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
53a23003bafd   ac232364af84   "/docker-entrypoint.…"   6 seconds ago   Up 6 seconds   0.0.0.0:8000->80/tcp   hello_world


terraform apply -auto-approve - позволяет без поверки запустить выполнение конфигурации, в данном случае был перезатерт контейнер.
```
Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.
```text
docker_container.nginx: Destroying... [id=446ec905cdff8bb8e9d51bc8592181ff0f52d5ca3995fd9f0285f9135b93cc34]
docker_container.nginx: Destruction complete after 1s
docker_image.nginx: Destroying... [id=sha256:ac232364af842735579e922641ae2f67d5b8ea97df33a207c5ea05f60c63a92dnginx:latest]
random_password.random_string: Destroying... [id=none]
docker_image.nginx: Destruction complete after 0s
random_password.random_string: Destruction complete after 0s

Destroy complete! Resources: 3 destroyed.
ivan@ivan-ThinkPad-X395:~$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
```text
{
  "version": 4,
  "terraform_version": "1.4.2",
  "serial": 14,
  "lineage": "697bdf96-cb7d-b022-2f0b-de46e8edab46",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```
Объясните, почему при этом не был удален docker образ nginx:latest ?(Ответ найдите в коде проекта или документации)
```text
из за опции keep_locally = true , она указывает, что нужно сохранить образ nginx локально.
```