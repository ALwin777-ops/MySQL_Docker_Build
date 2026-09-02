# Terraform Docker Infrastructure & CI/CD Governance

An enterprise-grade **Infrastructure-as-Code (IaC) and CI/CD governance pipeline** for deploying a containerized database environment using **Terraform and Docker**.

The project combines Terraform-based infrastructure provisioning with automated **static analysis, security scanning, compliance checks, and Pull Request governance** using GitHub Actions.

The goal is to demonstrate a practical **DevSecOps workflow** where infrastructure code is validated and security-checked before it reaches the `main` branch.

---

## Architecture

```text
                              Developer
                                  |
                                  |
                         Git Commit / Push
                                  |
                                  v
                         +----------------+
                         |   GitHub Repo  |
                         +-------+--------+
                                 |
                                 |
                           Pull Request
                                 |
                                 v
                      +----------------------+
                      |    GitHub Actions     |
                      |      CI Pipeline      |
                      +----------+-----------+
                                 |
                 +---------------+---------------+
                 |               |               |
                 v               v               v
        +----------------+ +-----------+ +---------------+
        |    Terraform   | |  TFLint   | |    Checkov    |
        |    Validate    | |  Static   | | Security &    |
        |                | | Analysis  | | Compliance    |
        +-------+--------+ +-----+-----+ +-------+-------+
                |                |               |
                +----------------+---------------+
                                 |
                                 v
                      +----------------------+
                      |   Governance Gate    |
                      +----------+-----------+
                                 |
                         +-------+-------+
                         |               |
                       FAIL            PASS
                         |               |
                         v               v
                    Fix Changes        Merge
                                         |
                                         v
                                Terraform Apply
                                         |
                                         v
                              +------------------+
                              |      Docker      |
                              |   Infrastructure |
                              +--------+---------+
                                       |
                       +---------------+---------------+
                       |                               |
                       v                               v
                +--------------+               +--------------+
                |   MySQL 8.0  |               |  phpMyAdmin  |
                |   Database   |               | Management UI|
                +------+-------+               +------+-------+
                       |                              |
                       +---------------+--------------+
                                       |
                                       v
                              Docker Bridge Network
                               mysql_app_network
                              
# Terraform Docker Infrastructure & CI/CD Governance

An enterprise-grade **Infrastructure-as-Code (IaC) and CI/CD governance pipeline** for deploying a containerized database environment using **Terraform and Docker**.

The project combines Terraform-based infrastructure provisioning with automated **static analysis, security scanning, compliance checks, and Pull Request governance** using GitHub Actions.

The goal is to demonstrate a practical **DevSecOps workflow** where infrastructure code is validated and security-checked before it reaches the `main` branch.

---

## Architecture

```text
                              Developer
                                  |
                                  |
                         Git Commit / Push
                                  |
                                  v
                         +----------------+
                         |   GitHub Repo  |
                         +-------+--------+
                                 |
                                 |
                           Pull Request
                                 |
                                 v
                      +----------------------+
                      |    GitHub Actions     |
                      |      CI Pipeline      |
                      +----------+-----------+
                                 |
                 +---------------+---------------+
                 |               |               |
                 v               v               v
        +----------------+ +-----------+ +---------------+
        |    Terraform   | |  TFLint   | |    Checkov    |
        |    Validate    | |  Static   | | Security &    |
        |                | | Analysis  | | Compliance    |
        +-------+--------+ +-----+-----+ +-------+-------+
                |                |               |
                +----------------+---------------+
                                 |
                                 v
                      +----------------------+
                      |   Governance Gate    |
                      +----------+-----------+
                                 |
                         +-------+-------+
                         |               |
                       FAIL            PASS
                         |               |
                         v               v
                    Fix Changes        Merge
                                         |
                                         v
                                Terraform Apply
                                         |
                                         v
                              +------------------+
                              |      Docker      |
                              |   Infrastructure |
                              +--------+---------+
                                       |
                       +---------------+---------------+
                       |                               |
                       v                               v
                +--------------+               +--------------+
                |   MySQL 8.0  |               |  phpMyAdmin  |
                |   Database   |               | Management UI|
                +------+-------+               +------+-------+
                       |                              |
                       +---------------+--------------+
                                       |
                                       v
                              Docker Bridge Network
                               mysql_app_network
