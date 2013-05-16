#!/bin/sh
#########################################
#Grant MacKenzie <grantmacken@gmail.com>
#v0.1, May 2013
###########################################
if [ ! -d /usr/local/nginx/cache ] ; then
    mkdir /usr/local/nginx/cache
fi
if [ ! -d /usr/local/nginx/proxy ] ; then
    mkdir /usr/local/nginx/proxy
fi
#
cp dev/nginx-dev.conf /usr/local/nginx/conf/nginx.conf
cp dev/server-dev-locations.conf /usr/local/nginx/conf/server-dev-locations.conf
#
cp common/gzip.conf /usr/local/nginx/conf/gzip.conf
cp common/server-common.conf /usr/local/nginx/conf/server-common.conf
cp common/proxy-common.conf /usr/local/nginx/conf/proxy-common.conf

cd /usr/local/nginx/cache
rm -rf *
nginx -V
nginx -t
nginx -s reload
