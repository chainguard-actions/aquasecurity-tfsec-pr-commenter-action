# Simple Terraform fixture for tfsec testing
resource "aws_s3_bucket" "example" {
  bucket = "my-test-bucket"
}
