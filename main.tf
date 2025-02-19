#  resource "azapi_resource" "mongoCosmosColl" {
#   type      = "Microsoft.DocumentDB/databaseAccounts/mongodbDatabases/collections@2024-12-01-preview"
#   name      = "myColl"
#   parent_id = azapi_resource.mongodbDatabase.idz
#   location = azurerm_resource_group.example.location
#   tags = {
#     "createdBy" = "terraform"
#   }
#   body = {
#     properties = {
#       options = {
#         autoscaleSettings = {
#           maxThroughput = 1000
#         }
#       }
#       resource = {
#         createMode = "Default"
#         id         = "myColl"
#         shardKey = {
#           "_id" = "hashed"
#         }
#         indexes = [
#           {
#             key = {
#               keys = [
#                 "_id"
#               ]
#             }
#             options = {
#               unique = true
#             }
#           },
#           {
#             key = {
#               keys = [
#                 "_ts"
#               ]
#             }
#             options = {
#               unique             = false
#               expireAfterSeconds = 60
#             }
#           }
#         ]
#       }
#     }
# }
# }

data "jinja_template" "body" {
  context {
    type = "json"
    data = jsonencode(
      {
        scaling_type  = var.scaling_type
        name          = var.name
        throughput    = var.throughput
        shard_key     = var.shard_key
        indexes       = var.indexes
      }
    )
  }
  source {
    template  = file("${path.module}/template/body.json.j2")
    directory = "${path.module}/template"
  }
  strict_undefined  = false
  left_strip_blocks = false
  trim_blocks       = false
}

resource "azapi_resource" "mongoCosmosCollection" {
  type      = "Microsoft.DocumentDB/databaseAccounts/mongodbDatabases/collections@2024-12-01-preview"
  name      = var.name
  parent_id = var.database_id
  tags = {
    "createdBy" = "terraform"
  }
  body = data.jinja_template.body.result
}