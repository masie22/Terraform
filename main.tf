terraform {
  required_version = ">= 0.12.0"
}

resource "azurerm_resource_group" "resource_group" {
  name     = "testrg"
  location = "centralus"
}

module "application-vnet" {
  source              = "./modules/vnet"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  location            = "${var.location}"
  tags                = "${merge(var.default_tags, map("type", "network"))}"
  vnet_name           = "${azurerm_resource_group.resource_group.name}-vnet"
  address_space       = "${var.address_space}"
}