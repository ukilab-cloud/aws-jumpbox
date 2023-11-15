# Output
output "jumpbox_username" {
  description = "Username for Jumpbox Host"
  value       = var.linux_username
}

output "jumpbox_password" {
  description = "Password for Jumpbox Host (Instance ID)"
  value       = aws_instance.jumpbox-host.id
}

output "jumpbox_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.jumpbox-host.public_ip
}
### Use this for exporting user password if specicifying PGP key 
#output "labuser_password" {
#  value = aws_iam_user_login_profile.labuser_login.encrypted_password
#}
