resource "aws_sqs_queue" "this" {
  count = module.this.enabled ? 1 : 0

  name                       = var.fifo_queue ? "${module.this.id}.fifo" : module.this.id
  fifo_queue                 = var.fifo_queue
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  sqs_managed_sse_enabled    = var.kms_master_key_id == null ? true : null
  kms_master_key_id          = var.kms_master_key_id
  redrive_policy             = var.redrive_policy

  tags = module.this.tags
}
