terraform {
  required_version = ">= 1.0.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {}

resource "local_file" "nexvion_environment" {
  filename = "${path.module}/nexvion-environment.txt"

  content = <<-EOT
    Application: Nexvion
    Environment: production
    Platform: Kubernetes
    Deployment: Helm
    Monitoring: Prometheus and Grafana
    Managed-By: Terraform
  EOT
}
