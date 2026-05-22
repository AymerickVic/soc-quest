# ============================================================
# SENTINEL — SIEM Lab
# ============================================================

# --- Log Analytics Workspace ---
# C'est la "base de données" où Sentinel stocke tous les logs
resource "azurerm_log_analytics_workspace" "sentinel_lab" {
  name                = "sentinel-lab"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  sku                 = "PerGB2018"   # paiement à la quantité de données
  retention_in_days   = 30           # logs gardés 30 jours (gratuit jusqu'à 90 jours)

  tags = { Créé_par = "Terraform" }
}

# --- Activation de Sentinel sur le workspace ---
# "SecurityInsights" = le nom interne de Microsoft Sentinel
resource "azurerm_log_analytics_solution" "sentinel" {
  solution_name         = "SecurityInsights"
  location              = azurerm_resource_group.lab.location
  resource_group_name   = azurerm_resource_group.lab.name
  workspace_resource_id = azurerm_log_analytics_workspace.sentinel_lab.id
  workspace_name        = azurerm_log_analytics_workspace.sentinel_lab.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }

  tags = { Créé_par = "Terraform" }
}
