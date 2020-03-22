# your resource group name
variable "resource_group" { }

# azure location / region checkout https://azure.microsoft.com/en-us/global-infrastructure/regions/
variable "location" { }

# a variable to give some uniqueness to names
variable "prefix" { }

# number of webservers to spin up
variable "webserver_count" { }

# name for the user on your webservers
variable "webserver_user" { }

# password for the user on your webservers
variable "webserver_pass" { }

variable "ssh_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "use_dns" {
  default = false
}

# zone name for DNS
variable "dns_zone_name" { }
