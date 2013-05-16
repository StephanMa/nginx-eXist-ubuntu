#######################################
# nginx-install.sh
#Grant MacKenzie <grantmacken@gmail.com>
#v0.1, April 2013
#
#Installing nginx
#^^^^^^^^^^^^^^^^
#
#Nginx server: the latest stable version of
# http://wiki.nginx.org/Install
#
#The PCRE library:
# http://www.pcre.org/
#
#The zlib compression library:
#http://zlib.net
#
#OpenSSL Project Secure Sockets Layer library
# http://www.openssl.org/
#
# git clone https://gist.github.com/5381133.git
# cd 5381133
# chmod +x nginx-install.sh
# sudo ./nginx-install.sh
###########################################

if [ ! -d /usr/local/src ]; then
    mkdir /usr/local/src
fi

cd /usr/local/src

NGINX_VERSION='1.4.0'
PCRE_VERSION='8.32'
ZLIB_VERSION='1.2.7'
OPENSSL_VERSION='1.0.1e'

NGINX_gz="nginx-$NGINX_VERSION.tar.gz"
OPENSSL_gz="openssl-$OPENSSL_VERSION.tar.gz"
PCRE_gz="pcre-$PCRE_VERSION.tar.gz"
ZLIB_gz="zlib-$ZLIB_VERSION.tar.gz"

NGINX_CONF_DIR=/usr/local/nginx/conf

if [ ! -e $NGINX_gz ]; then
    wget --verbose  http://nginx.org/download/$NGINX_gz
fi

if [ ! -e $OPENSSL_gz ]; then
    wget --verbose  http://www.openssl.org/source/$OPENSSL_gz
fi

if [ ! -e $PCRE_gz ]; then
    wget --verbose  ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/$PCRE_gz
fi

if [ ! -e $ZLIB_gz ]; then
    wget --verbose http://zlib.net/$ZLIB_gz
fi

tar xfvz $NGINX_gz
tar xfvz $OPENSSL_gz
tar xfvz $PCRE_gz
tar xfvz $ZLIB_gz
cd nginx-$NGINX_VERSION
./configure \
--with-select_module  \
--with-http_gzip_static_module \
--with-pcre=/usr/local/src/pcre-$PCRE_VERSION \
--with-http_ssl_module \
--with-openssl=../openssl-$OPENSSL_VERSION \
--with-zlib=../zlib-$ZLIB_VERSION
make
make install


