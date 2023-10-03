# Deploying Two Instances of Azure OpenAI ChatGPT with a Private Endpoint to Test Connectivity and DR using Terraform
[![Terraform](https://img.shields.io/badge/terraform-v1.5+-blue.svg)](https://www.terraform.io/downloads.html)

## Overview

We are deploying two Azure OpenAI services with ChatGPT with Private Endpoint in the MAIN and DR regions.

The code is designed to run each piece in the same or different Azure Subscriptions.

## Code creates:

- Private DNS in the Core Network
- Windows Test VM in the Core Network
- Resource Group for Network in both MAIN and DR
- VNET and Subnet for Private Endpoint in both MAIN and DR
- Azure OpenAI Instance in both MAIN and DR
- Azure OpenAI ChatGPT Deployment in both MAIN and DR
- VNET Peering between MAIN and DR VNETs

## How To deploy the code:

- Clone the repo
- Update variables to your environment inside each repo
- Execute "terraform init" in the order list below
- Execute "terraform apply" in the order list below

## Order

1. tf-azure-core
2. tf-azure-openai-private-endpoint-main
3. tf-azure-openai-private-endpoint-dr
