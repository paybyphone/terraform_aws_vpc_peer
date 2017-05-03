// The VPC ID of the onwer VPC.
output "owner_vpc_id" {
  value = "${module.vpc1.vpc_id}"
}

// The VPC ID of the onwer VPC.
output "peer_vpc_id" {
  value = "${module.vpc2.vpc_id}"
}

// The subnet IDs of the owner VPC.
output "owner_subnet_ids" {
  value = "${module.vpc1.public_subnet_ids}"
}

// The subnet IDs of the peer VPC.
output "peer_subnet_ids" {
  value = "${module.vpc2.public_subnet_ids}"
}

// The ID of the VPC peer.
output "vpc_peer_id" {
  value = "${module.vpc_peer.vpc_peer_id}"
}
