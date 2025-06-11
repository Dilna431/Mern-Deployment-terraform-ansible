# TravelMemory MERN Stack Deployment on AWS using Terraform and Ansible  

## Overview  

This repository contains all the necessary infrastructure as code (IaC) and configuration management scripts to deploy the **TravelMemory** MERN stack application on AWS. The deployment uses:  

- **Terraform** for AWS infrastructure provisioning  
- **Ansible** for server configuration and application deployment  

The TravelMemory app is a MERN (MongoDB, Express.js, React.js, Node.js) based travel journal application sourced from [TravelMemory GitHub Repo](https://github.com/UnpredictablePrashant/TravelMemory).  

---
## Architecture

The deployment consists of:

- **AWS VPC** with:
  - Public subnet hosting the Web Server (Node.js + React app)
  - Private subnet hosting the Database Server (MongoDB)
- **Internet Gateway** for internet access from the public subnet
- **NAT Gateway** to allow outbound internet access from the private subnet
- **EC2 Instances**:
  - Web server in the public subnet with Node.js runtime
  - Database server in the private subnet with MongoDB
- **Security Groups** controlling inbound/outbound traffic
- **IAM Roles** assigned to EC2 instances for permissions
- **Ansible playbooks** automating package installations, app setup, and service startup

---

## Prerequisites

- An AWS account with necessary permissions
- AWS CLI configured locally (`aws configure`)
- Terraform installed (v1.0+ recommended)
- Ansible installed on your control machine
- SSH key pair for EC2 instance access
- Basic familiarity with AWS, Terraform, Ansible, and MERN stack

---

## Configuration Steps  

### 1. AWS Configuration  

#### Configure AWS CLI 
```bash  
aws configure

```
#### Import SSH Key Pair  

aws ec2 import-key-pair --key-name "your-key-pair-name" --public-key-material fileb://~/.ssh/id_rsa.pub  

### 2. Terraform Configuration  
Update dev.tfvars  
File: Terraform Deployment/modules/tfvar/dev.tfvars  

```bash
VPC Configuration 
vpc_cidr            = "10.0.0.0/16" 
public_subnet_cidr  = "10.0.1.0/24" 
private_subnet_cidr = "10.0.2.0/24" 
availability_zone   = "us-west-1a" 
environment         = "development" 

EC2 Configuration
ami_id   = "ami-0f8e81a3da6e2510a" # Ubuntu 20.04 LTS in us-west-1  
key_name = "your-key-pair-name"  
my_ip    = "YOUR_IP_ADDRESS"

```
**Initialize, Plan, and Apply**

```bash
cd "Terraform Deployment" 
terraform init 
terraform plan -var-file="modules/tfvar/dev.tfvars"  
terraform apply -var-file="modules/tfvar/dev.tfvars" 
```
### 3. Ansible Configuration  

Edit Inventory File  
File: ansible/inventory/aws_ec2.ini  

```ini
[web]
web_server ansible_host=<web_server_public_ip>

[db]
db_server ansible_host=<database_private_ip>

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/your-key-pair-name.pem

```

**Set MongoDB Password** 
```bash
export MONGODB_PASSWORD=your_secure_password
```
Update env.j2 Template  
File: ansible/templates/env.j2  

```env
PORT=3001
MONGO_URI=mongodb://mernuser:${MONGODB_PASSWORD}@localhost:27017/merndb

```

**Run Ansible Playbooks**  

```bash
cd ansible
ansible-playbook security.yml
ansible-playbook dbserver.yml
ansible-playbook webserver.yml
```


### 4. Application Configuration  

Frontend .env  

```env 
REACT_APP_BACKEND_URL=http://<web_server_public_ip>:3001
```

Backend .env 
```env 
PORT=3001  
MONGO_URI=mongodb://mernuser:<password>@<database_private_ip>:27017/merndb
```


### Deployment Verification   

Frontend: http://<web_server_public_ip>  

Backend API Test: http://<web_server_public_ip>:3001/api/hello  

### Security Considerations  

MongoDB is accessible only from the web server.  
SSH access is restricted to your IP address.  
Instances are secured via security.yml playbook.  
Web server in a public subnet; DB server in a private subnet.  
Security groups enforce least privilege.   

### Clean Up  

Destroy infrastructure using:  

```bash
cd "Terraform Deployment"
terraform destroy -var-file="modules/tfvar/dev.tfvars"
```

### Troubleshooting 

**SSH Access**  

```bash
ssh -i ~/.ssh/your-key-pair-name.pem ubuntu@<web_server_public_ip>
ssh -J ubuntu@<web_server_public_ip> ubuntu@<database_private_ip>
```

**MongoDB Access** 

```bash
mongo mongodb://mernuser:password@<database_private_ip>:27017/merndb
```

**Logs**   

PM2 Logs   
pm2 logs backend   

NGINX Logs   
sudo tail -f /var/log/nginx/error.log   













   
   

