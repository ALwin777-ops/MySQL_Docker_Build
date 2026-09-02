# Private container network
resource "docker_network" "db_network" {
  name = "mysql_app_network"
}

# Persistent volume for MySQL database files
resource "docker_volume" "mysql_data" {
  name = "mysql_data_volume"
}

# MySQL Image
resource "docker_image" "mysql" {
  name         = "mysql:8.0"
  keep_locally = true
}

# phpMyAdmin Image
resource "docker_image" "phpmyadmin" {
  name         = "phpmyadmin/phpmyadmin:latest"
  keep_locally = true
}

# MySQL Server Container
resource "docker_container" "mysql_db" {
  name  = "mysql_server"
  image = docker_image.mysql.image_id

  env = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
    "MYSQL_DATABASE=${var.mysql_database}",
    "MYSQL_USER=${var.mysql_user}",
    "MYSQL_PASSWORD=${var.mysql_password}"
  ]

  restart = "unless-stopped"

  healthcheck {
    test     = ["CMD", "mysqladmin", "ping", "-h", "localhost"]
    interval = "10s"
    timeout  = "5s"
    retries  = 3
  }

  networks_advanced {
    name = docker_network.db_network.name
  }

  mounts {
    target = "/var/lib/mysql"
    source = docker_volume.mysql_data.name
    type   = "volume"
  }

  ports {
    internal = 3306
    external = 3307
  }
}

# phpMyAdmin Container
resource "docker_container" "phpmyadmin" {
  name  = "phpmyadmin_ui"
  image = docker_image.phpmyadmin.image_id

  env = [
    "PMA_HOST=mysql_server",
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}"
  ]

  networks_advanced {
    name = docker_network.db_network.name
  }

  ports {
    internal = 80
    external = var.phpmyadmin_port
  }

  depends_on = [docker_container.mysql_db]
}