.PHONY: clean owner_vpc peer_vpc peering_connection_vars peering_connection
export AWS_DEFAULT_REGION ?= ca-central-1
TF_CMD ?= apply

check_vars:
ifeq ($(OWNER_PROFILE),)
	$(error Please define the OWNER_PROFILE environment variable)
endif
ifeq ($(PEER_PROFILE),)
	$(error Please define the PEER_PROFILE environment variable)
endif

clean:
	rm -rf .terraform

owner_vpc: check_vars
	rm -rf .terraform
	terraform get vpc/
	aws-runas --profile $(OWNER_PROFILE) \
		sh -c 'terraform $(TF_CMD) \
		-state state/owner_vpc.tfstate \
		-var-file vars/owner.tfvars -var role_arn=$${AWS_RUNAS_ASSUMED_ROLE_ARN} vpc/'

peer_vpc: check_vars
	rm -rf .terraform
	terraform get vpc/
	aws-runas --profile $(PEER_PROFILE) \
		sh -c 'terraform $(TF_CMD) \
		-state state/peer_vpc.tfstate \
		-var-file vars/peer.tfvars -var role_arn=$${AWS_RUNAS_ASSUMED_ROLE_ARN} vpc/'

peering_connection_vars:
	terraform output -state state/owner_vpc.tfstate -json \
		| jq '. | keys[] as $$k | {($$k): .[$$k].value} | with_entries(.key |= "owner_"+ .)' \
		| jq -s add \
		> vars/peering_connection_owner.tfvars
	terraform output -state state/peer_vpc.tfstate -json \
		| jq '. | keys[] as $$k | {($$k): .[$$k].value} | with_entries(.key |= "peer_"+ .)' \
		| jq -s add \
		> vars/peering_connection_peer.tfvars

peering_connection: peering_connection_vars
	rm -rf .terraform
	terraform get peer/
	aws-runas --no-role terraform $(TF_CMD) \
		-state state/peer.tfstate \
		-var-file vars/peering_connection_owner.tfvars \
		-var-file vars/peering_connection_peer.tfvars \
		peer/
