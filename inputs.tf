#
# This variable is passed from Jenkins parameter
#
variable "ENVIRONMENT" {}

#
# These variables are defined in ENVIRONMENT.tfvars
#
variable "vpc_name"         {
  description = "Name of the VPC."
}
variable "vpc_cidr"         {
  description = "VPC address range in CIDR format."
}
variable "azs"              {
  description = "Availability zones that are used."
}
variable "public_subnets"   {
  description = "List of public subnets."
}
variable "private_subnets"  {
  description = "List of private subnets."
}
