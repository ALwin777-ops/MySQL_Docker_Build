variable "mysql_root_password" {
  description = "Root password for MySQL database"
  type        = string
  sensitive   = true
}

variable "mysql_database" {
  description = "Default database name to create"
  type        = string
  default     = "app_db"
}
variable "mysql_user" {
  description = "Normal non-root database user"
  type        = string
  default     = "app_user"
}

variable "mysql_password" {
  description = "Password for normal database user"
  type        = string
  sensitive   = true
}
variable "phpmyadmin_port" {
  description = "Host port for accessing phpMyAdmin UI"
  type        = number
  default     = 8080
}



