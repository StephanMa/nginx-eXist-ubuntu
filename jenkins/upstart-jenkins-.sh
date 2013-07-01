#nginx-install
#===========
#Grant MacKenzie <grantmacken@gmail.com>
#v0.1, Feb 2012
#
# As Sudo
#init-checkconf jenkins.conf
#rm /etc/init/eXist.conf
stop jenkins
sleep 10
cp jenkins.conf /etc/init/jenkins.conf
sleep 10
initctl list | grep jenkins
#initctl show-config jenkins
sleep 10
start jenkins
