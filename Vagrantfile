# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV_KMASTER_CPUS = "KMASTER_CPUS"
ENV_KMASTER_MEMORY = "KMASTER_MEMORY"
ENV_KMASTER_SCRIPTS = "KMASTER_SCRIPTS"

ENV_KWORKER_CPUS = "KWORKER_CPUS"
ENV_KWORKER_MEMORY = "KWORKER_MEMORY"
ENV_KWORKER_COUNT = "KWORKER_COUNT"
ENV_KWORKER_SCRIPTS = "KWORKER_SCRIPTS"

ENV_SHARED_FOLDERS = "SHARED_FOLDERS"

IP_ADDRESS_SUFFIX = 100

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure("2") do |config|

  # define required plugins
  config.vagrant.plugins = [
    "vagrant-libvirt",
    "vagrant-mutate",
    "vagrant-env",
  ]
  config.env.enable
  
  # parse shared folders from .env
  SHARED_FOLDERS = (ENV[ENV_SHARED_FOLDERS] || "").split(",")

  # read kmaster config from .env
  KMASTER_CPUS = ENV[ENV_KMASTER_CPUS]
  KMASTER_MEMORY = ENV[ENV_KMASTER_MEMORY]
  KMASTER_IP_ADD = "172.42.42.#{IP_ADDRESS_SUFFIX}"
  
  # kubernetes master
  config.vm.define "kmaster", primary: true do|kmaster|
    
    # set kmaster vm config
    config.vm.provider :libvirt do |libvirt|
      libvirt.storage_pool_name = "vagrant"
      libvirt.driver = "kvm"
      libvirt.uri = "qemu:///system"
      libvirt.cpus = KMASTER_CPUS
      libvirt.memory = KMASTER_MEMORY
    end
    kmaster.vm.box = "centos/7"
    kmaster.vm.hostname = "kmaster.dev.com"
    kmaster.vm.network :private_network, ip: KMASTER_IP_ADD
    
    # copy scripts to guest
    kmaster.vm.provision "file", source: "./scripts", destination: "$HOME/scripts"
    
    # mount shared folders
    SHARED_FOLDERS.each do |shared_folder|
      host_location, guest_location = shared_folder.split(":")
      kmaster.vm.synced_folder host_location, guest_location, 
        create: true,
        type: "nfs", nfs_version: 4, nfs_udp: false
    end
    
    # run kmaster setup scripts
    KMASTER_SCRIPTS = ENV[ENV_KMASTER_SCRIPTS].split(",")
    KMASTER_SCRIPTS.each do |script|
      kmaster.vm.provision "shell", path: script, keep_color: true, env: {"KAPI_SERVER_ADDRESS" => KMASTER_IP_ADD}
     
    end
    
  end
  
  # kubernetes workers
  
  # read kworker config from .env
  KWORKER_CPUS = ENV[ENV_KWORKER_CPUS]
  KWORKER_MEMORY = ENV[ENV_KWORKER_MEMORY]
  KWORKER_COUNT = ENV[ENV_KWORKER_COUNT].to_i
  KWORKER_SCRIPTS = ENV[ENV_KWORKER_SCRIPTS].split(",")
  
  (1..KWORKER_COUNT).each do |worker_index|
    
    # define kworker #worker_index
    config.vm.define "kworker#{worker_index}" do |kworker|

      kworker_ip_add="172.42.42.#{IP_ADDRESS_SUFFIX + worker_index}"
      
      # define kworker vm config
      kworker.vm.provider :libvirt do |libvirt|
        libvirt.storage_pool_name = "vagrant"
        libvirt.driver = "kvm"
        libvirt.uri = "qemu:///system"
        libvirt.cpus = KWORKER_CPUS
        libvirt.memory = KWORKER_MEMORY
      end
      kworker.vm.box = "centos/7"
      kworker.vm.hostname = "kworker#{worker_index}.dev.com"
      kworker.vm.network :private_network, ip: kworker_ip_add
      
      # copy scripts to guest
      kworker.vm.provision "file", source: "./scripts", destination: "$HOME/scripts"
      
      # mount shared folders
      SHARED_FOLDERS.each do |shared_folder|
        host_location, guest_location = shared_folder.split(":")
        kworker.vm.synced_folder host_location, guest_location, 
          create: true,
          type: "nfs", nfs_version: 4, nfs_udp: false
      end
      
      # run kworker setup scripts
      KWORKER_SCRIPTS.each do |script|
        kworker.vm.provision "shell", path: script, keep_color: true, env: {"KAPI_SERVER_ADDRESS" => KMASTER_IP_ADD}
      end
      
    end
   
  end
  
end

