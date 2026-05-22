# ============================================================
# VM CLIENT01 — Windows 11 Pro
# ============================================================

resource "azurerm_windows_virtual_machine" "client01" {
  name                = "CLIENT01"
  resource_group_name = azurerm_resource_group.lab.name
  location            = azurerm_resource_group.lab.location
  size                = "Standard_B2as_v2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password # variable sensible, jamais en clair

  # La NIC créée dans network.tf
  network_interface_ids = [azurerm_network_interface.client01_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  # Windows 11 Pro 25H2
  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-25h2-pro"
    version   = "latest"
  }

  # Nécessaire pour Entra ID Join
  identity {
    type = "SystemAssigned"
  }

  tags = { Créé_par = "Terraform" }
}

# --- Extension Entra ID Join (AADLoginForWindows) ---
# Permet de se connecter à la VM avec un compte Entra ID
# au lieu d'un compte local Windows
resource "azurerm_virtual_machine_extension" "entra_id_join" {
  name                 = "AADLoginForWindows"
  virtual_machine_id   = azurerm_windows_virtual_machine.client01.id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADLoginForWindows"
  type_handler_version = "2.0"

  tags = { Créé_par = "Terraform" }
}
