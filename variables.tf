
variable "name" {
  description = "name of collection"
  type        = string
}

variable "database_id" {
  type        = string
  description = "cosmos mongo db id"
}

variable "scaling_type" {
  description = "manual/autoscale"
  type        = string
  default     = "autoscale"
}

variable "throughput" {
  description = "value of maxthrouput in case of autoscale or value of throuput in case of manual mode"
  type        = number
  default     = 1000
}

variable "shard_key" {
  description = "shard key"
  type        = string
  default     = ""
}

variable "indexes" {
  description = "indexes which needs to be added over collection"
  type        = list(object({ keys : list(string), ttl : optional(number), is_unique : optional(bool) }))
  default     = []
}
