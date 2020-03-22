# static web
Here's a really quick and dirty example of spinning up a static website with a webserver or webservers behind a loadbalancer using Microsoft Azure.
This example sets up a quick website with the following resources:

* Resource Group
* Virtual network
* Subnet
* Security groups
* Network interfaces
* Public IP
* Load balancer and load balancer accessories
* DNS Zone and alias record because what's a site that doesn't have domain name resolution?!
  * Using DNS is optional and defaulted to false, your public ip address is set as an output for ease of use to find and use your IP if you don't want to use DNS. Using DNS also assumes that you have already bought a domain and you will still need to perform some additional manual steps to get domain name resolution. Please follow the [documentation here](https://docs.microsoft.com/en-us/azure/dns/dns-delegate-domain-azure-dns).
* Virtual Machines inside an Availability set

## Prerequisites
I have included a lot of instructions for getting the tools and all in place in the instructions below. The only other assumption is that you already have created a Microsoft Azure account and have at least done a little bit of reading and familiarizing with Azure.

## WARNING:
This is a work in progress. I am porting this project from the 0.11 version. It will not work in its current state.

## Instructions
1. Download and install Terraform
  * Use the latest 0.12 version from the [releases page](https://releases.hashicorp.com/terraform/)
  * If you want to use the same version I did (0.12.24) go [here](https://releases.hashicorp.com/terraform/0.12.24/)
  * Install instructions from the [downloads page](https://www.terraform.io/downloads.html) - "Terraform is distributed as a single binary. Install Terraform by unzipping it and moving it to a directory included in your system's [PATH](https://superuser.com/questions/284342/what-are-path-and-other-environment-variables-and-how-can-i-set-or-use-them)."
2. [Install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. [Sign in with the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli?view=azure-cli-latest)
4. Clone / download this project
  * For https:
    * `git clone https://github.com/pacman2194/terraform-examples.git`
  * For ssh:
    * `git clone git@github.com:pacman2194/terraform-examples.git`
  * For download, use whatever you like: wget, curl, your web browser
5. Change into the directory for this project.
6. `terraform init`
7. As I mentioned above I defaulted DNS usage to false. I have provided an additional variable file to override to use DNS. So pick which of the actions below based on your desire to use DNS. All other decisions you need to make will be performed interactively.
  * DNS disabled: `terraform plan -out plan`
  * DNS enabled:  `terraform plan -out plan -var-file="example.tfvars"`
8. Review the output
  * If all looks well then run `terraform apply "plan"`.
  * If you don't like the plan, make some adjustments to either your variable inputs or some of the code in the project.
9. When Terraform finishes running you will notice a couple of outputs: rg_location and public_ip. You can use the public_ip output to go to your new website assuming everything went fine. I noticed this can potentially be a little buggy for a minute or so but should be working almost immediately. If you have purchased a domain and really want to use it then please review the [documentation here](https://docs.microsoft.com/en-us/azure/dns/dns-delegate-domain-azure-dns).

## Done playing?
If you are done playing around and want to destroy the resources run `terraform destroy`. This will destroy the terraform managed resources in this directory.
