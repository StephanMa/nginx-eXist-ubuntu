#!/bin/sh

############################################################
#  Program: exist pre-install
#  Author : Grant MacKenzie
#  markup.co.nz
#  grantmacken@gmail.com
# 
#  http://exist-db.org/exist/apps/doc/advanced-installation.xml#linux
#  run as sudo 
#  installs exist-db as $SUDO_USER not as root
#  
############################################################


#if [ -d  /usr/local/eXist ]; then
#   rm -R -f /usr/local/eXist
#fi


EXIST_DIR='/usr/local/eXist'
SOURCE_DIR='/usr/local/src'
DOWNLOAD_DIR='http://sourceforge.net/projects/exist/files/Stable/2.0'
EXIST_VERSION='eXist-db-setup-2.0-rev18252.jar'

if [ -d  $SOURCE_DIR ]; then
   mkdir $SOURCE_DIR
fi

if [ ! -d  $EXIST_DIR ]; then
   mkdir $EXIST_DIR
   chown $SUDO_USER:$SUDO_USER $EXIST_DIR
   ls -al /usr/local
fi


cd $SOURCE_DIR
wget -O $EXIST_VERSION --trust-server-name $DOWNLOAD_DIR/$EXIST_VERSION
chown $SUDO_USER:$SUDO_USER $EXIST_VERSION
cmd="java -jar $EXIST_VERSION -console"
su -c "$cmd" -s /bin/sh $SUDO_USER

echo $USER
echo $SUDO_USER
echo $HOME

