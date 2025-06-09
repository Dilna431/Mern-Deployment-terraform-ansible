# TravelMemory MERN Stack Deployment on AWS using Terraform and Ansible

## Overview

This repository contains all the necessary infrastructure as code (IaC) and configuration management scripts to deploy the **TravelMemory** MERN stack application on AWS. The deployment uses:

- **Terraform** for AWS infrastructure provisioning
- **Ansible** for server configuration and application deployment

The TravelMemory app is a MERN (MongoDB, Express.js, React.js, Node.js) based travel journal application sourced from [TravelMemory GitHub Repo](https://github.com/UnpredictablePrashant/TravelMemory).

---

## Table of Contents

- [Architecture](#architecture)  
- [Prerequisites](#prerequisites)  
- [Setup and Deployment](#setup-and-deployment)  
  - [Part 1: Infrastructure Setup with Terraform](#part-1-infrastructure-setup-with-terraform)  
  - [Part 2: Configuration and Deployment with Ansible](#part-2-configuration-and-deployment-with-ansible)  
- [Project Structure](#project-structure)  
- [How It Works](#how-it-works)  


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

## Setup and Deployment

### Part 1: Infrastructure Setup with Terraform

1. **Configure AWS CLI** with your credentials.

2. **Initialize Terraform**:

   ```bash
   terraform init 
   terraform plan 
   terraform apply  

This will provision:  
VPC with public and private subnets   
Internet Gateway and NAT Gateway   
Route tables   
EC2 instances for web and database servers   
Security groups and IAM roles  

3. **Note the output:**
   The public IP of the web server EC2 instance is displayed after deployment.   

### Part 2: Configuration and Deployment with Ansible   

1.Configure your Ansible inventory to include EC2 instance IPs.   
2. Run the Ansible playbooks to:  
Install Node.js, NPM on the web server 
Clone the TravelMemory repository 
Install dependencies and start the backend and frontend 
Install and configure MongoDB on the database server  
Secure MongoDB by creating users and enabling authentication  
Set environment variables for the app  
Harden security by configuring firewalls and disabling root SSH login  
3. Run the playbook  
ansible-playbook -i inventory.ini deploy.yml  

## Project Structure  
├── terraform/  
│   ├── main.tf  
│   ├── variables.tf  
│   ├── outputs.tf  
│   └── ...  
├── ansible/  
│   ├── inventory.ini  
│   ├── deploy.yml  
│   ├── roles/  
        ├── webserver/  
        └── dbserver/  

## How It Works  

Terraform provisions all AWS infrastructure, including networking, EC2 instances, security groups, and IAM roles.
The web server is exposed publicly to serve the React frontend and Node.js backend.
The database server is isolated in a private subnet and secured.
Ansible connects to the EC2 instances over SSH and automates:
Installation of required software
Application code deployment and startup
Database configuration and user management
Security hardening steps

The React frontend communicates with the Node.js Express backend, which interacts with the MongoDB database.
 




   
   

