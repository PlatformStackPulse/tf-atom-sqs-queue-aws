variable "fifo_queue" {
  description = "Whether this is a FIFO queue"
  type        = bool
  default     = false
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout in seconds"
  type        = number
  default     = 30
}

variable "message_retention_seconds" {
  description = "Message retention period in seconds"
  type        = number
  default     = 345600
}

variable "delay_seconds" {
  description = "Delivery delay in seconds"
  type        = number
  default     = 0
}

variable "max_message_size" {
  description = "Maximum message size in bytes"
  type        = number
  default     = 262144
}

variable "receive_wait_time_seconds" {
  description = "Long-poll receive wait time in seconds"
  type        = number
  default     = 0
}

variable "kms_master_key_id" {
  description = "KMS key ID for encryption (null for SSE-SQS)"
  type        = string
  default     = null
}

variable "redrive_policy" {
  description = "JSON redrive policy for dead-letter queue"
  type        = string
  default     = null
}
