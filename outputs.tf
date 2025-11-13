output "hello_microservice_url" {
  description = "Public URL for the Hello Microservice"
  value       = azurerm_container_app.aca_01.ingress[0].fqdn
}