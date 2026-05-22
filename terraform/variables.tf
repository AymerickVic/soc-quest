# ============================================================
# VARIABLES — les paramètres de ton lab
# ============================================================
# Avantage : si tu veux changer la région ou la taille de la VM,
# tu changes une seule ligne ici — tout le reste s'adapte.

variable "subscription_id" {
  description = "ID de ton abonnement Azure"
  type        = string
  default     = "98d5925f-c177-4293-8d7a-480143dbb33e"
}

variable "location" {
  description = "Région Azure"
  type        = string
  default     = "canadacentral"
}

variable "resource_group_name" {
  description = "Nom du Resource Group"
  type        = string
  default     = "SOC-QUEST-LAB"
}

variable "admin_username" {
  description = "Utilisateur admin de la VM"
  type        = string
  default     = "azureadmin"
}

variable "admin_password" {
  description = "Mot de passe admin — ne jamais mettre en clair dans le code !"
  type        = string
  sensitive   = true # Terraform masque cette valeur dans les logs
  # On le passera via : terraform apply -var="admin_password=..."
}
