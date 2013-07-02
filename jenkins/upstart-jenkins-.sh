#upstart-jenkins-.sh
#===========
#Grant MacKenzie <grantmacken@gmail.com>
#v0.1, Feb 2012
#
# As Sudo
#init-checkconf jenkins.conf
#rm /etc/init/eXist.conf

if [ ! -e /etc/init/jenkins.conf ]; then
   stop jenkins
fi

sleep 10
cp jenkins.conf /etc/init/jenkins.conf
sleep 10
initctl list | grep jenkins
#initctl show-config jenkins
sleep 10
start jenkins
