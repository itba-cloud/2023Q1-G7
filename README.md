# TP3 Cloud Computing - Grupo 7

## Descripción de los módulos utilizados

#### [Bucket S3](https://github.com/terraform-aws-modules/terraform-aws-s3-bucket)
#### [Cloudfront](https://github.com/terraform-aws-modules/terraform-aws-cloudfront)
#### [Dynamo](https://github.com/terraform-aws-modules/terraform-aws-dynamodb-table)

## Componentes a evaluar

1. Bucket S3
    
    - Se deployan 2 buckets. Uno para el frontend estatico y otro para guardar los logs del proyecto. El frontend posee un index.html con data mockeada.
2. Cloudfront

3. Dynamo DB

    - Tabla "ong". Partition Key: neighborhood para poder filtrar por barrios de forma eficiente. Sort key: id. Ademas se insertaran datos como Name, email y phone que no se ven registrados en el codigo de terraform
    - Tabla "pets" con la informacion requerida para crear una mascota. Partition Key: ong_id para filtrar de forma eficiente las mascotas pertenecientes a una ong. Range Key: id. GSIs: por Type, Age y Situation para optimizar los posibles filtros.
4. VPC

    - 
5. API Gateway

    - GET /pets para obtener toda la lista de mascotas. Inicialmente se encuentra sin valores porque la tabla esta vacia
    - POST /pets para crear una nueva mascota con los aprametros dentro del body de la request
6. Lambda

    - Implementacion de las funciones necesarias para los endpoints de la API. Realizadas en codigo python

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
