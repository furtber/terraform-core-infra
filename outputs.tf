# VPC
output "vpc_id"   { value = "${module.vpc.vpc_id}" }
output "vpc_cidr" { value = "${module.vpc.vpc_cidr_block}" }

# subnets
output "public_subnet_ids"  { value = "${module.vpc.public_subnets}" }
output "private_subnet_ids" { value = "${module.vpc.private_subnets}" }
