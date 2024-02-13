# Terraform providers
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

}

provider "yandex" {
  token     = var.yc_token_id
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone = var.yc_zone
}

# Kubespray preparation
## Ansible inventory for Kuberspray
resource "local_file" "ansible-inventory-kubespray" {
  content = <<EOF
all:
  hosts:
    ${yandex_compute_instance.master-vm.fqdn}:
      ansible_host: ${yandex_compute_instance.master-vm.network_interface.0.ip_address}
      ip: ${yandex_compute_instance.master-vm.network_interface.0.ip_address}
      access_ip: ${yandex_compute_instance.master-vm.network_interface.0.ip_address}
    ${yandex_compute_instance.worker-vm-1.fqdn}:
      ansible_host: ${yandex_compute_instance.worker-vm-1.network_interface.0.ip_address}
      ip: ${yandex_compute_instance.worker-vm-1.network_interface.0.ip_address}
      access_ip: ${yandex_compute_instance.worker-vm-1.network_interface.0.ip_address}
    ${yandex_compute_instance.worker-vm-2.fqdn}:
      ansible_host: ${yandex_compute_instance.worker-vm-2.network_interface.0.ip_address}
      ip: ${yandex_compute_instance.worker-vm-2.network_interface.0.ip_address}
      access_ip: ${yandex_compute_instance.worker-vm-2.network_interface.0.ip_address}
    ${yandex_compute_instance.worker-vm-3.fqdn}:
      ansible_host: ${yandex_compute_instance.worker-vm-3.network_interface.0.ip_address}
      ip: ${yandex_compute_instance.worker-vm-3.network_interface.0.ip_address}
      access_ip: ${yandex_compute_instance.worker-vm-3.network_interface.0.ip_address}
  children:
    kube_control_plane:
      hosts:
        ${yandex_compute_instance.master-vm.fqdn}:
    kube_node:
      hosts:
        ${yandex_compute_instance.worker-vm-1.fqdn}:
        ${yandex_compute_instance.worker-vm-2.fqdn}:
        ${yandex_compute_instance.worker-vm-3.fqdn}:
    etcd:
      hosts:
        ${yandex_compute_instance.master-vm.fqdn}:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
  EOF
  filename = "../ansible/ansible-inventory-kubespray"
  depends_on = [yandex_compute_instance.master-vm, yandex_compute_instance.worker-vm-1, yandex_compute_instance.worker-vm-2, yandex_compute_instance.worker-vm-3]
}

## Ansible inventory for master-vm
resource "local_file" "ansible-inventory-master-vm" {
  content = <<-DOC
    kuber:
      hosts:
        ${yandex_compute_instance.master-vm.fqdn}:
          ansible_host: ${yandex_compute_instance.master-vm.network_interface.0.nat_ip_address}
    DOC
  filename = "../ansible/ansible-inventory-master-vm"
  depends_on = [yandex_compute_instance.master-vm, yandex_compute_instance.worker-vm-1, yandex_compute_instance.worker-vm-2, yandex_compute_instance.worker-vm-3]
}

## Ansible inventory for Kubespray configuration
resource "null_resource" "ansible-kubespray-k8s-config" {
  provisioner "local-exec" {
    command = "wget --quiet https://raw.githubusercontent.com/kubernetes-sigs/kubespray/master/inventory/sample/group_vars/k8s_cluster/k8s-cluster.yml -O ../ansible/k8s-cluster.yml"
  }
  depends_on = [yandex_compute_instance.master-vm, yandex_compute_instance.worker-vm-1, yandex_compute_instance.worker-vm-2, yandex_compute_instance.worker-vm-3]
}
resource "null_resource" "ansible-kubespray-k8s-config-add" {
  provisioner "local-exec" {
    command = "echo 'supplementary_addresses_in_ssl_keys: [ ${yandex_compute_instance.master-vm.network_interface.0.nat_ip_address} ]' >> ../ansible/k8s-cluster.yml"
  }
  depends_on = [null_resource.ansible-kubespray-k8s-config]
}

## Script for installation of Kubernetes with Kubespray
resource "local_file" "install-kubernetes-with-kubespray" {
  content = <<-DOC
    #!/bin/bash
    set -euxo pipefail
    export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ansible-inventory-master-vm prepare-master.yml
    sleep 20
    ssh ubuntu@${yandex_compute_instance.master-vm.network_interface.0.nat_ip_address} 'export ANSIBLE_HOST_KEY_CHECKING=False; export ANSIBLE_ROLES_PATH=/home/ubuntu/kubespray/roles:/home/ubuntu/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles; ansible-playbook -i /home/ubuntu/kubespray/inventory/mycluster/hosts.yaml -u ubuntu -b -v --private-key=/home/ubuntu/.ssh/id_rsa /home/ubuntu/kubespray/cluster.yml'
    sleep 20
    export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ansible-inventory-master-vm get-kubeconfig.yml
    sleep 5
    sed -i -e 's,server: https://127.0.0.1:6443,server: https://${yandex_compute_instance.master-vm.network_interface.0.nat_ip_address}:6443,g'  ~/.kube/config
    DOC
  filename = "../ansible/install-kubernetes-with-kubespray.sh"
  depends_on = [yandex_compute_instance.master-vm, yandex_compute_instance.worker-vm-1, yandex_compute_instance.worker-vm-2, yandex_compute_instance.worker-vm-3]
}

## Set execution bit on install script
resource "null_resource" "chmod" {
  provisioner "local-exec" {
    command = "chmod 755 ../ansible/install-kubernetes-with-kubespray.sh"
  }
  depends_on = [local_file.install-kubernetes-with-kubespray]
}