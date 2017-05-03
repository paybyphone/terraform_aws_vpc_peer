// The ID of the VPC.
output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

// The subnet IDs for the VPC.
output "subnet_ids" {
  value = "${module.vpc.public_subnet_ids}"
}

// The route table ID for the VPC.
output "route_table_id" {
  value = "${module.vpc.public_route_table_id}"
}

// The role ARN for the account that the VPC belongs to.
output "role_arn" {
  value = "${var.role_arn}"
}
