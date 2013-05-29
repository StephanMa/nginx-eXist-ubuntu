#!/bin/sh

############################################################
#  Program: exist upstart
#  Author : Grant MacKenzie
#  markup.co.nz
#  grantmacken@gmail.com
#  run as sudo
############################################################

if [ -e  /etc/init/exist.conf ]; then
   stop exist
   rm /etc/init/exist.conf
fi
cp exist.conf /etc/init/exist.conf
initctl list | grep exist
echo '******************************************************'
initctl show-config exist
echo '******************************************************'
start exist
