output "name" {
  description = "name of cosmos db collection created"
  value       = azapi_resource.mongoCosmosCollection.name
}