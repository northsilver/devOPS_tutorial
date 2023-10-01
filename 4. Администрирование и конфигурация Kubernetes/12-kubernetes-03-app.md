### Задание 1

1. Cоздаем [манифест](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-03-app/pre.yaml)

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-03-app$ sudo kubectl apply -f pre.yaml 
deployment.apps/pre created
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-03-app$ sudo kubectl get pods
NAME                   READY   STATUS    RESTARTS   AGE
pre-84f45956b8-9kff7   2/2     Running   0          24s
```

2. Мастшабируем

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-03-app$ sudo kubectl scale deployment pre --replicas=2
deployment.apps/pre scaled
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-03-app$ sudo kubectl get pods
NAME                   READY   STATUS    RESTARTS   AGE
pre-84f45956b8-9kff7   2/2     Running   0          2m44s
pre-84f45956b8-b4psx   2/2     Running   0          10s
```


3. Создаем [сервис](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-03-app/svc.yaml)

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-03-app$ sudo kubectl apply -f svc.yaml 
service/pre-service created
```

4. Отдельный под для multitool

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-03-app$ sudo kubectl run multitool --image=wbitt/network-multitool --restart=Never
pod/multitool created
```
и проверка доступности
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-03-app$ sudo kubectl exec -it multitool -- curl pre-service
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

### Задание 2

1. Cоздаем [манифест](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-03-app/nginx.yaml)
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-03-app$ sudo kubectl apply -f nginx.yaml 
deployment.apps/nginx-deployment created
```
2. Проверяем статус
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-03-app$ sudo kubectl get pods
NAME                                READY   STATUS     RESTARTS   AGE
multitool                           1/1     Running    0          8m26s
nginx-deployment-5ccbd7ff9b-rlvwd   0/1     Init:0/1   0          12s
```
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-03-app$ sudo kubectl describe pod nginx-deployment
Name:             nginx-deployment-5ccbd7ff9b-rlvwd
Namespace:        default
Priority:         0
Service Account:  default
Node:             microk8s/10.0.2.15
Start Time:       Sun, 01 Oct 2023 12:15:33 +0300
Labels:           app=nginx
                  pod-template-hash=5ccbd7ff9b
Annotations:      cni.projectcalico.org/containerID: 167f9d383d0632040d54ab3c07cf5c09cd3ed607c350233268c50cf8d5bee189
                  cni.projectcalico.org/podIP: 10.1.128.211/32
                  cni.projectcalico.org/podIPs: 10.1.128.211/32
Status:           **Pending**
```
3. Cоздаем [сервис](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-03-app/svc2.yaml)

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-03-app$ sudo kubectl apply -f svc2.yaml 
service/nginx-service created
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-03-app$ sudo kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
multitool                           1/1     Running   0          11m
nginx-deployment-5ccbd7ff9b-rlvwd   1/1     Running   0          3m9s
```

4. Проверяем статус

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-03-app$ sudo kubectl describe pod nginx-deployment
Name:             nginx-deployment-5ccbd7ff9b-rlvwd
Namespace:        default
Priority:         0
Service Account:  default
Node:             microk8s/10.0.2.15
Start Time:       Sun, 01 Oct 2023 12:15:33 +0300
Labels:           app=nginx
                  pod-template-hash=5ccbd7ff9b
Annotations:      cni.projectcalico.org/containerID: 167f9d383d0632040d54ab3c07cf5c09cd3ed607c350233268c50cf8d5bee189
                  cni.projectcalico.org/podIP: 10.1.128.211/32
                  cni.projectcalico.org/podIPs: 10.1.128.211/32
Status:           **Running**
```

