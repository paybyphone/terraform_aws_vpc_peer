// module terraform_aws_vpc_peer

// vpc_peer provides the VPC peering connection resource.
resource "aws_vpc_peering_connection" "vpc_peer" {
  provider      = "aws.requester"
  peer_vpc_id   = "${var.peer_vpc_id}"
  peer_owner_id = "${var.peer_account_id}"
  vpc_id        = "${var.owner_vpc_id}"
  auto_accept   = "${var.peer_account_id == "" ? "true" : "false" }"

  requester {
    allow_remote_vpc_dns_resolution = "${var.allow_peer_owner_dns_resolution}"
  }

  accepter {
    allow_remote_vpc_dns_resolution = "${var.allow_owner_peer_dns_resolution}"
  }

  tags {
    project_path = "${var.project_path}"
  }
}

// vpc_peer_accepter provides the accepter resource - allowing acceptnace of
// the peering connection from a different account ID, if supplied. The default
// action is to accept from the same account. To full use of the cross-account
// feature, ensure peer_account_id, peer_role_arn, and requester_role_arn are
// set.
resource "aws_vpc_peering_connection_accepter" "vpc_peer_accepter" {
  count                     = "${var.peer_account_id != "" ? 1 : 0}"
  provider                  = "aws.peer"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
  auto_accept               = true

  tags {
    project_path = "${var.project_path}"
  }
}

// owner_subnets provides information on the supplied owner_subnet_ids,
// including the CIDR subnet addresses.
data "aws_subnet" "owner_subnets" {
  provider = "aws.requester"
  count    = "${var.owner_subnet_count}"
  id       = "${var.owner_subnet_ids[count.index]}"
}

// peer_subnets provides information on the supplied peer_subnet_ids,
// including the CIDR subnet addresses.
data "aws_subnet" "peer_subnets" {
  provider = "aws.peer"
  count    = "${var.peer_subnet_count}"
  id       = "${var.peer_subnet_ids[count.index]}"
}

// owner_to_peer_subnet_routes provides the routes to the peer VPC subnets, from 
// the owner VPC.
resource "aws_route" "owner_to_peer_subnet_routes" {
  provider                  = "aws.requester"
  count                     = "${var.owner_route_table_count * var.peer_subnet_count}"
  route_table_id            = "${element(var.owner_route_table_ids, count.index)}"
  destination_cidr_block    = "${element(data.aws_subnet.peer_subnets.*.cidr_block, count.index)}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
}

// peer_to_owner_subnet_routes provides the routes to the owner VPC subnets, from 
// the peer VPC.
resource "aws_route" "peer_to_owner_subnet_routes" {
  provider                  = "aws.peer"
  count                     = "${var.owner_subnet_count * var.peer_route_table_count}"
  route_table_id            = "${element(var.peer_route_table_ids, count.index)}"
  destination_cidr_block    = "${element(data.aws_subnet.owner_subnets.*.cidr_block, count.index)}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
}
