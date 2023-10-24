### Задание 1

Создал :
[Front](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-05-net2/front.yaml)
[Back](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-05-net2/back.yaml)
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-05-net2$ sudo kubectl apply -f back.yaml
deployment.apps/backend created
service/backend-svc created
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-05-net2$ sudo kubectl apply -f front.yaml
deployment.apps/frontend-nginx created
service/frontend-svc created
```
Статус
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-05-net2$ sudo kubectl get deployment,pods,svc
NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/backend          1/1     1            1           82s
deployment.apps/frontend-nginx   3/3     3            3           70s

NAME                                  READY   STATUS    RESTARTS   AGE
pod/backend-5dd77f6686-54wzx          1/1     Running   0          82s
pod/frontend-nginx-5997d4c674-6c9rs   1/1     Running   0          70s
pod/frontend-nginx-5997d4c674-sb8d4   1/1     Running   0          70s
pod/frontend-nginx-5997d4c674-ckx2f   1/1     Running   0          70s

NAME                   TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/kubernetes     ClusterIP   10.152.183.1     <none>        443/TCP          30d
service/backend-svc    NodePort    10.152.183.143   <none>        9002:30081/TCP   82s
service/frontend-svc   NodePort    10.152.183.180   <none>        9001:30080/TCP   70s
```

Проверка с фронта в бэк
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-05-net2$ sudo kubectl exec frontend-nginx-5997d4c674-6c9rs -- curl 10.152.183.143:9002
WBITT Network MultiTool (with NGINX) - backend-5dd77f6686-54wzx - 10.1.128.226 - HTTP: 8080 , HTTPS: 443 . (Formerly praqma/network-multitool)
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   143  100   143    0     0   139k      0 --:--:-- --:--:-- --:--:--  139k
```

Проверка с бэка в фронт
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-05-net2$ sudo kubectl exec backend-5dd77f6686-54wzx -- curl 10.152.183.180:9001
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
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   615  100   615    0     0   831k      0 --:--:-- --:--:-- --:--:--  600k
```

### Задание 2
Включил ingress 
```bash
microk8s enable ingress
```
Создал [Ingress](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-05-net2/ingress.yaml)
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-05-net2$ sudo kubectl apply -f ingress.yaml 
Warning: annotation "kubernetes.io/ingress.class" is deprecated, please use 'spec.ingressClassName' instead
ingress.networking.k8s.io/ingress created
```

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-05-net2$ curl ingress-test.com
WBITT Network MultiTool (with NGINX) - backend-5dd77f6686-54wzx - 10.1.128.227 - HTTP: 8080 , HTTPS: 443 . (Formerly praqma/network-multitool)
vagrant@vagrant:
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-05-net2$ curl ingress-test.com/api
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