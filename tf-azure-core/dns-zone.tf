#############################
## Private DNS Zone - Main ##
#############################

# Create the Resource Group for DNS Zone
resource "azurerm_resource_group" "dns_zone" {
  name     = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-dns-rg"
  location = var.location

  tags = {
    application = "${var.app_name}-dns"
    environment = var.environment
  }
}

# Create Private DNS Zone for OpenAI
resource "azurerm_private_dns_zone" "openai" {
  name                = "privatelink.openai.azure.com"
  resource_group_name = azurerm_resource_group.dns_zone.name
}

