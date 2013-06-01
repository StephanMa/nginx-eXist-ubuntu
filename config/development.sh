#!/bin/sh
#########################################
#Grant MacKenzie <grantmacken@gmail.com>
#v0.1, May 2013
###########################################

nginxHome='/usr/local/nginx'

if [ ! -e /usr/local/bin/nginx ] ; then
    sudo ln -s $nginxHome/sbin/nginx /usr/local/bin/nginx
fi

if [ ! -d /var/log/nginx ] ; then
    mkdir /var/log/nginx
    if [ ! -e /var/log/nginx/file.log ] ; then
    touch /var/log/nginx/file.log
    fi 
fi

if [ ! -d $nginxHome/cache ] ; then
    mkdir $nginxHome/cache
fi
if [ ! -d $nginxHome/proxy ] ; then
    mkdir $nginxHome/proxy
fi
# common
cp -f -v common/* $nginxHome/conf
#
cp -f -v dev/* $nginxHome/conf
mv -f -v $nginxHome/conf/nginx-dev.conf $nginxHome/conf/nginx.conf
#
cd $nginxHome/cache
rm -rf *
stop nginx
nginx -V
nginx -t
start nginx