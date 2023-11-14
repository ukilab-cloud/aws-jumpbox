##############################################################################################################
#
# Jumpbox Terraform deployment
# Active Passive High Availability MultiAZ with AWS Transit Gateway with VPC standard attachment -
#
##############################################################################################################

# Access and secret keys to your environment
variable "access_key" {}
variable "secret_key" {}

# Username for the linux host (password is instance-id)
variable "linux_username" {
  description = "Ubuntu host username"
  default     = "lab1"
} 

# Uncomment if using AWS SSO:
# variable "token"      {}
# References of your environment

variable "region" {
  description = "Provide the region to deploy the VPC in"
  default     = "eu-west-2"
}

variable "availability_zone1" {
  description = "Provide the first availability zone to create the subnets in"
  default     = "eu-west-2a"
}

variable "availability_zone2" {
  description = "Provide the second availability zone to create the subnets in"
  default     = "eu-west-2b"
}

#Console User

variable "lab_username" {
  description = "Username for the AWS Console user"
  default     = "UK-LAB1"  
}

#Key Pair Name

variable "keypair" {
  description = "Provide a keypair for accessing the Jumpzone instances"
  default     = "aplab"
}


# Prefix for all resources created for this deployment in AWS
variable "tag_name_prefix" {
  description = "Provide a common tag prefix value that will be used in the name tag for all resources"
  default     = "aplab"
}


// instance architect
// Either arm or x86
variable "arch" {
  default = "x86"
}

// instance type needs to match the architect
// c5n.xlarge is x86_64
// c6g.xlarge is arm
// For detail, refer to https://aws.amazon.com/ec2/instance-types/
variable "instance_type" {
  description = "Provide the instance type for the Jumpbox"
  default = "t2.micro"
}

variable "scenario" {
  default = "ap-tgw"
}

# References to your Networks
# Jumpzone VPC
variable "vpc_jumpzone_cidr" {
  description = "Provide the network CIDR for the VPC"
  default     = "10.99.96.0/24"
}

#### public subnets
variable "vpc_jumpzone_public_subnet_cidr" {
  description = "Provide the network CIDR for Jumpzone Public Subnet"
  default     = "10.99.96.0/25"
}

### Host address
variable "vpc_jumpzone_hostnum" {
  description = "host number in the VPC jumpzone public subnet"
  default     = "10"
} 