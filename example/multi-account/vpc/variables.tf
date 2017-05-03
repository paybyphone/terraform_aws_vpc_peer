// The path to the project in VCS.
variable "project_path" {
  type    = "string"
  default = "paybyphone/terraform_aws_vpc_peer_example"
}

// The address of the VPC.
variable "vpc_address" {
  type = "string"
}

// The subnet addresses in the VPC.
variable "subnet_addresses" {
  type = "list"
}

// The role ARN for the account that the VPC belongs to.
variable "role_arn" {
  type = "string"
}
