- Задание 1

Создал сеть
```text
yc vpc network create --name net --labels label=netology --description "net for lab"
yc vpc subnet create --name subnet-a --zone ru-central1-a --range 10.20.30.0/24 --network-name net --description "subnet for lab"
```

Конфигурационный файл для создания имиджа Packer
```text
{
    "builders": [
      {
        "type": "yandex",
        "token": "ключ",
        "folder_id": "b1g231s0849i3kppvp2a",
        "zone": "ru-central1-a",
        "image_name": "ubuntu-2204-base",
        "image_family": "ubuntu-base",
        "image_description": "Ubuntu from Packer",
        "source_image_family": "ubuntu-2204-lts",
        "subnet_id": "e9b6b9q97h8i67i2i4eu",
        "use_ipv4_nat": true,
        "disk_type": "network-ssd",
        "ssh_username": "ubuntu"
      }
    ]
}
```
 
Создание ВМ
```text
yc compute instance create   --name my-packer-ubuntu   --zone ru-central1-a   --create-boot-disk name=disk1,size=10,image-id=fd8bada10ue13vlkdtko   --public-ip   --ssh-key ~/.ssh/id_rsa.pub
```

![Screenshot from 2023-02-12 18-33-12.png](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-02-12%2018-33-12.png)

- Задание 2

![Screenshot from 2023-02-12 18-15-24.png](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-02-12%2018-15-24.png)

- Задание 3

![Screenshot from 2023-02-18 20-54-40.png](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-02-18%2020-54-40.png)

- Задание 4

![Screenshot from 2023-02-18 20-52-31.png](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-02-18%2020-52-31.png)