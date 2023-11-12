resource "docker_image" "minio" {
  name = "quay.io/minio/minio:RELEASE.2023-08-16T20-17-30Z"
}

resource "docker_container" "minio" {
  name  = "minio"
  image = docker_image.minio.image_id

  user = "1000:1000"

  restart = "unless-stopped"

  command = [

    "minio", "server", "--console-address=:9001"
  ]
  volumes {
    container_path = "/mnt/data"
    host_path      = var.minio_host_path
  }

  ports {
    internal = 9000
    external = 9000
  }

  ports {
    internal = 9001
    external = 9001
  }

  env = [
    "MINIO_ROOT_USER=${var.minio_root_user}",
    "MINIO_ROOT_PASSWORD=${var.minio_root_password}",
    "MINIO_VOLUMES=/mnt/data",
  ]

}

