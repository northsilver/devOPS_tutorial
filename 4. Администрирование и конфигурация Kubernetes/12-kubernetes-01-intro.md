### Задание 1

0. Установить по инструкции
```bash
sudo apt update
sudo apt install snapd
sudo snap install microk8s --classic
sudo usermod -a -G microk8s $USER,
sudo chown -f -R $USER ~/.kube.
su $USER
```
 и проверить статус
```bash
microk8s status --wait-ready
microk8s is running
high-availability: no
  datastore master nodes: 127.0.0.1:19001
  datastore standby nodes: none
```
1. Включить дашборд `microk8s enable dashboard`
2. Добавить внешний IP адрес VM в файл `vi /var/snap/microk8s/current/certs/csr.conf.templat`
3. Создать сертификаты `sudo microk8s refresh-certs --cert front-proxy-client.crt`
4. Выплонить проброс портов `microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443 --address='0.0.0.0'`
5. Для авторизации посмотреть токен `microk8s kubectl get secret microk8s-dashboard-token  -n kube-system -o jsonpath={".data.token"} | base64 -d`
6. ![1](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-09-17%2014-13-38.png)

### Задание 2

1. Установил и настроил конфигурацию
```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
```

![2](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-09-17%2021-15-05.png)

```bash
ivan@ivan-ThinkPad-X395:~/.kube$ kubectl get nodes
NAME        STATUS   ROLES    AGE     VERSION
sysadm-fs   Ready    <none>   7h19m   v1.27.5
```