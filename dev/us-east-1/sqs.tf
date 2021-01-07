
resource "aws_sqs_queue" "checkin_queue" {
  name                      = "checkin_queue"
  max_message_size          = 2048
  message_retention_seconds = 86400
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.checkin_deadletter_queue.arn
    maxReceiveCount     = 3
  })
}

resource "aws_lambda_event_source_mapping" "checkin_enqueue_trigger" {
    event_source_arn = aws_sqs_queue.checkin_queue.arn
    function_name =  module.expiry_trigger.function_name
}

resource "aws_sqs_queue" "checkin_deadletter_queue" {
  name                      = "checkin_queue"
  max_message_size          = 2048
  message_retention_seconds = 86400
}
