resource "azurerm_public_ip" "dmz_lb_pip" {
  name                = var.dmz_lb_public_ip
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "dmz_lb" {
  name                = var.dmz_lb
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "dmz-frontend-config"
    public_ip_address_id = azurerm_public_ip.dmz_lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "dmz_pool" {
  name            = "dmz-backendpool"
  loadbalancer_id = azurerm_lb.dmz_lb.id
}

resource "azurerm_lb_backend_address_pool_address" "dmz_pool_address" {
  name                    = "dmz-backendpool-address"
  backend_address_pool_id = azurerm_lb_backend_address_pool.dmz_pool.id
  virtual_network_id      = azurerm_virtual_network.vnet.id
  ip_address              = "10.0.1.4" # Must exist in the subnet CIDR
}

resource "azurerm_lb_probe" "dmz_probe" {
  name            = "dmz-probe"
  loadbalancer_id = azurerm_lb.dmz_lb.id
  protocol        = "Tcp"
  port            = 443
}

resource "azurerm_lb_rule" "dmz_lb_rule" {
  loadbalancer_id                = azurerm_lb.dmz_lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "dmz-frontend-config"
  probe_id                       = azurerm_lb_probe.dmz_probe.id
}

resource "azurerm_lb" "internal_lb" {
  name                = "internal-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "internal-frontend"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.web.id
  }
}

resource "azurerm_lb_backend_address_pool" "internal_pool" {
  name            = "internal-backendpool"
  loadbalancer_id = azurerm_lb.internal_lb.id
}

resource "azurerm_lb_backend_address_pool_address" "internal_pool_address" {
  name                    = "internal-backendpool-address"
  backend_address_pool_id = azurerm_lb_backend_address_pool.internal_pool.id
  virtual_network_id      = azurerm_virtual_network.vnet.id
  ip_address              = "10.0.2.4" # Must exist in the subnet CIDR
}

resource "azurerm_lb_probe" "internal_probe" {
  name            = "internal-probe"
  loadbalancer_id = azurerm_lb.internal_lb.id
  protocol        = "Tcp"
  port            = 80
}

resource "azurerm_lb_rule" "internal_web_rule" {
  name                           = "internal-web-rule"
  loadbalancer_id                = azurerm_lb.internal_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "internal-frontend"
  probe_id                       = azurerm_lb_probe.internal_probe.id
}
