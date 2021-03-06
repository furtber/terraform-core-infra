
module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    name = "${var.vpc_name}"
    cidr = "${var.vpc_cidr}"

    azs = "${var.azs}"
    private_subnets = "${var.private_subnets}"
    public_subnets = "${var.public_subnets}"

    enable_nat_gateway = true

    tags = {
        Terraform = "true"
        environment = "${var.ENVIRONMENT}"
        cost_center = "${var.tag_cost_center}"
        business_unit = "${var.tag_business_unit}"
    }
}
