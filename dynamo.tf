resource "aws_dynamodb_table" "parsley" {
  name         = "parsley"
  hash_key     = "Parsley-1"
  range_key    = "Parsley-2"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "Parsley-1"
    type = "S"
  }

  attribute {
    name = "Parsley-2"
    type = "N"
  }
}
