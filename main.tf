resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  name     = random_pet.rg_name.id
  location = var.resource_group_location
  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "vn" {
  name                = "vn"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [ "10.123.0.0/16" ]
  tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet" "subnet" {
  name = "subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes = [ "10.123.1.0/24" ]
}