// module terraform_aws_vpc_peer

// The path to the project in VCS.
variable "project_path" {
  type = "string"
}

// The VPC ID of the VPC that owns the peer.
variable "owner_vpc_id" {
  type = "string"
}

// The VPC ID of the VPC to peer to. 
variable "peer_vpc_id" {
  type = "string"
}

// The account ID of the peer VPC. If this is supplied, `peer_role_arn` and
// `requester_role_arn` should be supplied as well to ensure correct
// connectivity to both VPCs to automatically request and accept the peer.
variable "peer_account_id" {
  type    = "string"
  default = ""
}

// The role ARN of the peer VPC. If this is supplied, `peer_account_id` and
// `requester_role_arn` should be supplied as well to ensure correct
// connectivity to both VPCs to automatically request and accept the peer.
variable "peer_role_arn" {
  type    = "string"
  default = ""
}

// The role ARN of the requester VPC. If this is supplied, `peer_account_id`
// and `peer_role_arn` should be supplied as well to ensure correct
// connectivity to both VPCs to automatically request and accept the peer.
variable "requester_role_arn" {
  type    = "string"
  default = ""
}

// The number of owner subnets to expect.
//
// This value cannot be computed by the time the module is processed or
// else you will get an error.
variable "owner_subnet_count" {
  type = "string"
}

// The subnet IDs on the owner end to route to the peer.
variable "owner_subnet_ids" {
  type = "list"
}

// The number of peer subnets to expect.
//
// This value cannot be computed by the time the module is processed or
// else you will get an error.
variable "peer_subnet_count" {
  type = "string"
}

// The subnet IDs on the peer end to route to the owner.
variable "peer_subnet_ids" {
  type = "list"
}

// The number of owner route tables to expect.
//
// This value cannot be computed by the time the module is processed or
// else you will get an error.
variable "owner_route_table_count" {
  type = "string"
}

// The route table IDs on the owner end to add the peer routes to.
variable "owner_route_table_ids" {
  type = "list"
}

// The number of peer route tables to expect.
//
// This value cannot be computed by the time the module is processed or
// else you will get an error.
variable "peer_route_table_count" {
  type = "string"
}

// The route table IDs on the peer end to add the peer routes to.
variable "peer_route_table_ids" {
  type = "list"
}

// Allows clients in the peer VPC to resolve DNS hostnames as if they those
// queries were being made in the owner VPC (ie: RDS instance hostnames will
// resolve as local addresses). This option is generally only useful for
// AWS-managed DNS resources only.
variable "allow_peer_owner_dns_resolution" {
  type    = "string"
  default = "false"
}

// Allows clients in the owner VPC to resolve DNS hostnames as if they those
// queries were being made in the peer VPC (ie: RDS instance hostnames will
// resolve as local addresses). This option is generally only useful for
// AWS-managed DNS resources only.
variable "allow_owner_peer_dns_resolution" {
  type    = "string"
  default = "false"
}
