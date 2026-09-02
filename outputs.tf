output "phpmyadmin_url" {
  description = "URL to access phpMyAdmin UI"
  value       = "http://localhost:${var.phpmyadmin_port}"
}

output "mysql_container_name" {
  description = "Name of the running MySQL container"
  value       = docker_container.mysql_db.name
}