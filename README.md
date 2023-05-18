# TP3 Cloud Computing - Grupo 7

## Descripción de los módulos utilizados

#### [Bucket S3](https://github.com/terraform-aws-modules/terraform-aws-s3-bucket)
#### [Cloudfront](https://github.com/terraform-aws-modules/terraform-aws-cloudfront)
#### [Dynamo](https://github.com/terraform-aws-modules/terraform-aws-dynamodb-table)

## Componentes a evaluar

1. Bucket S3
2. Cloudfront
3. Dynamo DB
4. VPC
5. API Gateway
6. Lambda

## Descripción y referencia de funciones y meta-argumentos utilizados

### Funciones

* [fileset](https://github.com/gbudoberra/2023Q1-G7/blob/main/organization/locals.tf)
* [filemd5](https://github.com/gbudoberra/2023Q1-G7/blob/main/organization/s3_bucket.tf)
* [flatten](https://github.com/gbudoberra/2023Q1-G7/blob/main/organization/locals.tf)
* [sha1](https://github.com/gbudoberra/2023Q1-G7/blob/main/modules/api_gateway/main.tf)
* [jsonencode](https://github.com/gbudoberra/2023Q1-G7/blob/main/modules/api_gateway/main.tf)
* [length](https://github.com/gbudoberra/2023Q1-G7/blob/main/modules/vpc/main.tf)
* [cidrsubnet](https://github.com/gbudoberra/2023Q1-G7/blob/main/modules/vpc/locals.tf)

### Meta-argumentos

* [foreach](https://github.com/gbudoberra/2023Q1-G7/blob/main/organization/s3_bucket.tf)
* [count](https://github.com/gbudoberra/2023Q1-G7/blob/main/modules/vpc/main.tf)

## Diagrama de arquitectura (solo piezas a evaluar)
