#!/bin/sh

############################################################
#  Program: nginx upstart
#  Author : Grant MacKenzie
#  markup.co.nz
#  grantmacken@gmail.com
#  run as sudo
############################################################

if [ -e  /etc/init/nginx.conf ]; then
   stop nginx
   rm /etc/init/nginx.conf
fi
cp nginx.conf /etc/init/nginx.conf
initctl list | grep nginx
echo '******************************************************'
initctl show-config nginx
echo '******************************************************'
nginx -t
echo '******************************************************'
start nginx
