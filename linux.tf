##############################################################################################################
# VM LINUX for testing
##############################################################################################################
## Retrieve AMI info
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Create Role for Jumpbox to be apble to use terraform and deploy as necessayr
resource "aws_iam_instance_profile" "jumpbox_profile" {
  name = "Jumpbox_profile"
  role = aws_iam_role.jumpbox_role.name
}

data "aws_iam_policy_document" "jumpbox_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "jumpbox_role" {
  name               = "jumpbox_role"
  assume_role_policy = data.aws_iam_policy_document.jumpbox_assume_role.json
}

data "aws_iam_policy_document" "jumpbox_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:*"]
    resources = ["*"]
  }
    statement {
    effect    = "Allow"
    actions   = ["vpc:*"]
    resources = ["*"]
  }
    statement {
    effect    = "Allow"
    actions   = ["iam:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "jumpbox_policy" {
  name        = "jumpbox_policy"
  description = "Jumpbox Policy"
  policy      = data.aws_iam_policy_document.jumpbox_policy_document.json
}

resource "aws_iam_role_policy_attachment" "jumpbox-attach" {
  role       = aws_iam_role.jumpbox_role.name
  policy_arn = aws_iam_policy.jumpbox_policy.arn
}
## Security Groups foro Spoke VPCs

resource "aws_security_group" "NSG-jumpzone" {
  name        = "NSG-jumpzone"
  description = "Allow SSH, HTTPS and ICMP traffic"
  vpc_id      = aws_vpc.vpc_jumpzone.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8 # the ICMP type number for 'Echo'
    to_port     = 0 # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0 # the ICMP type number for 'Echo Reply'
    to_port     = 0 # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "NSG-jumpzone"
    scenario = var.scenario
  }
}

# Jumpzopne Instance
resource "aws_instance" "jumpzone-host" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.vpc_jumpzone_public_subnet.id
  vpc_security_group_ids = [aws_security_group.NSG-jumpzone.id]
  key_name               = var.keypair
  associate_public_ip_address = true
  private_ip             = cidrhost(var.vpc_jumpzone_public_subnet_cidr, var.vpc_jumpzone_hostnum)
  iam_instance_profile = aws_iam_instance_profile.jumpbox_profile.name
  tags = {
    Name     = "${var.tag_name_prefix}-jumpzone-host"
    scenario = var.scenario
    az       = var.availability_zone1
  }
}