################################
## Azure Provider - Variables ##
################################

# Azure authentication variables

variable "azure-subscription-id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "azure-client-id" {
  type        = string
  description = "Azure Client ID"
}

variable "azure-client-secret" {
  type        = string
  description = "Azure Client Secret"
}

variable "azure-tenant-id" {
  type        = string
  description = "Azure Tenant ID"
}

#############################
## Application - Variables ##
#############################

# Company name 
variable "company" {
  type        = string
  description = "This variable defines the company name used to build resources"
}

# Application name 
variable "app_name" {
  type        = string
  description = "This variable defines the application name used to build resources"
}

# Environment
variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
}

# Azure region
variable "location" {
  type        = string
  description = "Azure region where the resource group will be created"
  default     = "west europe"
}

# Azure short region
variable "shortlocation" {
  type        = string
  description = "Azure region where the resource group will be created"
  default     = "we"
}

#########################
## Network - Variables ##
#########################

variable "vnet_address_space" {
  type        = string
  description = "VNET for Core VNET"
}

variable "subnet_address_space" {
  type        = string
  description = "Subnet for Core Subnet"
}

