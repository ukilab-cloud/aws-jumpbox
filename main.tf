##############################################################################################################
# Terraform state
##############################################################################################################

terraform {
  required_version = ">= 1.6"
}

#### Deployment in AWS

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
  # Uncomment if using AWS SSO:
  # token      = var.token
}

#### Provision console user for Lab

resource "aws_iam_user" "labuser" {
  name = var.lab_username
  path = "/"
  force_destroy = true
}

data "aws_iam_policy" "EC2Full" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

data "aws_iam_policy" "VPCFull" {
  arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_user_policy_attachment" "EC2Full-attach" {
  user       = aws_iam_user.labuser.name
  policy_arn = data.aws_iam_policy.EC2Full.arn
}

resource "aws_iam_user_policy_attachment" "VPCFull-attach" {
  user       = aws_iam_user.labuser.name
  policy_arn = data.aws_iam_policy.VPCFull.arn
}

resource "aws_iam_user_login_profile" "labuser_login" {
  user    = aws_iam_user.labuser.name
  #pgp_key = "keybase:some_person_that_exists"
}

#### Keys used by any instances deployed by this template

resource "tls_private_key" "pk" {
   algorithm = "ED25519"
 }
resource "aws_key_pair" "awskeypair" {
  key_name   = var.keypair
  public_key = tls_private_key.pk.public_key_openssh
}
resource "local_sensitive_file" "sshprivkey" {
  content  = tls_private_key.pk.private_key_openssh
  filename = "${path.module}/sshkey-${aws_key_pair.awskeypair.key_name}-ssh-priv.pem"
}
resource "local_sensitive_file" "sshpubkey" {
  content  = tls_private_key.pk.public_key_openssh
  filename = "${path.module}/sshkey-${aws_key_pair.awskeypair.key_name}-ssh-pub.pem"
}
