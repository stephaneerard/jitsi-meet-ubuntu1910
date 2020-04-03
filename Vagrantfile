# -*- mode: ruby -*-
# # vi: set ft=ruby :
 
# Specify minimum Vagrant version and Vagrant API version
Vagrant.require_version '>= 1.6.0'
VAGRANTFILE_API_VERSION = '2'
 
# Require JSON module
require 'json'
 
# Read YAML file with box details
servers = JSON.parse(File.read(File.join(File.dirname(__FILE__), 'servers.json')))
# Create boxes
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  # Iterate through entries in JSON file
  servers.each do |server|
    config.vm.define server['name'] do |srv|
      srv.vm.box = server['box']
      srv.vm.network 'private_network', ip: server['ip_addr']
      srv.vm.provider :virtualbox do |vmw|
        vmw.memory = server['ram']
        vmw.cpus = server['vcpu']
        optimize_vm(vmw, 100, server['group'])
      end # srv.vm.provider
      server['scripts'].each do |_script|
        srv.vm.provision "shell", name: "setup", path: _script['path']
      end
      if (Vagrant.has_plugin?("vagrant-vbguest")) 
        srv.vbguest.auto_update = false
      end
    end # config.vm.define
  end # servers.each
end # Vagrant.configure

def optimize_vm(vmw, cpu_cap, group)
  vmw.customize ["modifyvm", :id, "--cpuexecutioncap", cpu_cap]
  vmw.customize ["modifyvm", :id, "--nicpromisc1", "allow-all"]
  vmw.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
  vmw.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
  vmw.customize ["modifyvm", :id, "--nictype1", "virtio" ]
  vmw.customize ["modifyvm", :id, "--nictype2", "virtio" ]
  vmw.customize ["modifyvm", :id, "--nictype3", "virtio" ]
  vmw.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  vmw.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  vmw.customize ["modifyvm", :id, "--ioapic", "on"]
  vmw.customize ["modifyvm", :id, "--hwvirtex", "on"]
  vmw.customize ["modifyvm", :id, "--hpet", "on"]
  vmw.customize ["modifyvm", :id, "--nestedpaging", "on"]
  vmw.customize ["modifyvm", :id, "--largepages", "on"]
  vmw.customize ["modifyvm", :id, "--vtxvpid", "on"]
  vmw.customize ["modifyvm", :id, "--vtxux", "on"]
  vmw.customize ["modifyvm", :id, "--pae", "on"]
  vmw.customize ["modifyvm", :id, "--chipset", "ich9"]
  vmw.customize ["modifyvm", :id, "--biosapic", "x2apic"]
  vmw.customize ["modifyvm", :id, "--vrde", "off"]
  vmw.customize ["modifyvm", :id, "--usb", "off"]
  vmw.customize ["modifyvm", :id, "--ostype", "Debian_64"]
  vmw.customize ["modifyvm", :id, "--groups", "/" + group.gsub("\n",'').to_s]
  vmw.customize ["modifyvm", :id, "--vram", 96]
end