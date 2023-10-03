# Create the Resource Group for Core
resource "azurerm_resource_group" "this" {
  name     = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-rg"
  location = var.location

  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# Create the VNET for Core
resource "azurerm_virtual_network" "this" {
  name                = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-vnet"
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# Create the Subnet for Core
resource "azurerm_subnet" "this" {
  name                 = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.subnet_address_space]
}