```

---

## Project Overview

This project provisions a local containerized database environment using Terraform.

Instead of manually creating Docker containers, networks, and volumes, Terraform is used to declaratively define and manage the infrastructure.

The project also implements CI/CD governance to ensure that Terraform configurations are:

- Properly formatted
- Syntactically valid
- Statistically analyzed
- Security scanned
- Checked for infrastructure misconfigurations
- Reviewed through Pull Requests before merging

---

## Key Features

### Infrastructure as Code

Terraform manages the complete Docker infrastructure.

The environment contains:

- MySQL 8.0 database container
- phpMyAdmin management interface
- Custom Docker bridge network
- Persistent MySQL storage volume
- Container configuration
- Database configuration

---

### Automated CI/CD Governance

GitHub Actions automatically executes infrastructure validation whenever changes are submitted through Pull Requests.

The CI pipeline performs:

- Terraform validation
- TFLint static analysis
- Checkov security scanning
- Infrastructure configuration checks

This provides an automated governance layer before infrastructure changes are merged.

---

### TFLint Static Analysis

**TFLint** is used to perform Terraform-specific static analysis.

It helps identify:

- Terraform configuration issues
- Provider-related problems
- Invalid resource configurations
- Unused declarations
- Terraform best-practice violations

TFLint provides early feedback before infrastructure changes are deployed.

---

### Checkov Security Scanning

**Checkov** is used to perform Infrastructure-as-Code security scanning.

It analyzes Terraform configuration for potential security and compliance issues.

Example checks include:

- Hardcoded secrets
- Insecure configurations
- Unnecessary network exposure
- Misconfigured resources
- Policy violations
- Compliance issues

Checkov provides a security gate within the CI/CD pipeline.

---

### Pre-Commit Automation

The project uses **pre-commit** for lightweight local developer automation.

The local hook is intentionally limited to Terraform formatting.

Install the hooks:

```bash
pre-commit install
```

Run the hooks manually:

```bash
pre-commit run --all-files
```

Terraform formatting:

```bash
terraform fmt -recursive
```

Heavy security scanning and static analysis are executed through GitHub Actions instead of requiring developers to install additional security engines locally.

---

## Technology Stack

| Technology | Purpose |
|------------|---------|
| Terraform | Infrastructure as Code |
| Docker | Containerization |
| MySQL 8.0 | Database |
| phpMyAdmin | Database Management |
| GitHub Actions | CI/CD Automation |
| TFLint | Terraform Static Analysis |
| Checkov | IaC Security Scanning |
| pre-commit | Local Git Hooks |
| HCL | Infrastructure Configuration |

---

## Infrastructure Components

### MySQL 8.0

MySQL is deployed as a Docker container and acts as the primary database.

The database uses persistent volume storage:

```text
mysql_data_volume
```

This allows database data to persist even if the MySQL container is recreated.

---

### phpMyAdmin

phpMyAdmin provides a browser-based interface for managing the MySQL database.

The interface is exposed locally on:

```text
http://localhost:8080
```

---

### Docker Network

The MySQL and phpMyAdmin containers communicate through a custom Docker bridge network:

```text
mysql_app_network
```

This provides an isolated communication network between the application containers.

---

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       └── terraform.yml
│
├── .pre-commit-config.yaml
├── .tflint.hcl
│
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
├── .gitignore
└── README.md
```

---

## Prerequisites

Make sure the following tools are installed before running the project locally.

### Required

- Git
- Docker
- Terraform
- pre-commit

Verify the installations:

```bash
git --version
docker --version
terraform version
pre-commit --version
```

