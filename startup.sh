#!/bin/bash

rc-update add libvirtd 
rc-update add libvirt-guests
mkdir /run/openrc 
touch /run/openrc/softlevel
openrc 
exec "$@"