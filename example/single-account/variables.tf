// The path to the project in VCS.
variable "project_path" {
  type    = "string"
  default = "paybyphone/terraform_aws_vpc_peer_example"
}

// The address of the owner VPC.
variable "owner_vpc_address" {
  type    = "string"
  default = "10.0.0.0/24"
}

// The subnet addresses in the owner VPC.
variable "owner_subnet_address" {
  type    = "list"
  default = ["10.0.0.0/25", "10.0.0.128/25"]
}

// The address of the peer VPC.
variable "peer_vpc_address" {
  type    = "string"
  default = "10.0.2.0/23"
}

// The subnet addresses in the peer VPC.
variable "peer_subnet_address" {
  type    = "list"
  default = ["10.0.2.0/25", "10.0.2.128/25", "10.0.3.0/25", "10.0.3.128/25"]
}

// Allow DNS queries from the peer VPC to resources in the owner VPC to look up
// as if they were made in the owner VPC and give local addresses.
variable "allow_peer_owner_dns_resolution" {
  type    = "string"
  default = "true"
}

// Allow DNS queries from the owner VPC to resources in the peer VPC to look up
// as if they were made in the peer VPC and give local addresses.
variable "allow_owner_peer_dns_resolution" {
  type    = "string"
  default = "true"
}
