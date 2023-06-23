# ------------------------------------------------------------------------
# Amazon Lambda variables
# ------------------------------------------------------------------------

variable "account_id" {
  type        = string
  description = "The current Accound ID"
}

variable "local_path" {
  type        = string
  description = "Local path"
}

variable "lambda_info" {
  type        = map(string)
  description = "Contains all necesary lambda info"
}

variable "apigw_execution_arn" {
  type        = string
  description = "API GW execution ARN"
}

variable "subnet_ids" {
  type        = list(any)
  description = "The list of subnets created"
}

variable "sg_ids" {
  type        = list(any)
  description = "Security groups ids"
}

variable "apigw_id" {
  type        = string
  description = "Api Gateway ID"
}

variable "apigw_resource_id" {
  type        = string
  description = "Api Gateway root resource ID"
}

variable "myregion" {
  type        = string
  description = "My region"
}

variable "accountId" {
  type        = string
  description = "Current Account Id"
}

