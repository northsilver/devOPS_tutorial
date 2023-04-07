variable "env_name" {
  type = string
}
/*
variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
}
*/

variable "zone" {
  type = string
}
variable "cidr" {
  type = string
}