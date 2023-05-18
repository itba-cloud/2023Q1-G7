module "lambda" {
  for_each = local.lambdas
  source   = "../modules/lambda"

  providers = {
    aws = aws.aws
  }

  lambda_info = each.value
  account_id  = data.aws_caller_identity.current.account_id
  local_path  = local.path

  apigw_execution_arn = module.apigw.execution_arn
  subnet_ids          = module.vpc.subnet_ids
}