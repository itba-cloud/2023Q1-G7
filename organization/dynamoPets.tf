module "dynamodb_table_pet" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name      = "pets"
  hash_key  = "ong_id"
  range_key = "id"


  attributes = [
    {
      name = "ong_id"
      type = "N"
    },
    {
      name = "id"
      type = "N"
    }
    , {
      name = "type"
      type = "N"
    }
    # , {
    #   name = "name"  NO ES NECESARIO PORQUE NO VA A NINGUN INDEX
    #   type = "S"
    # }
    , {
      name = "age"
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
      name            = "SituationIndex"
      hash_key        = "situation"
      write_capacity  = 5
      read_capacity   = 5
      projection_type = "ALL"
    }
  ]

  server_side_encryption_enabled = true
  table_class                 = "STANDARD"

  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}