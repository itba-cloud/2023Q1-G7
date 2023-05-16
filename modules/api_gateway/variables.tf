variable "aws_region_name" {
  type = string
  description = "AWS Region Name"
}

variable "account_id" {
    type = string
    description = "AWS Account ID"
}

variable "template_file" {
    type = string
    description = "API template File"
}

variable "template_file_vars" {
    type = map(string)
    description = "OpenAPI file vars"
}

variable "name" {
    type = string
    description = "Name of the API"
}

variable "description" {
    type = string
    description = "Description of the API"
}