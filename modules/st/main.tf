resource "random_id" "random" {
  byte_length = 4
}

resource "azurerm_storage_account" "st" {
  name                = "st${var.env}${var.code}${random_id.random.hex}"
  resource_group_name = var.rg_name
  location            = var.location
  account_tier        = "Standard"
  # 本番環境はゾーン冗長、開発環境はローカル冗長
  account_replication_type = var.env == "pro" ? "ZRS" : "LRS"
}

# Create Azure Storage Account Network Rules
resource "azurerm_storage_account_network_rules" "rules" {
  storage_account_id = azurerm_storage_account.st.id
  default_action     = "Deny"
  bypass             = ["Metrics", "Logging", "AzureServices"]
}
