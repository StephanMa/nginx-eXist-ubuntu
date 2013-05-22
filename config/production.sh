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
#common
cp -i -v common/* /usr/local/nginx/conf
#cp common/server-common.conf /usr/local/nginx/conf/server-common.conf
#cp common/proxy-common.conf /usr/local/nginx/conf/proxy-common.conf
#production
cp -i -v prod/* /usr/local/nginx/conf
mv -i -v /usr/local/nginx/conf/nginx-prod.conf /usr/local/nginx/conf/nginx.conf

#cp prod/nginx-prod.conf /usr/local/nginx/conf/nginx.conf
#cp prod/proxy-cache-prior.conf /usr/local/nginx/conf/proxy-cache-prior.conf
#cp prod/proxy-cache.conf /usr/local/nginx/conf/proxy-cache.conf
#cp prod/server-production-locations.conf /usr/local/nginx/conf/server-production-locations.conf

# remove proxy cache
cd /usr/local/nginx/cache
rm -rf *

stop nginx

nginx -V
nginx -t
#nginx -s reload

start nginx
