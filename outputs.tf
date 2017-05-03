// outputs.tf defines the outputs for the VPC peering module.

// The VPC peer ID.
output "vpc_peer_id" {
  value = "${aws_vpc_peering_connection.vpc_peer.id}"
}
