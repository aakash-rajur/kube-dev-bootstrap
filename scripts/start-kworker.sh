#!/bin/bash

echo "Install sshpass"
yum install -q -y sshpass
sshpass -p "vagrant" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $KAPI_SERVER_ADDRESS:/joincluster.sh /joincluster.sh
bash /joincluster.sh
