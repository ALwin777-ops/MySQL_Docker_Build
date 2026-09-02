# Terraform Docker MySQL Environment

Containerized MySQL database infrastructure provisioned locally via Terraform.

## Architecture
* **Database:** MySQL 8.0 with persistent volume storage (`mysql_data_volume`)
* **Management UI:** phpMyAdmin running on `http://localhost:8080`
* **Networking:** Isolated custom bridge network (`mysql_app_network`)

## Quickstart

1. **Clone directory and configure variables:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Update terraform.tfvars with your local credentials