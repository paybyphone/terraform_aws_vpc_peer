/**
 *
 * # terraform_aws_vpc_peer
 * 
 * This is a Terraform module to create a VPC peering between two VPCs. By
 * default, this module will set up the peer between VPCs within the same
 * account. However, by supplying the `peer_account_id`, `peer_role_arn`, and
 * `requester_role_arn` options, this this module can create and accept peers
 * across two different accounts, so long as the credentials that call TF can
 * assume the roles of both the supplied owner and peer roles, and those
 * respective roles have access to perform the peering.
 * 
 * Routes are controlled via supplying the subnet quantities, subnet IDs, route
 * table quantities, and route table IDs to the appropriate `*_subnet_count`,
 * `*_subnet_ids`, `*_route_table_count`, and `*_route_table_ids` parameters
 * for both the peer and owners. Via these variables, it's possible to
 * selectively peer only the subnets that you need.
 * 
 * ## Example with single account
 *
 *
 *     // vpc1 provides the first (owner) VPC.
 *     module "vpc1" {
 *       source                  = "github.com/paybyphone/terraform_aws_vpc?ref=v0.1.0"
 *       project_path            = "${var.project_path}"
 *       public_subnet_addresses = ["${var.owner_subnet_address}"]
 *       vpc_network_address     = "${var.owner_vpc_address}"
 *     }
 *     
 *     // vpc2 provides the second (peer VPC).
 *     module "vpc2" {
 *       source                  = "github.com/paybyphone/terraform_aws_vpc?ref=v0.1.0"
 *       project_path            = "${var.project_path}"
 *       public_subnet_addresses = ["${var.peer_subnet_address}"]
 *       vpc_network_address     = "${var.peer_vpc_address}"
 *     }
 *     
 *     // vpc_peer provides the VPC peer between our two VPCs.
 *     module "vpc_peer" {
 *       source                  = "github.com/paybyphone/terraform_aws_vpc_peer?ref=VERSION""
 *       owner_route_table_count = 1
 *       owner_route_table_ids   = ["${module.vpc1.public_route_table_id}"]
 *       owner_subnet_count      = "${length(var.owner_subnet_address)}"
 *       owner_subnet_ids        = "${module.vpc1.public_subnet_ids}"
 *       owner_vpc_id            = "${module.vpc1.vpc_id}"
 *       peer_route_table_count  = 1
 *       peer_route_table_ids    = ["${module.vpc2.public_route_table_id}"]
 *       peer_subnet_count       = "${length(var.peer_subnet_address)}"
 *       peer_subnet_ids         = "${module.vpc2.public_subnet_ids}"
 *       peer_vpc_id             = "${module.vpc2.vpc_id}"
 *       project_path            = "${var.project_path}"
 *     }
 * 
 * ## Example with multiple accounts
 * 
 * A multi-account example is a little more complex and tough to include in a
 * README. See the [example/multi-account](example/multi-account) directory for
 * a full example. Note that this example also makes use of
 * [aws-runas](https://github.com/vancluever/aws-runas), so you may need to
 * adjust the example to fit your specific toolchain.
 *
 * ## Removing the Peer from Configuration
 *
 * Special considerations need to be taken when removing this resource from a
 * Terraform configuration due to some current known issues with how Terraform
 * handles provider aliases embedded in modules. For more details and
 * instructions on how to remove this module from config, see
 * [here](https://github.com/hashicorp/terraform/issues/1819#issuecomment-261316458).
 * Note that this only applies to configurations that are being fully destroyed
 * - `terraform destroy` will work as expected.
 *
 */

