#!/bin/bash
/bin/bash /home/vagrant/scripts/disable-selinux.sh
/bin/bash /home/vagrant/scripts/disable-swap.sh
/bin/bash /homve/vagrant/scripts/disable-firewall.sh
/bin/bash /home/vagrant/scripts/config-ssh.sh
/bin/bash /home/vagrant/scripts/config-sysctl.sh
/bin/bash /home/vagrant/scripts/install-docker.sh
/bin/bash /home/vagrant/scripts/install-kubernetes.sh
/bin/bash /home/vagrant/scripts/start-kworker.sh
