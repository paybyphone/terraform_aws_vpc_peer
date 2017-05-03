// vpc provides a vpc.
module "vpc" {
  source                  = "github.com/paybyphone/terraform_aws_vpc?ref=v0.1.0"
  project_path            = "${var.project_path}"
  public_subnet_addresses = ["${var.subnet_addresses}"]
  vpc_network_address     = "${var.vpc_address}"
}
