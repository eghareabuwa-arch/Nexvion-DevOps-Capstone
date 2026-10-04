# Nexvion DevOps Capstone Project

## Overview

Nexvion is an e-commerce frontend application used to demonstrate the implementation of an end-to-end DevOps workflow.

The application itself is a static frontend built with HTML, CSS and JavaScript. The primary focus of this capstone is the engineering lifecycle around the application: version control, automation, containerization, continuous integration and delivery, security scanning, Infrastructure as Code, configuration management, container orchestration, application packaging, monitoring and centralized logging.

The project demonstrates how a web application can progress from source code to an automated, containerized and observable deployment environment using modern DevOps tools and practices.

---

## DevOps Architecture

```text
                         Developer
                             |
                             v
                       Git / GitHub
                             |
                             v
                         Jenkins
                      CI/CD Pipeline
                             |
          +------------------+------------------+
          |                  |                  |
          v                  v                  v
        Build              Test          Docker Image
                                                |
                                                v
                                        Trivy Security Scan
                                                |
                                                v
                                          Docker Registry
                                                |
                                                v
                                      Kubernetes / Minikube
                                                |
                                                v
                                               Helm
                                                |
                                                v
                                             Nexvion
                                           2 Replicas
                                                |
                         +----------------------+----------------------+
                         |                                             |
                         v                                             v
                    Prometheus                                   Application Logs
                         |                                             |
                         v                                             v
                      Grafana                                       Logstash
                                                                       |
                                                                       v
                                                                  Elasticsearch
                                                                       |
                                                                       v
                                                                     Kibana


             Terraform                         Ansible
        Infrastructure as Code          Configuration Automation
```

---

## Technology Stack

| Category | Technology | Purpose |
|---|---|---|
| Application | HTML, CSS, JavaScript | Nexvion frontend |
| Web Server | Nginx | Serves the application |
| Version Control | Git & GitHub | Source control and collaboration |
| Automation | Bash | Operational automation scripts |
| Containerization | Docker | Application image and containers |
| Multi-container Management | Docker Compose | Declarative container deployment |
| CI/CD | Jenkins | Automated build, test, scan and deployment workflow |
| Security | Trivy | Docker image vulnerability scanning |
| Infrastructure as Code | Terraform | Declarative infrastructure/environment configuration |
| Configuration Management | Ansible | Automated system configuration |
| Orchestration | Kubernetes / Minikube | Container orchestration |
| Package Management | Helm | Kubernetes application packaging and deployment |
| Metrics | Prometheus | Metrics collection |
| Visualization | Grafana | Monitoring dashboards |
| Log Processing | Logstash | Centralized log ingestion and enrichment |
| Log Storage/Search | Elasticsearch | Log indexing and search |
| Log Visualization | Kibana | Log discovery and analysis |

---

## Repository Structure

```text
Nexvion/
|
|-- Dockerfile
|-- docker-compose.yml
|-- Jenkinsfile
|-- README.md
|-- index.html
|-- products.html
|-- payment.html
|
|-- scripts/
|   |-- setup.sh
|   |-- deploy.sh
|   |-- health-check.sh
|   |-- backup.sh
|   `-- cleanup.sh
|
|-- k8s/
|   |-- namespace.yaml
|   |-- deployment.yaml
|   |-- service.yaml
|   |-- ingress.yaml
|   |-- configmap.yaml
|   `-- secret.yaml
|
|-- helm/
|   `-- nexvion/
|       |-- Chart.yaml
|       |-- values.yaml
|       `-- templates/
|
|-- terraform/
|   |-- main.tf
|   |-- variables.tf
|   |-- outputs.tf
|   `-- .terraform.lock.hcl
|
|-- ansible/
|   |-- inventory.ini
|   `-- playbook.yml
|
`-- logging/
    |-- docker-compose.yml
    `-- logstash/
        `-- logstash.conf
```

---

## 1. Source Control with Git and GitHub

Git is used to track changes to the Nexvion source code and DevOps configuration.

The repository is hosted on GitHub, providing centralized source control and a record of project changes.

The development workflow follows the general pattern:

```text
Local Development
      |
      v
Git Commit
      |
      v
GitHub Repository
      |
      v
CI/CD Pipeline
```

Generated Terraform state and sensitive/local environment files are excluded from source control using `.gitignore`.

---

## 2. Bash Automation

Operational Bash scripts are maintained under the `scripts/` directory.

### setup.sh

Validates and prepares the required deployment environment.

### deploy.sh

Automates application build and deployment operations.

### health-check.sh

Checks application availability and assists with post-deployment verification.

### backup.sh

Creates timestamped backups of project/application resources.

### cleanup.sh

Removes unnecessary Docker build resources to support environment maintenance.

These scripts reduce repetitive manual operations and improve consistency.

---

## 3. Docker Containerization

Nexvion is packaged into a Docker image and served by Nginx.

The basic workflow is:

```text
Application Source
       |
       v
   Dockerfile
       |
       v
  Docker Image
       |
       v
