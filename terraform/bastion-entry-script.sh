#!/usr/bin/env bash

# sudo echo "Port 22" >> /etc/ssh/sshd_config
sudo echo "Port 12000" >> /etc/ssh/sshd_config
sudo systemctl restart sshd

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg
sudo apt install -y binutils
sudo apt install -y net-tools
sudo apt install -y inetutils-traceroute 

sudo apt install -y unzip
sudo apt install -y mc
sudo apt install -y nmap

#install git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt install -y git

#install Docker
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
sudo apt update
#sudo apt-cache policy docker-ce
sudo apt install -y docker-ce

sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu


# install aws
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
sudo mv /usr/local/bin/aws /bin/aws
sudo ln -s /usr/local/aws-cli/v2/current/bin/aws_completer /bin/aws_completer
rm awscliv2.zip
rm -rf aws

# install aws efs utils
sudo git clone https://github.com/aws/efs-utils && cd efs-utils
./build-deb.sh
sudo apt update -y
sudo apt install ./build/amazon-efs-utils*deb -y
cd ..


#install eksctl
sudo curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz 
sudo mv eksctl /bin/eksctl

#install kubectl 1.21.2 from AWS
sudo curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv kubectl /bin/kubectl

#install ansible
sudo apt install -y ansible 

#install terraform and packer
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" -y
sudo apt update && sudo apt install -y terraform
sudo apt update && sudo apt install -y packer


#install java JDK 11
sudo add-apt-repository ppa:openjdk-r/ppa -y
sudo apt update
sudo apt install -y openjdk-11-jdk

#Rancher in Docker with Persistent Data 
sudo docker run --privileged -d --restart=unless-stopped -p 80:80 -p 443:443 -v /opt/rancher:/var/lib/rancher rancher/rancher:latest

#create example file with AWS keys

cat << EOF > /home/ubuntu/awskeys.sh
#!/bin/sh
export AWS_ACCESS_KEY_ID=xxxxx
export AWS_SECRET_ACCESS_KEY=xxxxx
export AWS_DEFAULT_REGION=eu-central-1
EOF