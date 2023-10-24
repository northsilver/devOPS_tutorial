### Задание 1

Создал [Deploy](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-04-net1/deploy.yaml)
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-04-net1$ sudo kubectl apply -f deploy.yaml 
deployment.apps/deploy created
```
Проверил статус
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-04-net1$ sudo kubect get pods
NAME                      READY   STATUS    RESTARTS   AGE
deploy-74645d46d8-mlqdg   2/2     Running   0          15m
deploy-74645d46d8-9mz5l   2/2     Running   0          15m
deploy-74645d46d8-7k268   2/2     Running   0          15m
```
Создал [Servce](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-04-net1/svc.yaml)
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-04-net1$ sudo kubectl apply -f svc.yaml 
service/svc created
```
Создал [Pod](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-04-net1/pod.yaml)
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-04-net1$ sudo kubectl apply -f pod.yaml 
pod/multitool created
```
Проверил статус
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-04-net1$ sudo kubectl exec -it multitool -- sh
/ # curl 10.152.183.248:9001
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
/ # curl 10.152.183.248:9002
WBITT Network MultiTool (with NGINX) - deploy-74645d46d8-9mz5l - 10.1.128.217 - HTTP: 8080 , HTTPS: 443 . (Formerly praqma/network-multitool)
```

### Задание 2

Создал [Servce](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-04-net1/svcNodePort.yaml)

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-04-net1$ curl http://192.168.56.12:30080
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

![2](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-10-24%2016-27-39.png)