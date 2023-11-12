resource "docker_image" "postgis" {
  name = "postgis"
  build {
    context = local.pg_dockerfile_context
  }
}

resource "docker_container" "pg" {
  name  = "pg"
  image = docker_image.postgis.image_id

  restart = "unless-stopped"

  volumes {
    container_path = "/var/lib/postgresql/data"
    host_path      = var.postgres_volume_host_path
  }

  ports {
    internal = 5432
    external = 5432
  }

  env = [
    "POSTGRES_PASSWORD=${var.postgres_password}"
  ]

}

