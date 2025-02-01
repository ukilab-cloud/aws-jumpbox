##############################################################################################################
#
# Jumpbox Terraform deployment
#
#
##############################################################################################################

# Access and secret keys to your environment
#variable "access_key" {}
#variable "secret_key" {}
# Uncomment if using AWS SSO Token or Roel assumption:
# variable "token"      {}
variable "profile" {}

# Username for the linux host (password is instance-id)
variable "linux_username" {
  description = "Ubuntu host username"
  default     = "lab1"
}
variable "ubumajor" {
  description = "Ubuntu Version - Using the AMI Description"
  type        = string
  default     = "ubuntu/images/hvm-ssd-gp3/ubuntu-oracular-24.10-amd64-server"
}

variable "ubudate" {
  description = "Ubuntu Version - Date"
  type        = string
  default     = "20250110"
}

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
  default     = "uk-labl"
}

#Key Pair Name

variable "keypair" {
  description = "Provide a keypair for accessing the jumpbox instances"
  default     = "jumpbox"
}


# Prefix for all resources created for this deployment in AWS
variable "tag_name_prefix" {
  description = "Provide a common tag prefix value that will be used in the name tag for all resources"
  default     = "jumpbox"
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
  default     = "t3a.micro"
}

variable "scenario" {
  default = "jumpbox"
}

# References to your Networks
# jumpbox VPC
variable "vpc_jumpbox_cidr" {
  description = "Provide the network CIDR for the VPC"
  default     = "10.99.96.0/24"
}

#### public subnets
variable "vpc_jumpbox_public_subnet_cidr" {
  description = "Provide the network CIDR for jumpbox Public Subnet"
  default     = "10.99.96.0/25"
}

### Host address
variable "vpc_jumpbox_hostnum" {
  description = "host number in the VPC jumpbox public subnet"
  default     = "10"
}

### Approved CIDR for access to Jumpbox - used by NSG REQUIRED
### ChANGE THIS!
variable "vpc_jumpbox_allowed_cidr" {
  description = "Allowed CIDR block in array format"
  default     = "0.0.0.0/0"
}
