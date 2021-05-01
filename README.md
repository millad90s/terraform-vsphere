# terraform-vsphere
In this project I am going to use all terraform features to manage virtual machines on vsphere:
* variable 
* output 
* modules 
* Interpolation syntax to call variables

# initate 
to initaite and download all required plugin run below command:
$ terraform init 

# make plan 
to create your plan run as follow: 
$ terraform plan 
or 
$ terraform plan -out=devplan  # you can save the plan output to a file, using -out 

# apply the plan 
to apply the plan on your infrastracture runn terraform as below: 
$ terraform apply devplan


# Todo 
* convert virtual_machine resource to a module 
* use a list of IPs dynamically and assign to VMs
