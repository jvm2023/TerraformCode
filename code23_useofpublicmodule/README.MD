USAGE OF PUBLIC MODULE 


1:CREATE main.tf  CALL PUBLIC MODULE ,PUT PROVIDER BLOCK ALSO MENTION DETAILS OF APPLICATION OBJECT IN PROVIDER
2:CREATE script.sh WITH FOLLOWING CONTENT

#cloud-config
package_upgrade: true
runcmd:
  - sudo apt install openjdk-11-jre -y
  - curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
  -  echo 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/' | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
  - sudo apt-get update && sudo apt-get install jenkins -y
  - sudo service jenkins restart
  - sudo ufw allow 8080