Docker Container
       |
       v
Nginx Web Server
```

A manual Docker deployment can be exposed locally on port `8083`.

A Docker Compose deployment can be exposed locally on port `8084`.

---

## 4. Docker Compose

Docker Compose provides declarative service configuration and simplifies repeatable local deployment.

Example:

```bash
docker compose up -d
```

This allows the application services defined in `docker-compose.yml` to be created and started consistently.

---

## 5. Jenkins CI/CD Pipeline

The project includes a `Jenkinsfile` defining the automated CI/CD workflow.

The pipeline automates key stages of the software delivery lifecycle, including application processing, Docker image creation, security scanning and deployment-related operations.

High-level pipeline flow:

```text
GitHub
   |
   v
Jenkins
   |
   +--> Build
   |
   +--> Test / Validation
   |
   +--> Docker Image Build
   |
   +--> Trivy Security Scan
   |
   +--> Registry / Deployment
```

This reduces manual deployment effort and provides a repeatable delivery process.

---

## 6. DevSecOps with Trivy

Security scanning is integrated directly into the Jenkins pipeline.

Trivy scans the generated Nexvion Docker image for:

- HIGH vulnerabilities
- CRITICAL vulnerabilities

The Jenkins security stage uses the Trivy container image to inspect the newly built application image.

The current configuration uses:

```text
--severity HIGH,CRITICAL
--exit-code 0
```

This means vulnerabilities are reported by the pipeline while the scan currently operates as a non-blocking security control.

This integration demonstrates a shift-left DevSecOps approach by introducing vulnerability detection into CI/CD.

---

## 7. Terraform Infrastructure as Code

Terraform is used to demonstrate declarative Infrastructure as Code and environment management.

Terraform configuration is stored in:

```text
terraform/
```

The implementation includes:

- `main.tf`
- `variables.tf`
- `outputs.tf`
- Terraform provider locking

The workflow was validated using:

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

The successful apply created a Terraform-managed Nexvion environment resource and produced application/environment outputs.

Terraform state files and the `.terraform` working directory are excluded from Git through `.gitignore`.

---

## 8. Ansible Configuration Management

Ansible is used to automate Nexvion environment configuration.

The Ansible implementation contains:

```text
ansible/
|-- inventory.ini
`-- playbook.yml
```

The playbook creates and manages Nexvion environment configuration and verifies the resulting state.

Ansible idempotency was demonstrated by executing the playbook a second time and obtaining:

```text
changed=0
failed=0
```

This confirms that Ansible detected the desired configuration was already present and made no unnecessary changes.

---

## 9. Kubernetes Deployment

Nexvion is deployed to a local Kubernetes environment using Minikube.

Kubernetes manifests are maintained in:

```text
k8s/
```

The implementation includes:

- Namespace
- Deployment
- Service
- ConfigMap
- Secret
- Ingress

The deployment runs two Nexvion replicas for application availability.

A healthy deployment was verified with:

```text
READY       2/2
UP-TO-DATE  2
AVAILABLE   2
```

---

## 10. Helm Package Management

The Kubernetes deployment is also packaged as a Helm chart.

The chart is located under:

```text
helm/nexvion/
```

The Helm release is deployed into the `nexvion-helm` namespace.

Deployment verification confirmed:

```text
STATUS: deployed
REVISION: 1
```

The Helm-managed deployment contains two healthy Nexvion application pods.

The configured ingress host is:

```text
nexvion-helm.local
```

---

## 11. Prometheus Monitoring

Prometheus is used to collect Kubernetes and application-environment metrics.

The monitoring stack was deployed into the Kubernetes `monitoring` namespace using the `kube-prometheus-stack` Helm chart.

Prometheus target verification confirmed that key monitoring components were successfully scraped.

PromQL was used to query Kubernetes deployment and pod health metrics.

---

## 12. Grafana Visualization

Grafana provides visual monitoring of Nexvion Kubernetes resources.

Monitoring evidence includes:

### Available Replicas

A Grafana Stat panel displays:

```text
Nexvion Helm - Available Replicas
2
```

This confirms two application replicas are available.

### Pod Readiness

A second panel monitors Nexvion pod readiness.

Both application pods reported:

```text
1
1
```

