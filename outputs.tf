# VPC
output "vpc_id"   { value = "${module.vpc.vpc_id}" }
output "vpc_cidr" { value = "${module.vpc.vpc_cidr}" }

# subnets
output "public_subnet_ids"  { value = "${module.public_subnets.subnet_ids}" }
output "private_subnets_t1_ids" { value = "${module.private_subnets_t1.subnet_ids}" }
output "private_subnets_t2_ids" { value = "${module.private_subnets_t2.subnet_ids}" }
