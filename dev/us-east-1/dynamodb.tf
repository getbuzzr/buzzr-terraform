resource "aws_dynamodb_table" "checkin" {
  name           = "CheckInStatus"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "user_id"
  range_key      = "group_id"
  
  attribute {
    name = "group_id"
    type = "N"
  }

  attribute {
    name = "user_id"
    type = "N"
  }

  global_secondary_index {
    hash_key = "group_id"
    range_key = "user_id"
    name = "GroupIdIndex"
    projection_type = "ALL"
  }
  
}