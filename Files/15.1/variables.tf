###cloud vars
variable "service_account_key_file" {
  type        = string
  default     = "key.json"
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "NET"
  description = "VPC network&subnet name"
}
variable "subnet_public" {
  type        = string
  default     = "public"
  description = "VPC network&subnet name"
}
variable "subnet_private" {
  type        = string
  default     = "private"
  description = "VPC network&subnet name"
}
variable "public_key" {
  type    = string
  default = ""
}

variable "username" {
  type = string
}
variable "ssh_public_key" {
  type        = string
  description = "Location of SSH public key."
}

variable "packages" {
  type    = list(any)
  default = []
}

variable "vm_resources" {
  type = map(any)
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
}