vpc_name = "production-vpc"
vpc_cidr = "10.200.128.0/22"
azs = [ "eu-west-1a", "eu-west-1b", "eu-west-1c" ]
public_subnets = [ "10.200.130.0/26", "10.200.130.64/26", "10.200.130.128/26" ]
private_subnets = [ "10.200.128.0/25", "10.200.128.128/25", "10.200.129.0/25" ]
