#!/bin/bash
cp docker-network.sysconfig /etc/sysconfig/docker-network
systemctl restart docker
