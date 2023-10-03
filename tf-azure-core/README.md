# Deploying Azure Core Network
[![Terraform](https://img.shields.io/badge/terraform-v1.5+-blue.svg)](https://www.terraform.io/downloads.html)

## Overview

Deploying Core Network with Private DNS and a Windows Test VM

## Code creates:

- Resource Group for DNS
- Private DNS Zone
- Resource Group for Network
- VNET and Subnet
- Windows VM

## How To deploy the code:

- Clone the repo
- Update variables to your environment
- Execute "terraform init"
- Execute "terraform apply"
