#!/bin/bash

echo "Stopping and disabling firewalld"
systemctl disable firewalld
systemctl stop firewalld
