
# get Datacenter ID
data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}

# Get Template name
data "vsphere_virtual_machine" "template" {
  name          = "my_template"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}