#!/bin/bash
sudo apt-get update -y &&
sudo apt-get install -y &&
DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt install -y tzdata \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common &&
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null &&
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null &&
sudo apt-get update &&
sudo apt install openjdk-11-jre -y &&
sudo apt install jenkins -y
sudo curl -fsSL http://0.0.0.0:8080/jnlpJars/jenkins-cli.jar --output /var/lib/jenkins/jenkins-cli.jar
sudo pass=`sudo cat /var/lib/jenkins/secrets/initialAdminPassword` && echo 'jenkins.model.Jenkins.instance.securityRealm.createAccount("user1", "password123")' | sudo java -jar /var/lib/jenkins/jenkins-cli.jar -auth admin:$pass -s http://localhost:8080/ groovy =
sudo service jenkins stop
sudo mkdir -p /var/lib/jenkins/plugins
sudo curl -fsSL https://updates.jenkins-ci.org/latest/configuration-as-code.hpi --output /var/lib/jenkins/plugins/configuration-as-code.hpi
sudo mv /var/lib/jenkins /home
sudo chown -R jenkins: /home/jenkins
sudo ln -s /home/jenkins /var/lib/jenkins
sudo service jenkins start
wget -nc https://dl-ssl.google.com/linux/linux_signing_key.pub
cat linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/linux_signing_key.gpg  >/dev/null
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/chrome.list'
sudo apt-get update
sudo apt install -y python3-venv google-chrome-stable  
sudo -- sh -c 'mkdir -p /opt/tests; chmod a+rwx /opt/tests/'
cd opt/tests/ 
python3 -m venv venv
source venv/bin/activate
pip install selenium webdriver-manager