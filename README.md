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
- [Security Considerations](#security-considerations)  
- [Troubleshooting](#troubleshooting)  
- [Contributing](#contributing)  
- [License](#license)

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
