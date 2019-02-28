vpc_name = "staging-vpc"
vpc_cidr = "10.200.0.0/22"
azs = [ "eu-west-1a", "eu-west-1b", "eu-west-1c" ]
public_subnets = [ "10.200.2.0/26", "10.200.2.64/26", "10.200.2.128/26" ]
private_subnets = [ "10.200.0.0/25", "10.200.0.128/25", "10.200.1.0/25" ]

