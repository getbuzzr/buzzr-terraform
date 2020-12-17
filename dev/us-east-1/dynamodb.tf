resource "aws_dynamodb_table" "checkin" {
  name           = "CheckInStatus"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "userId"
  range_key      = "groupId"
  
  attribute {
    name = "groupId"
    type = "N"
  }

  attribute {
    name = "userId"
    type = "N"
  }
  
}