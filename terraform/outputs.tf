# ============================================================
# OUTPUTS — valeurs affichées après terraform apply
# ============================================================
# Terraform affiche ces infos à la fin du déploiement
# pour que tu saches comment te connecter à ton lab.

output "client01_public_ip" {
  description = "IP publique pour RDP sur CLIENT01"
  value       = azurerm_public_ip.client01_pip.ip_address
}

output "sentinel_workspace_id" {
  description = "ID du workspace Sentinel (utile pour connecter des data sources)"
  value       = azurerm_log_analytics_workspace.sentinel_lab.id
}

output "rdp_connection" {
  description = "Commande pour se connecter en RDP"
  value       = "mstsc /v:${azurerm_public_ip.client01_pip.ip_address}"
}
