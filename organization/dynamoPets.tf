module "dynamodb_table_pet" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name      = "pets"
  hash_key  = "ong_id"
  range_key = "id"

  table_class = "STANDARD"


  attributes = [
    {
      name = "ong_id"
      type = "S"
    },
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
    , {
      name = "situation"
      type = "N"
    }
  ]

  global_secondary_indexes = [{
    name            = "TypeIndex"
    hash_key        = "type"
    write_capacity  = 5
    read_capacity   = 5
    projection_type = "ALL"
    },
    {
      name            = "AgeIndex"
      hash_key        = "age"
      write_capacity  = 5
      read_capacity   = 5
      projection_type = "ALL"
    },
    {
      name            = "GenderIndex"
      hash_key        = "gender"
      write_capacity  = 5
      read_capacity   = 5
      projection_type = "ALL"
    },
    {
      name            = "SituationIndex"
      hash_key        = "situation"
      write_capacity  = 5
      read_capacity   = 5
      projection_type = "ALL"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}