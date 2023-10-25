### Задание 1

Создал [Deployment](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-06-data1/deploy.yaml)
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-06-data1$ sudo kubectl apply -f deploy.yaml
deployment.apps/deploy created
```
Проверил статус
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-06-data1$ sudo kubectl get pods
NAME                      READY   STATUS    RESTARTS   AGE
deploy-7dc78774bd-kxdvd   2/2     Running   0          32s
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-06-data1$ sudo kubectl logs deploy-7dc78774bd-kxdvd -c busybox
Wed Oct 25 16:12:48 UTC 2023
Wed Oct 25 16:12:53 UTC 2023
Wed Oct 25 16:12:58 UTC 2023
Wed Oct 25 16:13:03 UTC 2023
Wed Oct 25 16:13:08 UTC 2023
Wed Oct 25 16:13:13 UTC 2023
Wed Oct 25 16:13:18 UTC 2023
Wed Oct 25 16:13:23 UTC 2023
Wed Oct 25 16:13:28 UTC 2023
Wed Oct 25 16:13:33 UTC 2023
Wed Oct 25 16:13:38 UTC 2023
Wed Oct 25 16:13:43 UTC 2023
Wed Oct 25 16:13:48 UTC 2023
Wed Oct 25 16:13:53 UTC 2023
Wed Oct 25 16:13:58 UTC 2023
Wed Oct 25 16:14:03 UTC 2023
```
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-06-data1$ sudo kubectl exec -it deploy-7dc78774bd-kxdvd -c multitool -- /usr/bin/tail -f /input/date.log
Wed Oct 25 16:14:43 UTC 2023
Wed Oct 25 16:14:48 UTC 2023
Wed Oct 25 16:14:53 UTC 2023
Wed Oct 25 16:14:58 UTC 2023
Wed Oct 25 16:15:03 UTC 2023
Wed Oct 25 16:15:08 UTC 2023
Wed Oct 25 16:15:13 UTC 2023
Wed Oct 25 16:15:18 UTC 2023
Wed Oct 25 16:15:23 UTC 2023
Wed Oct 25 16:15:28 UTC 2023
Wed Oct 25 16:15:33 UTC 2023
Wed Oct 25 16:15:38 UTC 2023
Wed Oct 25 16:15:43 UTC 2023
Wed Oct 25 16:15:48 UTC 2023
Wed Oct 25 16:15:53 UTC 2023
Wed Oct 25 16:15:58 UTC 2023
Wed Oct 25 16:16:03 UTC 2023
Wed Oct 25 16:16:08 UTC 2023
^Ccommand terminated with exit code 130
```

![2](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-10-25%2019-18-36.png)

### Задание 2

Создал [Daemon](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/12-kubernetes-06-data1/daemon.yaml)
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-06-data1$ sudo kubectl apply -f daemon.yaml 
daemonset.apps/multitool created
```

Проверил статус
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-06-data1$ sudo kubectl describe daemonsets.apps
Name:           multitool
Selector:       name=multitool
Node-Selector:  <none>
Labels:         app=multitool
Annotations:    deprecated.daemonset.template.generation: 1
Desired Number of Nodes Scheduled: 1
Current Number of Nodes Scheduled: 1
Number of Nodes Scheduled with Up-to-date Pods: 1
Number of Nodes Scheduled with Available Pods: 1
Number of Nodes Misscheduled: 0
Pods Status:  1 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  name=multitool
  Containers:
   multitool:
    Image:        wbitt/network-multitool
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:
      /var/log/host_syslog from varlog (ro)
  Volumes:
   varlog:
    Type:          HostPath (bare host directory volume)
    Path:          /var/log/syslog
    HostPathType:  File
Events:
  Type    Reason            Age   From                  Message
  ----    ------            ----  ----                  -------
  Normal  SuccessfulCreate  33s   daemonset-controller  Created pod: multitool-z4w8j
```

```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/12-kubernetes-06-data1$ sudo kubectl exec -it multitool-z4w8j  -- /usr/bin/tail -f /var/log/host_syslog
Oct 25 17:46:19 MicroK8S systemd[1]: run-containerd-runc-k8s.io-0dca0285d10bc51bd5207bb7da6d71d347a6f81f4d65736264435fa6bef4df1c-runc.fQXJOz.mount: Succeeded.
Oct 25 17:46:19 MicroK8S systemd[209478]: run-containerd-runc-k8s.io-0dca0285d10bc51bd5207bb7da6d71d347a6f81f4d65736264435fa6bef4df1c-runc.fQXJOz.mount: Succeeded.
Oct 25 17:46:28 MicroK8S microk8s.daemon-kubelite[202833]: E1025 17:46:28.787869  202833 manager.go:1106] Failed to create existing container: /kubepods/besteffort/pod3f6440f7-71ce-428d-a07f-f146f0c45940/84991a5a2468903a5229a2e055e6a13ab1d617407562b1e340b8f0162472579d: task 84991a5a2468903a5229a2e055e6a13ab1d617407562b1e340b8f0162472579d not found: not found
Oct 25 17:46:29 MicroK8S systemd[209478]: run-containerd-runc-k8s.io-0dca0285d10bc51bd5207bb7da6d71d347a6f81f4d65736264435fa6bef4df1c-runc.o4KZdr.mount: Succeeded.
Oct 25 17:46:29 MicroK8S systemd[1]: run-containerd-runc-k8s.io-0dca0285d10bc51bd5207bb7da6d71d347a6f81f4d65736264435fa6bef4df1c-runc.o4KZdr.mount: Succeeded.
Oct 25 17:46:29 MicroK8S systemd[209478]: run-containerd-runc-k8s.io-0dca0285d10bc51bd5207bb7da6d71d347a6f81f4d65736264435fa6bef4df1c-runc.0bwtwx.mount: Succeeded.
Oct 25 17:46:29 MicroK8S systemd[1]: run-containerd-runc-k8s.io-0dca0285d10bc51bd5207bb7da6d71d347a6f81f4d65736264435fa6bef4df1c-runc.0bwtwx.mount: Succeeded.
Oct 25 17:46:31 MicroK8S microk8s.daemon-kubelite[202833]: E1025 17:46:31.905865  202833 manager.go:1106] Failed to create existing container: /kubepods/burstable/pod26379cb2-410b-4ddf-b79a-5bf0fcda2828/eb688b47ccf8bfabfc42acc7e27984ff68d980726783d79b606e017428c7a1bf: task eb688b47ccf8bfabfc42acc7e27984ff68d980726783d79b606e017428c7a1bf not found: not found
Oct 25 17:46:33 MicroK8S systemd[1]: run-containerd-runc-k8s.io-2b832b6a7c40bf38c5e48f934416401f20268c993775509595b0dd9a9367feeb-runc.VyvCVG.mount: Succeeded.
Oct 25 17:46:33 MicroK8S systemd[209478]: run-containerd-runc-k8s.io-2b832b6a7c40bf38c5e48f934416401f20268c993775509595b0dd9a9367feeb-runc.VyvCVG.mount: Succeeded.
```

![2](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-10-25%2020-46-48.png)