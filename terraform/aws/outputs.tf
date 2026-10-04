output "instance_id" {
  description = "AWS EC2 instance ID for the Nexvion application"
  value       = aws_instance.nexvion.id
}

output "elastic_ip" {
  description = "Static public IP address for the Nexvion application"
  value       = aws_eip.nexvion.public_ip
}

output "nexvion_url" {
  description = "Public URL for the Nexvion application"
  value       = "http://${aws_eip.nexvion.public_ip}"
}
