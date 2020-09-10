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

SRC='/usr/local/src'

if [ ! -d $SRC ]; then
    mkdir $SRC
fi

cd $SRC

NGINX_VERSION='1.16.0'
PCRE_VERSION='8.32'
ZLIB_VERSION='1.2.8'
OPENSSL_VERSION='1.1.1g'

NGINX_gz="nginx-$NGINX_VERSION.tar.gz"
OPENSSL_gz="openssl-$OPENSSL_VERSION.tar.gz"
PCRE_gz="pcre-$PCRE_VERSION.tar.gz"
ZLIB_gz="zlib-$ZLIB_VERSION.tar.gz"

NGINX_CONF_DIR=/usr/local/nginx/conf

wget_output=$(wget -q "$URL")

if [ ! -e $NGINX_gz ]; then
    wget --verbose  "http://nginx.org/download/$NGINX_gz"
fi

if [ ! -e $OPENSSL_gz ]; then
    wget --verbose  http://www.openssl.org/source/$OPENSSL_gz
fi


if [ ! -e $PCRE_gz ]; then
    wget --verbose  https://ftp.pcre.org/pub/pcre/$PCRE_gz
fi

if [ ! -e $ZLIB_gz ]; then
    wget --verbose http://zlib.net/fossils/$ZLIB_gz
fi

#TAR

if [ -e $NGINX_gz ]; then
    tar xfvz $NGINX_gz
else
    echo "EXIT no $NGINX_gz"
    exit
fi

if [ -e $PCRE_gz ]; then
    tar xfvz $PCRE_gz
else
    echo "EXIT no $PCRE_gz"
    exit
fi

if [ -e $OPENSSL_gz ]; then
    tar xfvz $OPENSSL_gz
else
    echo "EXIT no  $OPENSSL_gz"
    exit
fi

if [ -e $ZLIB_gz ]; then
    tar xfvz $ZLIB_gz
else
    echo "EXIT no $ZLIB_gz"
    exit
fi


cd nginx-$NGINX_VERSION
./configure \
--with-select_module  \
--with-pcre="$SRC/pcre-$PCRE_VERSION" \
--with-http_ssl_module \
--with-openssl="$SRC/openssl-$OPENSSL_VERSION" \
--with-zlib="$SRC/zlib-$ZLIB_VERSION" \
--with-http_gzip_static_module \
--with-cc-opt=-Wno-error
make
make install