---

## Quick Start

### 1. Clone the Repository

```bash
git clone <repository-url>
```

Navigate into the project directory:

```bash
cd <repository-directory>
```

---

### 2. Configure Terraform Variables

Copy the example Terraform variables file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit the file:

```bash
nano terraform.tfvars
```

Example:

```hcl
mysql_root_password = "change-me"
mysql_database      = "example_db"
mysql_user          = "example_user"
mysql_password      = "change-me"
```

> **Important:** Never commit real credentials to GitHub.

Make sure `terraform.tfvars` is included in `.gitignore`.

---

### 3. Initialize Terraform

Initialize the Terraform working directory:

```bash
terraform init
```

This downloads the required Terraform provider and initializes the project.

---

### 4. Format Terraform Configuration

Run Terraform formatting:

```bash
terraform fmt -recursive
```

---

### 5. Validate Terraform Configuration

Run Terraform validation:

```bash
terraform validate
```

Expected result:

```text
Success! The configuration is valid.
```

---

### 6. Run Terraform Plan

Review the infrastructure that Terraform will create:

```bash
terraform plan
```

This allows you to inspect the planned infrastructure changes before deployment.

---

### 7. Deploy the Infrastructure

Apply the Terraform configuration:

```bash
terraform apply
```

Terraform will display the planned changes.

Confirm the deployment by entering:

```text
yes
```

---

## Access phpMyAdmin

After the infrastructure has been deployed, open:

```text
http://localhost:8080
```

Log in using the MySQL credentials configured in `terraform.tfvars`.

---

## Verify Docker Resources

List running containers:

```bash
docker ps
```

You should see the MySQL and phpMyAdmin containers.

Check Docker networks:

```bash
docker network ls
```

Check Docker volumes:

```bash
docker volume ls
```

---

## CI/CD Pipeline

The GitHub Actions pipeline provides automated infrastructure governance.

### Pipeline Triggers

The workflow runs when:

- Code is pushed to `main`
- A Pull Request targets `main`
- A Pull Request is updated

---

## CI/CD Workflow

```text
Developer
    |
    v
Code Change
    |
    v
Pull Request
    |
    v
+-----------------------+
|   GitHub Actions      |
+-----------+-----------+
            |
            v
+-----------------------+
| Terraform Validate    |
+-----------+-----------+
            |
            v
+-----------------------+
| TFLint                |
| Static Analysis       |
+-----------+-----------+
            |
            v
+-----------------------+
| Checkov               |
| Security Scanning     |
+-----------+-----------+
            |
            v
+-----------------------+
| Governance Gate       |
+-----------+-----------+
            |
       +----+----+
       |         |
      FAIL      PASS
       |         |
       v         v
   Fix Code    Merge
                 |
                 v
            Deployment
```

---

## Governance Model

The project follows a **Shift-Left DevSecOps** model.

### Local Development

Developers receive lightweight feedback before committing changes.

```text
Developer
    |
    v
pre-commit
    |
    v
terraform fmt
    |
    v
Git Commit
```

---

### CI/CD Environment

More comprehensive checks are executed centrally in GitHub Actions.

```text
Pull Request
     |
     +----------------------+
     |                      |
     v                      v
Terraform Validate        TFLint
     |                      |
     +----------+-----------+
                |
                v
             Checkov
                |
                v
       Security & Quality
           Gate
                |
         +------+------+
         |             |
        FAIL          PASS
         |             |
         v             v
    Fix Changes       Merge
```

This approach provides:

- Fast local developer feedback
- Centralized security enforcement
- Consistent CI/CD validation
- Reduced local tooling requirements
- Automated governance

---

## Security Considerations

This project demonstrates security controls at the **Infrastructure-as-Code level**.

The following security practices are implemented:

- Automated IaC security scanning
- Terraform static analysis
- Pull Request governance
- Automated configuration validation
- Local formatting enforcement
- Separation of secrets from source code
- Isolated Docker networking
- Persistent database storage

