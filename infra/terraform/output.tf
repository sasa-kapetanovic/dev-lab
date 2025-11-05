output "public_ip_address" {
  description = "Public IP address of the created VM"
  value       = azurerm_public_ip.pip.ip_address
}