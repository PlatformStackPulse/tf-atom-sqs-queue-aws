# Unit tests for tf-atom-sqs-queue-aws
#
# Plan-only tests using a mock AWS provider — no real AWS calls are made.
# Run with: terraform init -backend=false && terraform test
# Run verbose: terraform test -verbose
# Run specific: terraform test -run "creates_when_enabled"

mock_provider "aws" {}

variables {
  # tf-label context labels
  namespace = "eg"
  stage     = "test"
  name      = "thing"
}

# ---------------------------------------------------------------------------
# Test: module creates the SQS queue when enabled (default)
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should be enabled by default"
  }

  assert {
    condition     = aws_sqs_queue.this[0].name == "eg-test-thing"
    error_message = "Queue name should be the tf-label id 'eg-test-thing'"
  }

  assert {
    condition     = aws_sqs_queue.this[0].fifo_queue == false
    error_message = "Queue should be a standard (non-FIFO) queue by default"
  }
}

# ---------------------------------------------------------------------------
# Test: FIFO queue naming appends .fifo suffix
# ---------------------------------------------------------------------------
run "fifo_queue_naming" {
  command = plan

  variables {
    fifo_queue = true
  }

  assert {
    condition     = aws_sqs_queue.this[0].name == "eg-test-thing.fifo"
    error_message = "FIFO queue name should end with .fifo"
  }
}

# ---------------------------------------------------------------------------
# Test: module creates nothing when disabled
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = length(aws_sqs_queue.this) == 0
    error_message = "No SQS queue should be created when enabled = false"
  }

  assert {
    condition     = output.arn == null
    error_message = "arn output should be null when disabled"
  }
}
