#!/bin/bash
set -euxo pipefail
export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ansible-inventory-master-vm prepare-master.yml
sleep 20
ssh ubuntu@178.154.223.66 'export ANSIBLE_HOST_KEY_CHECKING=False; export ANSIBLE_ROLES_PATH=/home/ubuntu/kubespray/roles:/home/ubuntu/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles; ansible-playbook -i /home/ubuntu/kubespray/inventory/mycluster/hosts.yaml -u ubuntu -b -v --private-key=/home/ubuntu/.ssh/id_rsa /home/ubuntu/kubespray/cluster.yml'
sleep 20
export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ansible-inventory-master-vm get-kubeconfig.yml
sleep 5
sed -i -e 's,server: https://127.0.0.1:6443,server: https://178.154.223.66:6443,g'  ~/.kube/config
