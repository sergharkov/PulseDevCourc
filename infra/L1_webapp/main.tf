terraform {

#   required_version = ">= 2.x"

   required_providers {
     azurerm = {
       source = "hashicorp/azurerm"
       version = "~>3.20"
     }
   }
 }

 provider "azurerm" {
   features {}
 }

 resource "azurerm_resource_group" "webapp" {
   name     = "webapp-rg"
   location = "West Europe"
 }


resource "azurerm_storage_account" "webapp" {
  name                     = "storageaccountnameksi"
  resource_group_name      = azurerm_resource_group.webapp.name
  location                 = azurerm_resource_group.webapp.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = true
#  allow_blob_public_access = true

  tags = {
    environment = "webapp"
  }
}

resource "azurerm_storage_container" "webapp" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.webapp.name
#  resource_group_name   = azurerm_resource_group.webapp.name
#  container_access_type = "private"
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "webapp" {
  depends_on             = ["azurerm_storage_account.webapp"]
  name                   = "grilledcheese.jpg"
  storage_account_name  = azurerm_storage_account.webapp.name
  storage_container_name = azurerm_storage_container.webapp.name
  type                   = "Block"
  source                 = "./grilledcheese.jpg"
#"https://github.com/sergharkov/PulseDevCourc/blob/master/app/AZ-204-DevelopingSolutionsforMicrosoftAzure-master/Allfiles/Labs/01/Starter/Images/grilledcheese.jpg"
}


output "azurerm_storage_blob_url" {
  value      = azurerm_storage_blob.webapp.url
}

output "primary_web_host" {
  value      = azurerm_storage_account.webapp.primary_web_host
}

output "primary_web_endpoint" {
  value      = azurerm_storage_account.webapp.primary_web_endpoint
}

output "primary_connection_string" {
  value      = nonsensitive(azurerm_storage_account.webapp.primary_connection_string)
}

output "prpimary_access_key" {
  value      = nonsensitive(azurerm_storage_account.webapp.primary_access_key)
#  sensitive = true

 depends_on = [
    azurerm_storage_account.webapp
  ]

}



output "RG-name" {
  value      = azurerm_resource_group.webapp.name
}

output "RG-ID" {
  value      = azurerm_resource_group.webapp.id
}



#resource "azurerm_app_service_plan" "webapp" {
#  depends_on          = ["azurerm_resource_group.webapp"]
#  name                = "webappksi"
#  resource_group_name = azurerm_resource_group.webapp.name
#  location            = azurerm_resource_group.webapp.location
#  sku {
#    tier = "Standard"
#    size = "S1"
#  }
#  kind             = "Windows"
#}

#resource "azurerm_app_service" "webapp" {
#  name                = "example-app-service"
#  location            = azurerm_resource_group.webapp.location
#  resource_group_name = azurerm_resource_group.webapp.name
#  app_service_plan_id = azurerm_app_service_plan.webapp.id
#
#  site_config {
#    dotnet_framework_version = "v6.0"
#    scm_type                 = "LocalGit"
#  }
#}




