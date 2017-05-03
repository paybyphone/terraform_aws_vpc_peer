## v0.2.0

The `owner_route_table_id` and `peer_route_table_id` variables are now
`owner_route_table_ids` and `peer_route_table_ids`, reflecting the fact that
they now allow multiple route tables to be entered (comma separated).
Also, `owner_route_table_count` and `peer_route_table_count` have been
added, as Terraform currently cannot interpolate computed variables in
count (see #2301).

## v0.1.0

Initial release.
