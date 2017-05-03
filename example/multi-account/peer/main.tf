// vpc_peer provides the VPC peer between our two VPCs.
module "vpc_peer" {
  source                  = "../../../"
  owner_route_table_count = "1"
  owner_route_table_ids   = ["${var.owner_route_table_id}"]
  owner_subnet_count      = "${length(var.owner_subnet_ids)}"
  owner_subnet_ids        = ["${var.owner_subnet_ids}"]
  owner_vpc_id            = "${var.owner_vpc_id}"
  peer_account_id         = "${element(split(":", var.peer_role_arn), 4)}"
  peer_role_arn           = "${var.peer_role_arn}"
  peer_route_table_count  = "1"
  peer_route_table_ids    = ["${var.peer_route_table_id}"]
  peer_subnet_count       = "${length(var.peer_subnet_ids)}"
  peer_subnet_ids         = ["${var.peer_subnet_ids}"]
  peer_vpc_id             = "${var.peer_vpc_id}"
  project_path            = "${var.project_path}"
  requester_role_arn      = "${var.owner_role_arn}"
}
