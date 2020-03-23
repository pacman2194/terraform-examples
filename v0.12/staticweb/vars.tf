variable "resource_group" {
  description = "name for your resource group to be created for this"
}

# checkout https://azure.microsoft.com/en-us/global-infrastructure/regions/
variable "location" {
  description = "azure location / region"
}

variable "prefix" {
  description = "a variable to give some uniqueness to names"
}

variable "webserver_count" {
  description = "number of webservers to spin up"
}

variable "webserver_user" {
  description = "name for the user on your webservers"
}

# this is a standard location for Unix based systems
# if you're using Windows, stop please for your own good
variable "ssh_key_path" {
  default = "~/.ssh/id_rsa.pub"
  description = "default location for your public ssh key"
}

variable "use_dns" {
  default = false
  description = "boolean flag to control whether to use DNS resources or not"
}

variable "dns_zone_name" {
  description = "zone name for DNS"
}
