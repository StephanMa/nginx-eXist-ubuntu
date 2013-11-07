#!/bin/sh +x

############################################################
#  Program: exist pre-install
#  Author : Grant MacKenzie
#  markup.co.nz
#  grantmacken@gmail.com
#
#  http://exist-db.org/exist/apps/doc/advanced-installation.xml#linux
#  run as sudo
#  installs exist-db as $SUDO_USER not as root#
#  makes backup first
# 1. Creates the dir ```/usr/local/eXist```, changes ownership to user
# 2. Downloads the latest eXist jar file
# 3. As user starts the installation the headless way```java -jar eXist.jar -console```
# 4. User **must** select target path ```/usr/local/eXist```
############################################################

EXIST_DIR='/usr/local/eXist'
SOURCE_DIR='/usr/local/src'
BACKUP_DIR="${SOURCE_DIR}/exist-bu"
DOWNLOAD='http://sourceforge.net/projects/exist/files/latest/download'
EXIST_VERSION='eXist-db-setup-2.1-rev18721.jar'

echo ${EXIST_DIR}

if [ ! -d  $SOURCE_DIR ]; then
   mkdir $SOURCE_DIR
fi

if [ -d  $EXIST_DIR ]; then
    rsync -av $EXIST_DIR $BACKUP_DIR
   rm -R -f $EXIST_DIR
fi
#
if [ ! -d  $EXIST_DIR ]; then
   mkdir $EXIST_DIR
   chown $SUDO_USER:$SUDO_USER $EXIST_DIR
   ls -al /usr/local
fi


#
cd $SOURCE_DIR

if [ ! -e  $EXIST_VERSION ]; then
  wget -O $EXIST_VERSION --trust-server-name $DOWNLOAD
fi

cp $EXIST_VERSION $EXIST_DIR/$EXIST_VERSION
cd $EXIST_DIR
chown $SUDO_USER:$SUDO_USER $EXIST_VERSION
cmd="java -jar $EXIST_VERSION -console"
su -c "$cmd" -s /bin/sh $SUDO_USER
rm $EXIST_VERSION
