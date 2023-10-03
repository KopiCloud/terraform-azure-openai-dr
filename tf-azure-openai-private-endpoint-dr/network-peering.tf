locals {
   main_region = "we"
   dr_region = "eus"
}

// Reference to Main VNET
data "azurerm_virtual_network" "main" {
  name                = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${local.main_region}-vnet"
  resource_group_name = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${local.main_region}-rg"
}

// Reference to DR VNET
data "azurerm_virtual_network" "dr" {
  name                = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${local.dr_region}-vnet"
  resource_group_name = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${local.dr_region}-rg"

  depends_on = [ azurerm_virtual_network.this, azurerm_resource_group.this ]
}

// Create Peering Main to DR
resource "azurerm_virtual_network_peering" "main-to-dr" {
  name                      = "Main-to-DR"
  resource_group_name       = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${local.main_region}-rg"
  virtual_network_name      = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${local.main_region}-vnet"
  remote_virtual_network_id = data.azurerm_virtual_network.dr.id

  depends_on = [ azurerm_virtual_network.this, azurerm_resource_group.this ]
}

// Create Peering DR to Main
resource "azurerm_virtual_network_peering" "dr-to-main" {
  name                      = "DR-to-Main"
  resource_group_name       = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${local.dr_region}-rg"
  virtual_network_name      = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${local.dr_region}-vnet"
  remote_virtual_network_id = data.azurerm_virtual_network.main.id

  depends_on = [ azurerm_virtual_network.this, azurerm_resource_group.this ]
}
