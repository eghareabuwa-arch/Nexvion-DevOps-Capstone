output "application_name" {
  description = "Nexvion application name"
  value       = var.application_name
}

output "environment" {
  description = "Nexvion deployment environment"
  value       = var.environment
}

output "environment_file" {
  description = "Terraform-managed environment file"
  value       = local_file.nexvion_environment.filename
}
