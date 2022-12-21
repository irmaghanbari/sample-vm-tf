resource "azurerm_public_ip" "bastion_ip" {
  name                = "bastion-PIP"
  location            = azurerm_resource_group.app_grp.location
  resource_group_name = azurerm_resource_group.app_grp.name
  allocation_method   = "Static"
  sku                 = "Standard"

}

resource "azurerm_bastion_host" "app_bastion" {
  name                = "app-bastion"
  location            = azurerm_resource_group.app_grp.location
  resource_group_name = azurerm_resource_group.app_grp.name
  sku                 = "Standard"
  scale_units            = 2
  shareable_link_enabled  = true
  file_copy_enabled       = true
  ip_connect_enabled      = true
  tunneling_enabled       = true

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.Azure_Bastion_Subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }
  depends_on=[
    azurerm_subnet.Azure_Bastion_Subnet,
    azurerm_public_ip.bastion_ip
  ]
}