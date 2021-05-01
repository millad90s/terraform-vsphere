# Basic configuration withour variables

# Define authentification configuration
provider "vsphere" {
  # If you use a domain set your login like this "MyDomain\\MyUser"
  user           = "administrator@vsphere.local"
  password       = "Admin@123"
  vsphere_server = "10.100.200.91"
  version = "1.15.0"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}
