# terraform-examples
This project contains examples from projects I am working on in terraform inspired by personal and work projects. The directory structure is based on terraform_version/project. I have reformatted this project this way because I had to refactor the staticweb project due to Terraform versioning issues. I wanted to make this project more versatile to support multiple projects and versions of those projects.

## Before you go
DISCLAIMER: By the nature of these projects you are creating resources in the cloud. That means depending on your account status and what resources are created you may be charged. Be forewarned... I am not responsible if you do receive any charges for resources you create in any account using this project. With that in mind, please enjoy because I think cloud infrastructure is a democratization of computing that allows people of all financial positions to at least begin to create and host projects. There are a lot of free tier offerings that can help get you started.

## Quickstart
Based on the version of terraform you are using, go into the folder structure for your version and look at projects. I was able to quickly port the staticweb project pretty quickly from 0.11 to 0.12 but that may not be the case for others so feel free to port any project you like, but depending on the resources and syntax used, it may be more complicated than running `terraform 0.12upgrade`.

## Multiple versions of terraform
If you are like me and want to dabble with Terraform in multiple versions, it is actually very easy. Terraform's binaries are static so you can easily download any versions you like and put them in your path. For example, I have terraform 0.11 saved in my path as `terraform` and terraform 0.12 is in my path as `terraform12`. This makes it easy for me to test projects with different versions as long as I remember to use the appropriate binary for the appropriate projects.
