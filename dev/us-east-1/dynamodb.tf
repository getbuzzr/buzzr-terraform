resource "aws_dynamodb_table" "live-checkin-table" {
  name           = "live_checkin"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "group_id"

  attribute {
    name = "group_id"
    type = "S"
  }
}