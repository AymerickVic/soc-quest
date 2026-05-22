# ============================================================
# RÉSEAU — VNet, Subnet, NSG, IP publique, NIC
# ============================================================

# --- Virtual Network ---
resource "azurerm_virtual_network" "lab_vnet" {
  name                = "DC01-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  tags = { Créé_par = "Terraform" }
}

# --- Subnet ---
resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.lab_vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# --- NSG pour CLIENT01 ---
# Note : on supprime la règle TEST-SENTINEL-RULE (port 9999)
# C'était une règle de test — un lab géré par Terraform doit être propre.
resource "azurerm_network_security_group" "client01_nsg" {
  name                = "CLIENT01NSG"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  # RDP autorisé pour accéder à la VM de lab
  # En prod, on mettrait ton IP fixe en source — pas "Internet"
  security_rule {
    name                       = "rdp"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = { Créé_par = "Terraform" }
}

# Associer NSG au subnet
resource "azurerm_subnet_network_security_group_association" "client01" {
  subnet_id                 = azurerm_subnet.default.id
  network_security_group_id = azurerm_network_security_group.client01_nsg.id
}

# --- IP Publique statique pour CLIENT01 ---
resource "azurerm_public_ip" "client01_pip" {
  name                = "CLIENT01PublicIP"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = { Créé_par = "Terraform" }
}

# --- Carte réseau (NIC) de CLIENT01 ---
resource "azurerm_network_interface" "client01_nic" {
  name                = "CLIENT01VMNic"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.default.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.client01_pip.id
  }

  tags = { Créé_par = "Terraform" }
}
