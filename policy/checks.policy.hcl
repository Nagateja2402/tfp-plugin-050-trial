policy {}

# Expect: tagged PASS, untagged FAIL (mandatory)
resource_policy "aws_s3_bucket" "require_owner_tag" {
  enforcement_level = "mandatory"
  operations        = ["create", "update"]
  enforce {
    condition     = attrs.tags != null && core::lookup(attrs.tags, "Owner", null) != null
    error_message = "S3 bucket must have an Owner tag"
  }
}

# Expect: FAIL (advisory)
resource_policy "aws_security_group" "no_open_ssh" {
  enforcement_level = "advisory"
  enforce {
    condition = core::alltrue([
      for r in attrs.ingress : !(core::contains(r.cidr_blocks, "0.0.0.0/0") && r.from_port <= 22 && r.to_port >= 22)
    ])
    error_message = "Security group must not allow SSH from 0.0.0.0/0"
  }
}

# no-op only: must NOT evaluate on a create-only plan (0.5.0 NO_OP support)
resource_policy "aws_s3_bucket" "noop_only" {
  enforcement_level = "mandatory"
  operations        = ["no-op"]
  enforce {
    condition     = false
    error_message = "noop_only fired: op=${meta.operation}"
  }
}
