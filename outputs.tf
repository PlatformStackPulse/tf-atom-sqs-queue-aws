output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "arn" {
  description = "ARN of the SQS queue"
  value       = try(aws_sqs_queue.this[0].arn, null)
}

output "id" {
  description = "URL of the SQS queue"
  value       = try(aws_sqs_queue.this[0].id, null)
}

output "url" {
  description = "URL of the SQS queue"
  value       = try(aws_sqs_queue.this[0].url, null)
}

output "name" {
  description = "Name of the SQS queue"
  value       = try(aws_sqs_queue.this[0].name, null)
}
