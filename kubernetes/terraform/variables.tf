variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "worker_ami_id" {
  description = "AMI ID for worker nodes (built with Packer)"
  type        = string
  default     = "ami-1234567890abcdef0"
}