// module paybyphone-vpcpeer

// The provider alias for the peer requester.
provider "aws" {
  alias = "requester"

  assume_role {
    role_arn = "${var.requester_role_arn}"
  }
}

// The provider alias for the peer target.
provider "aws" {
  alias = "peer"

  assume_role {
    role_arn = "${var.peer_role_arn}"
  }
}
