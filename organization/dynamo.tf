module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name     = "pets"
  hash_key = "id"

  attributes = [
    {
      name = "id"
      type = "N"
    }
    , {
      name = "pet_type"
      type = "N"
    }
    , {
      name = "pet_name"
      type = "S"
    }
    , {
      name = "pet_gender"
      type = "N"
    }
  ]

  global_secondary_indexes = [{
    name               = "DescriptionIndex"
    hash_key           = "description"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["id"]
  }]

  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}