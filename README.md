# terraform-examples
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

## Before you go
DISCLAIMER: By the nature of this project you are creating resources in the cloud. That means depending on your account status and what resources are created you may be charged. I do not have a lot of money to throw at resources so these charges should be reasonably small at most and I haven't been charged a cent yet by Microsoft. Be forewarned... I am not responsible if you do receive any charges for resources you create in any account using this project. With that in mind, please enjoy because I think cloud infrastructure is a democratization of computing that allows people of all financial positions to at least begin to create and host projects. There are a lot of free tier offerings that can help get you started.

## Prerequisites
I have included a lot of instructions for getting the tools and all in place in the instructions below. The only other assumption is that you already have created a Microsoft Azure account and have at least done a little bit of reading and familiarizing with Azure. This is my first project with Azure. All my prior cloud experience is from AWS.

## Instructions
You made it this far and for that I thank you. No more long-winded speeches. Here you go:

1. Download and install Terraform
  * [Latest release](https://www.terraform.io/downloads.html)
  * If you want to use the same version I did go [here](https://releases.hashicorp.com/terraform/0.11.14/)
  * From the [downloads page](https://www.terraform.io/downloads.html) - "Terraform is distributed as a single binary. Install Terraform by unzipping it and moving it to a directory included in your system's [PATH](https://superuser.com/questions/284342/what-are-path-and-other-environment-variables-and-how-can-i-set-or-use-them)."
2. [Install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. [Sign in with the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli?view=azure-cli-latest)
4. Clone / download this project
  * For https:
    * `git clone https://github.com/pacman2194/terraform-examples.git`
  * For ssh:
    * `git clone git@github.com:pacman2194/terraform-examples.git`
  * For download, use whatever you like: wget, curl, your web browser (firefox) to download from the link below
    * https://github.com/pacman2194/terraform-examples/archive/master.zip
5. Change into the directory for this project.
  * Assuming you're using a shell and are in the parent directory of this project like you would be if you just used `git clone` and that your shell interprets `cd` to change the directory just run `cd terraform-examples`
6. `terraform init`
7. As I mentioned above I defaulted DNS usage to false. I have provided an additional variable file to override to use DNS. So pick which of the actions below based on your desire to use DNS. All other decisions you need to make will be performed interactively.
  * DNS disabled: `terraform plan -out plan`
  * DNS enabled:  `terraform plan -out plan -var-file="example.tfvars"`
8. Review the output
  * If all looks well then run `terraform apply "plan"`.
  * If you don't like the plan, make some adjustments to either your variable inputs or some of the code in the project.
9. When Terraform finishes running you will notice a couple of outputs: rg_location and public_ip. You can use the public_ip output to go to your new website assuming everything went fine. I noticed this can potentially be a little buggy for a minute or so but should be working almost immediately. If you have purchased a domain and really want to use it then please review the [documentation here](https://docs.microsoft.com/en-us/azure/dns/dns-delegate-domain-azure-dns).
