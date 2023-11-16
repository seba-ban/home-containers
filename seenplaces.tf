resource "docker_image" "seen_places" {
  name = "seen_places"
  build {
    context = local.seen_places_dockerfile_context
    target  = "production"
  }
}

resource "docker_image" "seen_places_garmin" {
  name = "seen_places_garmin"
  build {
    context = local.seen_places_garmin_dockerfile_context
    target  = "production"
  }
}

resource "docker_image" "seen_places_gopro" {
  name = "seen_places_gopro"
  build {
    context = local.seen_places_gopro_dockerfile_context
    target  = "production"
  }
}

resource "docker_container" "seen_places_server" {
  name  = "seen_places_server"
  image = docker_image.seen_places.image_id

  restart = "unless-stopped"

  command = [
    "server"
  ]

  networks_advanced {
    name = docker_network.seen_places.id
  }

  ports {
    internal = 8080
    external = 8080
  }

  volumes {
    container_path = "/data/storage"
    host_path      = var.seen_places_storage_host_dir
  }

  env = [
    "DB_USER=${var.seen_places_db_user}",
    "DB_PASSWORD=${var.seen_places_db_password}",
    "DB_HOST=${var.seen_places_db_host}",
    "DB_PORT=${var.seen_places_db_port}",
    "DB_NAME=${var.seen_places_db_name}",
    "DB_SSLMODE=${var.seen_places_db_sslmode}",

    "BROKER_HOST=${var.seen_places_broker_host}",
    "BROKER_PORT=${var.seen_places_broker_port}",
    "BROKER_USER=${var.seen_places_broker_user}",
    "BROKER_PASSWORD=${var.seen_places_broker_password}",

    "S3_RAW_FILES_BUCKET=${var.seen_places_s3_raw_files_bucket}",
    "S3_ACCESS_KEY=${var.seen_places_s3_access_key}",
    "S3_SECRET_KEY=${var.seen_places_s3_secret_key}",
    "S3_ENDPOINT_URL=${var.seen_places_s3_endpoint_url}",

    "POINTS_SAVE_CHANNEL=${var.seen_places_points_queue}",
    "GOPRO_POINTS_EXTRACT_CHANNEL=${var.seen_places_gopro_queue}",
    "GARMIN_POINTS_EXTRACT_CHANNEL=${var.seen_places_garmin_queue}",
  ]
}

resource "docker_container" "seen_places_dbsaver" {
  name  = "seen_places_dbsaver"
  image = docker_image.seen_places.image_id

  restart = "unless-stopped"

  command = [
    "dbSaver"
  ]

  networks_advanced {
    name = docker_network.seen_places.id
  }

  volumes {
    container_path = "/data/storage"
    host_path      = var.seen_places_storage_host_dir
  }

  env = docker_container.seen_places_server.env
}

resource "docker_container" "seen_places_s3observer" {
  name  = "seen_places_s3observer"
  image = docker_image.seen_places.image_id

  restart = "unless-stopped"

  command = [
    "s3Observer"
  ]

  networks_advanced {
    name = docker_network.seen_places.id
  }

  volumes {
    container_path = "/data/storage"
    host_path      = var.seen_places_storage_host_dir
  }

  volumes {
    container_path = "/data/tmp"
    host_path      = var.seen_places_storage_tmp_dir
  }

  env = docker_container.seen_places_server.env
}

resource "docker_container" "seen_places_garmin" {
  name  = "seen_places_garmin"
  image = docker_image.seen_places_garmin.image_id

  restart = "unless-stopped"

  networks_advanced {
    name = docker_network.seen_places.id
  }

  volumes {
    container_path = "/data/storage"
    host_path      = var.seen_places_storage_host_dir
  }

  env = [
    "BROKER_HOST=${var.seen_places_broker_host}",
    "BROKER_PORT=${var.seen_places_broker_port}",
    "BROKER_USERNAME=${var.seen_places_broker_user}",
    "BROKER_PASSWORD=${var.seen_places_broker_password}",
    "BROKER_WORK_QUEUE=${var.seen_places_garmin_queue}",
    "BROKER_TARGET_QUEUE=${var.seen_places_points_queue}",
  ]
}

resource "docker_container" "seen_places_gopro" {
  name  = "seen_places_gopro"
  image = docker_image.seen_places_gopro.image_id

  restart = "unless-stopped"

  networks_advanced {
    name = docker_network.seen_places.id
  }

  volumes {
    container_path = "/data/storage"
    host_path      = var.seen_places_storage_host_dir
  }

  env = [
    "RABBITMQ_HOST=${var.seen_places_broker_host}",
    "RABBITMQ_PORT=${var.seen_places_broker_port}",
    "RABBITMQ_USERNAME=${var.seen_places_broker_user}",
    "RABBITMQ_PASSWORD=${var.seen_places_broker_password}",
    "RABBITMQ_WORK_QUEUE=${var.seen_places_gopro_queue}",
    "RABBITMQ_TARGET_QUEUE=${var.seen_places_points_queue}",
  ]
}
