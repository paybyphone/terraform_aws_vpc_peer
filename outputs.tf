// module terraform_aws_vpc_peer

// The VPC peer ID.
output "vpc_peer_id" {
  value = "${aws_vpc_peering_connection.vpc_peer.id}"
}
