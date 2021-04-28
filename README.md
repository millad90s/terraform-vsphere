# terraform-vsphere
In this project I am developing terraform code to manage Vsphere. 

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
