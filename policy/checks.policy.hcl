policy {}

resource_policy "aws_s3_bucket" "prefix_check" {
  enforce {
    condition     = attrs.bucket_prefix == "tfp050-tagged-"
    error_message = "bucket_prefix must be tfp050-tagged-"
  }
}
