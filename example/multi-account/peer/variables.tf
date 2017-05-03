// The path to the project in VCS.
variable "project_path" {
  type    = "string"
  default = "paybyphone/terraform_aws_vpc_peer_example"
}

// The role ARN of the account that manages the owner VPC.
variable "owner_role_arn" {
  type = "string"
}

// The route table ID for the owner VPC.
variable "owner_route_table_id" {
  type = "string"
}

// The subnet IDs on the owner end to route to the owner.
variable "owner_subnet_ids" {
  type = "list"
}

// The VPC ID of the owner VPC.
variable "owner_vpc_id" {
  type = "string"
}

// The role ARN of the account that manages the peer VPC.
variable "peer_role_arn" {
  type = "string"
}

// The route table ID for the peer VPC.
variable "peer_route_table_id" {
  type = "string"
}

// The subnet IDs on the peer end to route to the owner.
variable "peer_subnet_ids" {
  type = "list"
}

// The VPC ID of the peer VPC.
variable "peer_vpc_id" {
  type = "string"
}
