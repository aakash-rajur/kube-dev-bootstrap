#!/bin/bash

echo "Disabling swap"
sed -i '/swap/d' /etc/fstab
swapoff -a
