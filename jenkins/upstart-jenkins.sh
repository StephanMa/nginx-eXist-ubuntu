#upstart-jenkins.sh
#===========
#Grant MacKenzie <grantmacken@gmail.com>
#v0.1, Feb 2012
#
# As Sudo
# cd jenkins
#init-checkconf jenkins.conf
#rm /etc/init/jenkins.conf
# chmod +x upstart-jenkins.sh
# ./upstart-jenkins.sh

#if [ jenkins -e /etc/init/jenkins.conf ]; then
#   stop jenkins
#fi



IP=$( nslookup 'markup.co.nz'  | tail -2 | awk -F ": " '{print $2}' )
cat jenkins.conf | head -n -1 > jenkins2.conf
echo --httpListenAddress=$IP >> jenkins2.conf
cp jenkins2.conf /etc/init/jenkins.conf
#sleep 10
#initctl list | grep jenkins
##initctl show-config jenkins
sleep 5
start jenkins
