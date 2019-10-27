# kube-dev-bootstrap
vagrant configuration to deploy local kubernetes cluster

## prerequisites
1. install qemu/kvm https://help.ubuntu.com/community/KVM/Installation
2. install virt-manager https://help.ubuntu.com/community/KVM/VirtManager
3. install libvirt https://help.ubuntu.com/lts/serverguide/libvirt.html
4. enable `libvirtd` daemon with `sudo systemctl libvirtd`
5. create a storage pool with the name `vagrant` in virt-manager https://docs.fedoraproject.org/en-US/Fedora/18/html/Virtualization_Administration_Guide/sect-partbased-storage-pool.html
6. install vagrant https://www.vagrantup.com/downloads.html


## usage
1. `cd $YOUR_PROJECT_DIR`
2. `git clone https://github.com/aakashRajur/kube-dev-bootstrap.git vagrant`
3. `cd vagrant`
4. `vagrant plugin install vagrant-env`
5. create an `.env` with allowed configs below
6. `vagrant up` to start the VMs
7. get kmaster's ip address with `vagrant ssh-config`
8. `scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $KMASTER_IP_ADDRESS:/home/vagrant/.kube/config ~/.kube/config`
9. `kubectl` should be configured with the deployed cluster

## environment variable
```.env
# allocated CPUs, should be less than 
# no of cores on your machines
KMASTER_CPUS=2
# memory in MBs
KMASTER_MEMORY=2048
# specify list bash files at project root
# comma separated, will be run in order of
# declaration
KMASTER_SCRIPTS=kmaster.sh

KWORKER_CPUS=1
# memory in MBs
KWORKER_MEMORY=1024
KWORKER_COUNT=2
KWORKER_SCRIPTS=kworker.sh

# specify list of comma separated  folders 
# in the format $HOST_LOCATION:$GUEST_LOCATION
SHARED_FOLDERS=../:/app
```

