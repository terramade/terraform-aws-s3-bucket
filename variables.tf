variable "acl" {
  type        = string
  default     = "private"
  description = "(Optional) A canned access control list (ACL) that grants predefined permissions to the bucket."

  validation {
    condition = contains(["private", "public-read", "public-read-write", "aws-exec-read", "authenticated-read", "log-delivery-write"], var.acl)
    error_message = "Valid values for \"acl\" are \"private\", \"public-read\", \"public-read-write\", \"aws-exec-read\", \"authenticated-read\" and \"log-delivery-write\"."
  }
}

variable "bucket_name" {
  type        = string
  default     = null
  description = "(Optional) Name of the bucket. If none is specified, Terraform will generate a random, unique name."
}

variable "logging" {
  type = object({
    target_bucket = string
    target_prefix = string
  })
  default = {
    target_bucket = null
    target_prefix = null
  }
  description = "A map with details for the bucket server access log delivery location."
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the bucket."
  type        = map(string)
  default     = {}
}

