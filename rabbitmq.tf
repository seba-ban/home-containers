resource "docker_image" "rabbit" {
  name = "rabbitmq:3.12.8-management-alpine"
}

resource "docker_network" "seen_places" {
  name = "seen-places-network"
}

resource "docker_container" "rabbit" {
  name     = "rabbit"
  image    = docker_image.rabbit.image_id
  hostname = "rabbit"

  networks_advanced {
    name = docker_network.seen_places.id
  }

  restart = "unless-stopped"

  volumes {
    container_path = "/var/lib/rabbitmq"
    host_path      = var.rabbitmq_host_path
  }

  ports {
    internal = 15672
    external = 15672
  }

  ports {
    internal = 5672
    external = 5672
  }

  env = [
    "RABBITMQ_DEFAULT_USER=${var.rabbitmq_root_user}",
    "RABBITMQ_DEFAULT_PASS=${var.rabbitmq_root_password}",
    "RABBITMQ_DATA_DIR=/var/lib/rabbitmq",
  ]

}