---

## Secrets Management

Do not store sensitive credentials directly in Terraform source files.

### Avoid

```hcl
mysql_password = "MyRealPassword123!"
```

### Use

```text
terraform.tfvars
```

for local development and ensure the file is excluded from Git.

For production environments, use a dedicated secrets-management solution such as:

- AWS Secrets Manager
- Azure Key Vault
- HashiCorp Vault
- GitHub Actions Secrets

---

## Destroy Infrastructure

To remove all resources created by Terraform:

```bash
terraform destroy
```

Confirm the operation when prompted:

```text
yes
```

This removes the Terraform-managed Docker resources.

---

## Why This Project?

Traditional infrastructure deployment can involve manually creating and configuring resources.

This project demonstrates how those tasks can be automated using Infrastructure as Code and integrated into a secure CI/CD workflow.

### Traditional Approach

```text
Manual Configuration
        |
        v
Manual Review
        |
        v
Manual Deployment
```

### Automated Approach

```text
Code
 |
 v
Terraform
 |
 v
Automated Validation
 |
 v
Security Scanning
 |
 v
Governance Gate
 |
 v
Deployment
```

This improves:

- Consistency
- Repeatability
- Security
- Auditability
- Developer productivity
- Infrastructure governance

---

## DevSecOps Approach

The project integrates security directly into the infrastructure delivery lifecycle.

```text
        PLAN
         |
         v
      DEVELOP
         |
         v
       FORMAT
         |
         v
       COMMIT
         |
         v
    PULL REQUEST
         |
         v
     VALIDATION
         |
         v
    STATIC ANALYSIS
         |
         v
   SECURITY SCANNING
         |
         v
   GOVERNANCE GATE
         |
         v
       MERGE
         |
         v
      DEPLOY
```

Security is therefore treated as part of the development and deployment process rather than as a separate final-stage activity.

---

## Future Enhancements

The project can be extended with additional DevSecOps and cloud capabilities.

Potential improvements include:

- Terraform remote state
- State locking
- AWS infrastructure deployment
- Azure infrastructure deployment
- Terraform Cloud
- Trivy container image scanning
- SAST integration
- DAST integration
- OPA/Conftest policy enforcement
- Secret management integration
- Environment separation
- Development/Staging/Production workflows
- Terraform drift detection
- Manual production approval gates
- Infrastructure cost estimation
- Container runtime security
- Centralized logging and monitoring

---

## Learning Objectives

This project demonstrates practical experience with:

- Infrastructure as Code
- Terraform
- Docker
- GitHub Actions
- CI/CD
- DevSecOps
- Infrastructure security
- Policy-as-Code
- Static analysis
- Pull Request governance
- Security automation
- Containerized infrastructure

---

## Project Workflow Summary

```text
                    +------------------+
                    |    Terraform     |
                    | Infrastructure   |
                    +--------+---------+
                             |
                             v
                    +------------------+
                    |      Docker      |
                    +--------+---------+
                             |
                  +----------+----------+
                  |                     |
                  v                     v
            +-----------+         +------------+
            |   MySQL   |         | phpMyAdmin |
            |    8.0    |         |            |
            +-----------+         +------------+


Developer Workflow:

        Code
         |
         v
   Pre-commit / fmt
         |
         v
   Pull Request
         |
         v
  GitHub Actions
         |
    +----+----+
    |    |    |
    v    v    v
   TF   TFL  Checkov
 Validate
    |    |    |
    +----+----+
         |
         v
  Governance Gate
         |
         v
       Merge
```

---

## Project Goals

The primary goal of this project is to demonstrate how **Infrastructure as Code, CI/CD automation, security scanning, and governance controls** can be integrated into a single development workflow.

The project provides a foundation for implementing enterprise-style **DevSecOps infrastructure pipelines** while keeping the initial environment simple and reproducible.

---

## License

This project is intended for educational, demonstration, and portfolio purposes.