#######################################
# jenkins-install.sh
#Grant MacKenzie <grantmacken@gmail.com>
#v0.1, April 2013
#
# Installing jenkins
# cd
# chmod +x jenkins-install.sh
# sudo ./jenkins-install.sh
###########################################


if [ ! -d /usr/local/jenkins ]; then
    mkdir /usr/local/jenkins
fi

cd /usr/local/jenkins
if [ ! -e jenkins.war ]; then
   wget --verbose  http://mirrors.jenkins-ci.org/war/latest/jenkins.war
fi




