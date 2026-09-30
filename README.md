# Nexvion DevOps Capstone Project

## Project Overview

Nexvion is an e-commerce frontend application used for the implementation of a complete DevOps workflow.

The application was provided as an existing project. The focus of this capstone is to design and implement the DevOps processes required to build, containerize, automate, deploy, monitor, secure, and manage the application.

## Application Stack

The supplied Nexvion application is a static frontend application built with:

- HTML
- CSS
- JavaScript
- LocalStorage for demonstration of cart and authentication functionality
- Nginx for serving the application inside Docker

## DevOps Objectives

This capstone demonstrates the use of DevOps practices and tools including:

- Git and GitHub for version control
- Bash for operational automation
- Docker for containerization
- Docker Compose for service definition and deployment
- Jenkins for CI/CD automation
- Terraform for infrastructure provisioning
- Ansible for configuration management
- Kubernetes for container orchestration
- Helm for Kubernetes application packaging
- Prometheus for metrics collection
- Grafana for monitoring and visualization
- Centralized logging and log analysis
- Security scanning and DevSecOps practices
- AI-assisted incident analysis

## Current Implementation

Completed so far:

- Application assessment
- Git and GitHub repository setup
- Dockerfile creation
- Docker image build
- Docker container deployment
- Docker Compose configuration
- Bash environment setup automation
- Bash deployment automation
- Application health checking
- Project backup automation
- Docker cleanup automation

## Bash Automation

Operational scripts are stored in the `scripts/` directory:

- `setup.sh` - validates the deployment environment
- `deploy.sh` - automates Docker build and deployment
- `health-check.sh` - verifies application availability
- `backup.sh` - creates timestamped application backups
- `cleanup.sh` - removes unused Docker build resources

## Containerization

The Nexvion application is served using Nginx inside a Docker container.

Manual Docker deployment is available on:

`http://localhost:8083`

Docker Compose deployment is available on:

`http://localhost:8084`

## Repository Workflow

Development changes are made on dedicated branches and merged into `main` through Pull Requests.

Example workflow:

`main → feature/docs branch → commit → push → Pull Request → review → merge`

## Project Status

Implementation is in progress as part of the Nexvion DevOps Capstone Project.