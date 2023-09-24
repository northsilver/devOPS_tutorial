### Задание 1

1. Создать [манифест](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-02-objects/pod.yaml), который создаст Pod

```bash
apiVersion: v1
kind: Pod
metadata:
  name: hello-world
  namespace: default
spec:
  containers:
  - name: hello-world
    image: gcr.io/kubernetes-e2e-test-images/echoserver:2.2
    ports:
    - containerPort: 8080
```

2. Применить манифест

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-02-objects$ sudo kubectl apply -f pod.yaml 
pod/hello-world created
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-02-objects$ sudo kubectl port-forward pod/hello-world 8080:8080  --address='0.0.0.0'
Forwarding from 0.0.0.0:8080 -> 8080
Handling connection for 8080
```

![1](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-09-24%2013-50-25.png)

### Задание 2

1. Создать [манифест](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-02-objects/service.yaml), который создаст Pod и Service

```bash
apiVersion: v1
kind: Pod
metadata:
  name: netology-web
  labels:
    app: netology-web
spec:
  containers:
  - name: netology-web
    image: gcr.io/kubernetes-e2e-test-images/echoserver:2.2
    ports:
      - containerPort: 8080
        name: ntlg-web-port
        
---
apiVersion: v1
kind: Service
metadata:
  name: netology-svc
spec:
  selector:
    app: netology-web
  ports:
  - name: ntlg-svc-port
    protocol: TCP
    port: 80
    targetPort: ntlg-web-port
```

2. Применить манифест

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-02-objects$ sudo kubectl apply -f service.yaml && \
sudo kubectl get pods && \
sudo kubectl get service && \
sleep 20 && \
sudo kubectl port-forward services/netology-svc 8080:80  --address='0.0.0.0'
pod/netology-web created
service/netology-svc created
NAME           READY   STATUS              RESTARTS   AGE
netology-web   0/1     ContainerCreating   0          0s
NAME           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
kubernetes     ClusterIP   10.152.183.1    <none>        443/TCP   43m
netology-svc   ClusterIP   10.152.183.65   <none>        80/TCP    0s
Forwarding from 0.0.0.0:8080 -> 8080
Handling connection for 8080
```

![2](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-09-24%2014-01-04.png)