# ============================================================
# PROVIDER — connexion à Azure
# ============================================================

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# ============================================================
# RESOURCE GROUP — le conteneur principal
# ============================================================

resource "azurerm_resource_group" "lab" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Projet        = "Security Quest"
    Créé_par      = "Terraform"
    Environnement = "Lab"
  }
}
