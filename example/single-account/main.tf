// vpc1 provides the first (owner) VPC.
module "vpc1" {
  source                  = "github.com/paybyphone/terraform_aws_vpc?ref=v0.1.0"
  project_path            = "${var.project_path}"
  public_subnet_addresses = ["${var.owner_subnet_address}"]
  vpc_network_address     = "${var.owner_vpc_address}"
}

// vpc2 provides the second (peer VPC).
module "vpc2" {
  source                  = "github.com/paybyphone/terraform_aws_vpc?ref=v0.1.0"
  project_path            = "${var.project_path}"
  public_subnet_addresses = ["${var.peer_subnet_address}"]
  vpc_network_address     = "${var.peer_vpc_address}"
}

// vpc_peer provides the VPC peer between our two VPCs.
module "vpc_peer" {
  source                          = "../../"
  allow_owner_peer_dns_resolution = "${var.allow_owner_peer_dns_resolution}"
  allow_peer_owner_dns_resolution = "${var.allow_peer_owner_dns_resolution}"
  owner_route_table_count         = 1
  owner_route_table_ids           = ["${module.vpc1.public_route_table_id}"]
  owner_subnet_count              = "${length(var.owner_subnet_address)}"
  owner_subnet_ids                = "${module.vpc1.public_subnet_ids}"
  owner_vpc_id                    = "${module.vpc1.vpc_id}"
  peer_route_table_count          = 1
  peer_route_table_ids            = ["${module.vpc2.public_route_table_id}"]
  peer_subnet_count               = "${length(var.peer_subnet_address)}"
  peer_subnet_ids                 = "${module.vpc2.public_subnet_ids}"
  peer_vpc_id                     = "${module.vpc2.vpc_id}"
  project_path                    = "${var.project_path}"
}
