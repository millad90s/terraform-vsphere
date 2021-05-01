output "template_id" {
    value = "${data.vsphere_virtual_machine.template.id}"
}
output "guest_id" {
    value = "${data.vsphere_virtual_machine.template.guest_id}"
}

output "scsi_type" {
    value = "${data.vsphere_virtual_machine.template.scsi_type}"
}

output "network_interface_types" {
    value = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
}

output "disk_size" {
    value = "${data.vsphere_virtual_machine.template.disks.0.size}}"
}
output "eagerly_scrub" {
    value = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
}
output "thin_provisioned" {
    value = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
}