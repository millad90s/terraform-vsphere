

data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "cluster1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_resource_pool" "pool" {
  name          = "RPool-1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"

}
data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "my_template"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


resource "vsphere_virtual_machine" "vm" {
  name             = "${var.vm_name}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  
  num_cpus = 2
  memory   = 1024
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
     size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  provisioner "file" {
    source      = "${var.pub_key}"
    destination = "/tmp/id2.pub"
 
    connection {
      host     = self.default_ip_address
      type     = "ssh"
      user     = "root"
      password = "${var.os_password}"
    }
  }

  provisioner "remote-exec" {
        connection {
          host     = self.default_ip_address
          type     = "ssh"
          user     = "root"
          password = "${var.os_password}"
    }

    inline = [
      "systemd-machine-id-setup",
      "mkdir /root/.ssh",
      "touch /root/.ssh/authorized_keys",
      "cat /tmp/id2.pub >> /root/.ssh/authorized_keys",
      "rm /tmp/id2.pub",
      "chown root:root -R /root/.ssh",
      "chmod 700 /root/.ssh",
      "chmod 600 /root/.ssh/authorized_keys",
      "cat /root/.ssh/authorized_keys"
    ]
  }

    provisioner "local-exec" {
    ### inventory file content must be added manually 
    command = "${vsphere_virtual_machine.vm.default_ip_address} >> hosts.ini"
    # command = "ansible-playbook -i hosts.ini --private-key config/service_terraform -b  -u root mariadb.yml"
    on_failure = continue

  }
    provisioner "local-exec" {
    when    = destroy
    command = "sed -i '/${self.default_ip_address}/d' hosts.ini"
      
  }

connection {
    host     = "${self.default_ip_address}"
    type     = "ssh"
    user     = "root"
     private_key = "${file("/home/milad/terraform/vcenter/file/service_terraform")}"
  }



  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "${var.vm_name}"
        domain = "test.internal"
        time_zone = "Asia/Tehran"
      }

      network_interface {
        ipv4_address = "10.100.100.x"
        ipv4_netmask = 24
        

      }
      dns_server_list = ["8.8.8.8","4.2.2.4"]
      ipv4_gateway = "10.100.100.1"
    }
  }
}

