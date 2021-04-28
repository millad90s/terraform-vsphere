
# Basic configuration without variables

# Define authentification configuration
provider "vsphere" {
  # If you use a domain set your login like this "MyDomain\\MyUser"
  user           = "administrator@vsphere.local"
  password       = "mypassw0rd"
  vsphere_server = "10.10.10.10" # Enter vsphere IP address
  # version = "1.15.0"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}
terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 1.24.3"
    }
  }
}
