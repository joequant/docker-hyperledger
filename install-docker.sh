#!/bin/bash
echo "Please remember to unblock port 4243 from local firewall"
cp docker-network.sysconfig /etc/sysconfig/docker-network
systemctl restart docker
