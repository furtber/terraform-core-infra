
##################################################################
# Example: Show how to read data from AWS
# Data sources to get VPC, subnet, security group and AMI details
##################################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  owners = ["amazon"]
}

##################################################################
# Example: Create a simple SNS - use Variable for name
##################################################################
resource "aws_sns_topic" "example_sns" {
	name= "${var.snstopic}"

}

resource "aws_instance" "frontend" {
  ami           = "${data.aws_ami.amazon_linux.id}"
  instance_type = "t2.micro"

  tags {
     Name = "${var.tag_instance_name}"
     business_unit = "${var.tag_business_unit}"
     cost_center = "${var.tag_cost_center}"
     environment = "${var.tag_environment}"
     role = "Notifications"
     Terraform = "True"
   }
}

