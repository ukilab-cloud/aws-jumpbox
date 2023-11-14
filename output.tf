# Output
output "jumpzone_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.jumpzone-host.id
}

output "jumpzone_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.jumpzone-host.public_ip
}

output "labuser_password" {
  value = aws_iam_user_login_profile.labuser_login.encrypted_password
}
