# Deploying Azure OpenAI ChatGPT with Private Endpoint using Terraform
[![Terraform](https://img.shields.io/badge/terraform-v1.5+-blue.svg)](https://www.terraform.io/downloads.html)

## Overview

Deploying an Azure OpenAI service with ChatGPT in the MAIN region with Private Endpoint

## Code creates:

- Resource Group for Network
- VNET and Subnet for Private Endpoint
- Azure OpenAI Instance
- Azure OpenAI ChatGPT Deployment

## Variables

List of variables used in this code:

Variable | Description | Type
--- | --- | ---
`region` | The region in which this module should be deployed | `string`
`cognitive_account_sku_name` | Specifies the SKU Name for this Cognitive Service Account - Default: S0 | `string`
`cognitive_deployment_name` | The name of the Cognitive Services Account Deployment model. Default: gpt-35-turbo | `string`
`cognitive_deployment_version` | The version of the Cognitive Services Account Deployment model. Default: 0301 | `string`
`cognitive_deployment_scale_type` | Deployment scale type. Default: Standard | `string`
`vnet_address_space` | CIDR of the VNET used for the Private Endpoint | `string`
`subnet_address_space` | CIDR of the Subnet used for the Private Endpoint | `string`

## How To deploy the code:

- Clone the repo
- Update variables to your environment
- Execute "terraform init"
- Execute "terraform apply"