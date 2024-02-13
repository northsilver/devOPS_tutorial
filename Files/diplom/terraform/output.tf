output "external-ip-address-master-vm" {
  value = "${yandex_compute_instance.master-vm.network_interface.0.nat_ip_address}"
}

output "fqdn-master-vm" {
  value = "${yandex_compute_instance.master-vm.fqdn}"
}