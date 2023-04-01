variable "vm_image_family" {
  type        = string
  description = "OS release name"
  default     = "ubuntu-2004-lts"
}
data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_family
}
variable "vm_platform_id" {
  type        = string
  description = "VM platform_id"
  default     =   "standard-v1"
}

variable "vm_metadata" {
  type = map
  default = {
    serial-port-enable = 1
  }
}

variable "disk_create" {
  type = map
  default = {
    type       = "network-hdd"
    size = 1
    block_size  = 4096
    auto_delete = true
  }
}

variable "inst_st" {
  type = list
  default = []
}