indicating that both replicas were in the Ready state.

---

## 13. Centralized Logging with ELK

Centralized logging is implemented using:

- Elasticsearch
- Logstash
- Kibana

The stack is deployed with Docker Compose.

Architecture:

```text
Nexvion Log
     |
     v
  Logstash
     |
     v
Elasticsearch
     |
     v
   Kibana
```

### Logstash

Logstash listens for JSON log events on TCP port `5044`.

It enriches events with:

```text
application = Nexvion
environment = production
```

and forwards them to the Elasticsearch index:

```text
nexvion-logs
```

### Elasticsearch

Elasticsearch runs on port `9200` and stores/searches centralized log data.

Successful ingestion was verified by the creation of the `nexvion-logs` index.

### Kibana

Kibana runs on port `5601`.

A `Nexvion Logs` data view was created, and Kibana Discover successfully displayed the indexed Nexvion log with fields including:

```text
application = Nexvion
environment = production
level = INFO
service = nexvion
```

This demonstrates end-to-end centralized log ingestion, indexing and visualization.

---

## 14. Monitoring vs Logging

The project intentionally uses separate systems for metrics and logs.

### Prometheus + Grafana

Used for operational metrics such as:

- Replica availability
- Pod readiness
- Kubernetes resource health

### ELK

Used for centralized log management, including:

- Log ingestion
- Metadata enrichment
- Indexing
- Search
- Analysis

Together, these provide improved observability of the Nexvion environment.

---

## 15. Security Considerations

Security practices implemented in the project include:

- Trivy Docker image vulnerability scanning
- Kubernetes Secrets for sensitive configuration
- `.gitignore` protection for Terraform state and local secret files
- Separation of configuration using ConfigMaps and Secrets
- Containerized deployment
- CI/CD-integrated security scanning

No production credentials should be committed directly to the repository.

---

## 16. Local Service Ports

| Service | Port |
|---|---:|
| Nexvion Docker | 8083 |
| Nexvion Docker Compose | 8084 |
| Jenkins | 8080 |
| Elasticsearch | 9200 |
| Logstash | 5044 |
| Kibana | 5601 |
| Prometheus | 9090 when locally forwarded |
| Grafana | 3000 when locally forwarded |

Port availability may depend on the local development environment and active port-forwarding sessions.

---

## 17. Key Verification Commands

### Docker

```bash
docker ps
```

### Kubernetes

```bash
kubectl get pods -n nexvion-helm
kubectl get deployment -n nexvion-helm
kubectl get ingress -n nexvion-helm
```

### Helm

```bash
helm list -n nexvion-helm
helm status nexvion -n nexvion-helm
```

### Terraform

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

### Ansible

```bash
ansible-playbook -i inventory.ini playbook.yml
```

### ELK

```bash
docker compose ps
curl http://localhost:9200
curl "http://localhost:9200/_cat/indices?v"
```

---

## AWS Cloud Deployment

Nexvion is deployed to Amazon Web Services (AWS) using Infrastructure as Code with Terraform.

The cloud deployment provisions:

- Amazon EC2 running Amazon Linux 2023
- Docker for application containerization
- Nginx for serving the Nexvion frontend
- AWS Security Group for HTTP and administrative SSH access
- AWS Elastic IP for a stable public endpoint
- Terraform for repeatable infrastructure provisioning

### Live Application

**[🚀 Open the Live Nexvion Application](http://16.192.138.63)**

The application is publicly accessible through an AWS Elastic IP, providing a stable endpoint for project demonstration and assessment.

### AWS Deployment Flow

```text
Nexvion Source Code
        |
        v
    Dockerfile
        |
        v
   Docker Image
        |
        v
     AWS EC2
        |
        v
 Docker + Nginx
        |
        v
Nexvion Application
        |
        v
Elastic IP: 16.192.138.63

## 18. Key Project Outcomes

The Nexvion DevOps Capstone demonstrates:

- Version-controlled DevOps configuration
- Automated operational scripting
- Dockerized application delivery
- CI/CD automation with Jenkins
- Integrated vulnerability scanning
- Infrastructure as Code with Terraform
- Configuration automation with Ansible
- Kubernetes orchestration
- Helm-based application packaging
- Prometheus metrics collection
- Grafana monitoring dashboards
- Centralized logging using the ELK stack
- End-to-end deployment verification

---

## Project Status

The core local DevOps implementation is operational and has been verified through deployment, monitoring, configuration-management, security-scanning and centralized-logging evidence.

Detailed implementation evidence, screenshots, architecture discussion, troubleshooting activities and lessons learned are documented in the accompanying Nexvion DevOps Capstone report.
