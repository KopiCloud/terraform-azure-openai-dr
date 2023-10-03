# Create Network Security Group to Access the Windows VM from Internet
resource "azurerm_network_security_group" "windows-vm-nsg" {
  name                = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-vm-nsg"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  security_rule {
    name                       = "allow-rdp"
    description                = "allow-rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*" 
  }

  security_rule {
    name                       = "allow-http"
    description                = "allow-http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# Associate the NSG with the Subnet
resource "azurerm_subnet_network_security_group_association" "windows-vm-nsg-association" {
  depends_on=[azurerm_network_security_group.windows-vm-nsg]

  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.windows-vm-nsg.id
}

# Get a Static Public IP for the Windows VM
resource "azurerm_public_ip" "windows-vm-ip" {
  name                = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-vm-ip"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  
  tags = { 
    application = var.app_name
    environment = var.environment 
  }
}

# Create Network Card for the Windows VM
resource "azurerm_network_interface" "windows-vm-nic" {
  name                = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-vm-nic"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows-vm-ip.id
  }
}

# Create Windows Server
resource "azurerm_windows_virtual_machine" "windows-vm" {
  depends_on=[azurerm_network_interface.windows-vm-nic]

  name                = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-vm"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  
  size                  = "Standard_B2ms"
  network_interface_ids = [azurerm_network_interface.windows-vm-nic.id]
  
  computer_name  = "openailab-vm"
  admin_username = "openadm"
  admin_password = "Gr33nOp3nK3y"

  os_disk {
    name                = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-${var.shortlocation}-vm-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  enable_automatic_updates = true
  provision_vm_agent       = true

  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# OUTPUT Windows VM ID
output "windows_vm_id" {
  value = azurerm_windows_virtual_machine.windows-vm.id
}

# OUTPUT Windows VM Name
output "windows_vm_name" {
  value = azurerm_windows_virtual_machine.windows-vm.name
}

# OUTPUT Windows VM Private IP
output "windows_vm_private_ip" {
  value = azurerm_windows_virtual_machine.windows-vm.private_ip_address
}

# OUTPUT Windows VM Public IP
output "windows_vm_public_ip" {
  value = azurerm_windows_virtual_machine.windows-vm.public_ip_address
}
