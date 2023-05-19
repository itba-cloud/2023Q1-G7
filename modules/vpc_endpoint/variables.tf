variable "service_name" {
  type        = string
  description = "Service name"
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
}

variable "route_table_ids" {
  type        = list(string)
  description = "Route table ids"
}

variable "endpoint_owner" {
  type        = string
  description = "Endpoint owner"
}

variable "endpoint_type" {
  type        = string
  description = "Endpoint type"
}