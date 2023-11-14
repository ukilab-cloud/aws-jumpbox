# Output
output "jumpzone_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.jumpzone-host.id
}

output "jumpzone_username" {
  description = "Username for Jumpzone Host"
  value       = var.linux_username
}

output "jumpzone_password" {
  description = "Password for Jumpzone Host"
  value       = aws_vpc.vpc_jumpzone.id
}

output "jumpzone_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.jumpzone-host.public_ip
}
### Use this for exporting user password if specicifying PGP key 
#output "labuser_password" {
#  value = aws_iam_user_login_profile.labuser_login.encrypted_password
#}
